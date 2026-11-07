# Editorial consistency rules

- Preserve established canon verbatim unless an approved retcon explicitly changes it.
- Distinguish confirmed lore from proposed theories and intentionally unresolved mysteries. Use the entry `status:` field (`canon`, `proposed`, `archival`) when an entry is not established canon.
- Preserve the expansion authorship registry and original creator credits: Ancient Kingdom and Wyrm `[EX][SPA]`; Stewards and Queen `[EX][PDN]`. Retain separate attribution for later expansions (entries carry this in their `attribution:` field).
- Log approved retcons in `canon/retcons/index.html` with the affected section, editor, date, and explanation.
- Every new established entity, faction, artifact, location or soul mechanic gets its own entry file with a one-sentence `summary:` and a working `sources:` link. The Lore Reference Directory and Dictionary are generated from these files and stay in alphabetical order automatically.
- Keep keyword links and source anchors (`lore-source-heading-N`) working. Do not highlight headings.
- Keep Ask the Story Bible and Lore Reference Directory collapsible, and preserve return-to-reading behavior on close (`assets/js/lore.js`).
- When no source supports an answer, show an unanswered state instead of inventing lore.
- Keep the existing fantasy heading style and color-coded terms unless deliberately redesigned. Category colours live in `_data/categories.yml`.
- Do not delete historical source pages in `archive/` or `sources/`; mark superseded material as archival instead.
- Test navigation, toggles, search, and keyword highlighting after modifying layouts or scripts.

## Detailed rules (verbatim from the original Story Bible)

1. Preserve existing canon wording unless an editor explicitly approves a retcon. Prefer addenda and targeted amendments over silent rewrites.
2. Keep established canon, proposed theories, unresolved questions, and archived/superseded drafts visibly distinct. Never silently promote a proposal to canon.
3. Preserve authorship provenance: [CS] original core source; [EX][SPA] original Ancient Kingdom and Wyrm; [EX][PDN] original Stewards and Queen; [EX][SLA] subsequent user expansions; [SD] only when shared authorship is confirmed. Do not infer ownership.
4. Keep the Spiritus definition verbatim: “The innate ability to strengthen one’s own Sovereignty.” Higher Sovereignty makes Sanctum harder to lower and resists Siphoning even if lowered. Sanctum governs access; Sovereignty retains authority and resistance.
5. Distinguish Steward Soulcraft/Transmogrification from the Wyrm’s physical manifestation. The Wyrm may maintain multiple nonphysical soul contracts but only one physical manifestation at a time. Predictive influence is not control of outcomes.
6. Do not invent resolutions to intentional mysteries (Wyrm's ultimate purpose, Queen's motives, soul's ultimate fate, ancient royal survival, etc.). Do not assert that stronger souls definitively produce stronger constructs or sustenance; this remains a possibility.
7. For every approved retcon, update the retcon index with affected topic, editor, exact change, status, and relevant anchor. Keep old source material marked as archival when superseded.
8. For every new established entity, faction, artifact, or soul mechanic, add an alphabetically placed directory entry with one-sentence definition and working source anchor; update the highlighter mapping and searchable reference as appropriate.
9. Keep the Lore reference directory immediately after Ask the Story Bible, and keep its link in Contents. Headings remain unhighlighted, readable, and in the existing fantasy font/theme.
10. Do not delete historical source sections, break internal links, or replace missing answers with invented lore. If unsupported, mark “Unanswered — No apparent answer found in the Story Bible.”
11. Preserve return-to-reading-position behavior when either utility panel closes, including glossary keyword links. After edits, verify section order, glossary alphabetical sorting, all glossary source links, anchor uniqueness, highlighting, search, and retained canon attribution.
