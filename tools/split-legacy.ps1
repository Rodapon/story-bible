<#
  split-legacy.ps1
  One-time conversion of the single-file Story Bible (legacy/original-story-bible.html)
  into Jekyll pages for GitHub Pages. Lore text is copied verbatim; only the outer page
  shell is replaced and in-page "#anchor" links are re-pointed to the page that now
  holds that anchor.

  Usage (from the repository root):
    powershell -ExecutionPolicy Bypass -File tools/split-legacy.ps1

  Re-running overwrites canon/, sources/ and archive/ generated pages. Do not re-run after
  editing those pages by hand unless you intend to discard the edits.
#>
param(
  [string]$Source = (Join-Path $PSScriptRoot '..\legacy\original-story-bible.html'),
  [string]$Root   = (Join-Path $PSScriptRoot '..')
)
$ErrorActionPreference = 'Stop'
$Root = (Resolve-Path $Root).Path
$utf8 = New-Object System.Text.UTF8Encoding($false)
$html = [IO.File]::ReadAllText((Resolve-Path $Source).Path, $utf8)

function Between([string]$text, [string]$start, [string]$end, [int]$from = 0) {
  $a = $text.IndexOf($start, $from)
  if ($a -lt 0) { throw "Marker not found: $start" }
  $b = $text.IndexOf($end, $a + $start.Length)
  if ($b -lt 0) { throw "End marker not found: $end" }
  return @{ Text = $text.Substring($a, $b - $a); End = $b }
}

$mainStart = $html.IndexOf('<section id="attribution">')
$mainEnd   = $html.IndexOf('</main>')
$main = $html.Substring($mainStart, $mainEnd - $mainStart)

$pages = New-Object System.Collections.ArrayList
function Add-Page($url, $title, $section, $order, $body, $extra = '') {
  [void]$pages.Add([pscustomobject]@{ Url = $url; Title = $title; Section = $section; Order = $order; Body = $body.Trim(); Extra = $extra })
}

$attr    = Between $main '<section id="attribution">' '<section id="retcon-index">'
$retcon  = Between $main '<section id="retcon-index">' '<section id="canon">'
$canon   = Between $main '<section id="canon">' '<section id="audit">'
$audit   = Between $main '<section id="audit">' '<section id="core">'
$core    = Between $main '<section id="core">' '<section id="expansion">'
$exp     = Between $main '<section id="expansion">' '<section id="archive">'
$archive = $main.Substring($main.IndexOf('<section id="archive">'))

Add-Page '/canon/'            'Current established canon'            'canon'   1 $canon.Text   "edition_tags: [EX, SLA, CURRENT]"
Add-Page '/canon/authorship/' 'Expansion authorship registry'        'canon'   2 $attr.Text
Add-Page '/canon/retcons/'    'Retcon contents & editor change log'  'canon'   3 $retcon.Text  "edition_tags: [EDITORIAL INDEX]"
Add-Page '/canon/audit/'      'Plot-hole and continuity audit'       'canon'   4 $audit.Text   "edition_tags: [EDITORIAL]"
Add-Page '/sources/core/'     'Original Core Source [CS]'            'sources' 1 $core.Text    "edition_tags: [CS, ORIGINAL SOURCE - UNALTERED]"
Add-Page '/sources/expansion/' 'Expansion document [EX] - Sanctum & Sovereignty v2.3' 'sources' 2 $exp.Text "edition_tags: [EX, HISTORICAL VERSION 2.3]"

# Archive: intro + one page per historical file
$firstDetails = $archive.IndexOf('<details>')
$archiveIntro = $archive.Substring(0, $firstDetails) + '</section>'
$chunks = $archive.Substring($firstDetails) -split '<details><summary>'
$order = 0
$archiveList = New-Object System.Collections.ArrayList
foreach ($chunk in $chunks) {
  if (-not $chunk.Trim()) { continue }
  $order++
  $sumEnd = $chunk.IndexOf('</summary>')
  $summary = $chunk.Substring(0, $sumEnd)
  $fileName = (($summary -replace '<span[^>]*>.*?</span>', '') -replace '<[^>]+>', '').Trim()
  $body = $chunk.Substring($sumEnd + '</summary>'.Length)
  $body = $body -replace '</details>\s*(</section>)?\s*$', ''
  $slug = ($fileName -replace '\.md$', '').ToLower() -replace '[^a-z0-9]+', '-'
  $slug = $slug.Trim('-')
  Add-Page "/archive/$slug/" $fileName 'archive' $order ("<div class=`"archive-file`" data-file=`"$fileName`">" + $body.Trim() + '</div>') "source_file: `"$fileName`"`nedition_tags: [ARCHIVE]"
  [void]$archiveList.Add($fileName)
}

# Map every id to the page that holds it, then re-point "#id" links that left their page.
$idMap = @{}
foreach ($p in $pages) {
  foreach ($m in [regex]::Matches($p.Body, '\sid="([^"]+)"')) {
    if (-not $idMap.ContainsKey($m.Groups[1].Value)) { $idMap[$m.Groups[1].Value] = $p.Url }
  }
}
# The archive intro section lives on /archive/
foreach ($m in [regex]::Matches($archiveIntro, '\sid="([^"]+)"')) { $idMap[$m.Groups[1].Value] = '/archive/' }

function Relative($fromUrl, $toUrl) {
  $depth = ($fromUrl.Trim('/') -split '/').Where({ $_ }).Count
  return ('../' * $depth) + $toUrl.TrimStart('/')
}
$unresolved = @{}
foreach ($p in $pages) {
  $p.Body = [regex]::Replace($p.Body, 'href="#([^"]+)"', {
    param($m)
    $id = $m.Groups[1].Value
    if ($idMap.ContainsKey($id) -and $idMap[$id] -ne $p.Url) { return 'href="' + (Relative $p.Url $idMap[$id]) + '#' + $id + '"' }
    if (-not $idMap.ContainsKey($id)) { $unresolved[$id] = $true }
    return $m.Value
  })
}

function Yaml([string]$s) { return '"' + $s.Replace('\', '\\').Replace('"', '\"') + '"' }
foreach ($p in $pages) {
  $dir = Join-Path $Root ($p.Url.Trim('/') -replace '/', '\')
  New-Item -ItemType Directory -Force $dir | Out-Null
  $fm = @('---', 'layout: document', "title: $(Yaml $p.Title)", "section: $($p.Section)", "order: $($p.Order)")
  if ($p.Extra) { $fm += $p.Extra }
  $fm += 'generated: true'
  $fm += '---'
  $content = ($fm -join "`n") + "`n<!-- Generated from legacy/original-story-bible.html by tools/split-legacy.ps1. Lore text is verbatim. -->`n{% raw %}`n" + $p.Body + "`n{% endraw %}`n"
  [IO.File]::WriteAllText((Join-Path $dir 'index.html'), $content, $utf8)
}

# Archive index page
$archiveDir = Join-Path $Root 'archive'
$intro = @('---', 'layout: document', 'title: "Historical files"', 'section: archive', 'order: 0', 'archive_index: true', '---',
  '{% raw %}', $archiveIntro.Trim(), '{% endraw %}',
  '<ul class="archive-list">',
  '{% assign files = site.pages | where: "section", "archive" | where_exp: "p", "p.archive_index != true" | sort: "order" %}',
  '{% for f in files %}<li><a href="{{ f.url | relative_url }}">{{ f.title }}</a> <span class="tag">ARCHIVE</span></li>{% endfor %}',
  '</ul>') -join "`n"
[IO.File]::WriteAllText((Join-Path $archiveDir 'index.html'), $intro + "`n", $utf8)

# Report
"Pages written: $($pages.Count + 1)"
"Unresolved in-page links: " + (($unresolved.Keys | Sort-Object) -join ', ')
"Heading locations used by dictionary entries:"
foreach ($n in 8, 15, 16, 17, 18, 19, 25, 26, 34, 63, 64, 333) { "  lore-source-heading-$n -> $($idMap["lore-source-heading-$n"])" }
