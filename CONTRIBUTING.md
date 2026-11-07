# Adding and editing lore

Everything happens on GitHub's website. No software to install.

## Add a new entry (character, world, location, …)

1. Open the folder on GitHub, for example `characters/`.
2. Click **Add file → Upload files** and drop in a Markdown file (`.md`), or
   **Add file → Create new file** to type one in the browser.
3. Name the file after the entry, in lowercase with hyphens:
   `characters/the-broker.md`, `worlds/earth.md`, `locations/glass-citadel.md`.
4. Click **Commit changes**.

About a minute later the site rebuilds and:

- the entry has its own page at `/characters/the-broker/`
- it appears in the **Lore Reference Directory**, the **Dictionary**, and the category page
- its title (and any aliases) is **highlighted as a keyword on every page**
- the **Ask the Story Bible** search includes it

### The smallest possible entry

```markdown
# The Broker

The influential broker who held the [[Oathbreaker]]'s hometown hostage.
```

The first `# Heading` becomes the dictionary term. That's all that is required.

### A full entry

Copy [`_templates/entry-template.md`](_templates/entry-template.md). The front matter
(the block between `---` lines) lets you add:

| Field | What it does |
|---|---|
| `title` | The dictionary term. Overrides the first heading. |
| `summary` | One sentence for the directory card and hover text. |
| `aliases` | Other forms to highlight, e.g. `Steward` for **Stewards**. |
| `keywords` | Related terms listed in the "Keywords in this entry" box. |
| `status` | A label such as `canon`, `proposed`, `archival`. |
| `sources` | Links to the passages the entry is based on. |
| `attribution` | `origin:` and `development:` editor tags, shown as a table. |
| `category` | Overrides the folder-based category. |
| `entry: false` | Publishes the page but keeps it out of the dictionary. |

## Marking keywords and nouns

Inside any entry, wrap important nouns in double square brackets:

| You write | Shows | Links to |
|---|---|---|
| `[[Wyrm]]` | Wyrm | the Wyrm entry |
| `[[Soul\|souls]]` | souls | the Soul entry |
| `[[Glass Gate]]` | Glass Gate (dashed underline) | nothing yet: listed under **Wanted entries** |

Names that already have an entry are highlighted automatically even without brackets.
Brackets are for marking a noun on purpose, including ones that don't have an entry yet.
Headings are never highlighted.

## New categories

Create a new top-level folder (e.g. `creatures/`) and upload entries into it. It is
detected automatically and gets a default colour. To give it a label, colour, and
position in the menu, add it to [`_data/categories.yml`](_data/categories.yml). To give it
a page at `/creatures/`, add `creatures/index.md` containing:

```markdown
---
layout: category
title: Creatures
---
```

## Canon, sources and archive pages

`canon/`, `sources/` and `archive/` hold the original Story Bible text, split into pages
by `tools/split-legacy.ps1`. Edit them directly (they are HTML). Follow
[EDITORIAL_RULES.md](EDITORIAL_RULES.md): preserve canon wording, log retcons in
`canon/retcons/index.html`, and keep attribution.

Leave the `{% raw %}` and `{% endraw %}` lines in place; they stop the site generator from
misreading the lore text.
