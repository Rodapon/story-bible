# The Rift Convergence: Story Bible

The interactive Story Bible as a multi-page website for **GitHub Pages**. Lore entries are
plain Markdown files in folders. Upload a file and it is detected automatically: it gets its
own page, appears in the dictionary, and its name is highlighted as a keyword across the site.

```
/                         Home
/dictionary/              Every entry A–Z, by category, plus "Wanted entries"
/characters/oathbreaker/  ← characters/oathbreaker.md
/worlds/ancient-kingdom/  ← worlds/ancient-kingdom.md
/locations/library/       ← locations/library.md
/factions/stewards/       ← factions/stewards.md
/artifacts/codex/         ← artifacts/codex.md
/concepts/spiritus/       ← concepts/spiritus.md
/canon/                   Current established canon (+ /canon/retcons/, /canon/audit/, /canon/authorship/)
/sources/core/            Original Core Source [CS]
/sources/expansion/       Expansion document [EX] v2.3
/archive/                 21 historical files, one page each
/legacy/original-story-bible.html   The original single-file bible, unchanged (works offline)
```

## Publish

1. Create a GitHub repository and upload the contents of this folder (keep the folder
   structure, including the folders that start with `_`).
2. **Settings → Pages → Build and deployment → Deploy from a branch**, branch `main`,
   folder `/ (root)`, **Save**.
3. The site appears at `https://<user>.github.io/<repository>/` after a minute or two.

GitHub Pages runs Jekyll for you, so there is no build step and nothing to install.
GitHub Pages sites are **public**. Don't enable Pages if the bible must stay private.

## Add lore

See **[CONTRIBUTING.md](CONTRIBUTING.md)**. In short:

- Upload `characters/the-broker.md` with a `# The Broker` heading and a sentence or two.
- Mark nouns as keywords with `[[Double Brackets]]`, or `[[Soul|souls]]` to change the
  displayed text.
- Copy [`_templates/entry-template.md`](_templates/entry-template.md) for summary, aliases,
  sources and attribution fields.

## How it fits together

| Path | Purpose |
|---|---|
| `_config.yml` | Site settings and the plugins GitHub Pages runs |
| `_data/categories.yml` | Category labels, colours and order (new folders work without an entry here) |
| `_includes/entries.html` | The auto-detection rule: any `.md` inside a folder is an entry |
| `_layouts/` | Page templates: `default`, `entry`, `document`, `category` |
| `assets/js/lore.js` | Keyword highlighting, `[[ ]]` marks, search, return-to-reading |
| `assets/css/site.css` | Styles (the original dark fantasy theme) |
| `tools/split-legacy.ps1` | One-time script that split the original HTML into pages |

Features carried over from the single-file bible: colour-coded keyword highlighting with an
on/off toggle, the collapsible **Ask the Story Bible** and **Lore Reference Directory** panels
on every page, return to your reading position when a panel closes, unanswered-state search,
and the authorship legend. Search now covers every page on the site.

## Preview locally (optional)

Requires Ruby. From this folder: `bundle install`, then `bundle exec jekyll serve`, then open
http://localhost:4000. Without Ruby, open `legacy/original-story-bible.html` for the original.

## Editing rules

See [EDITORIAL_RULES.md](EDITORIAL_RULES.md).
