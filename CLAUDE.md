# Project Conventions

The public site for Covered (covered.chat), a Hugo + Tailwind v4 static site.
Covered is operated by Gizra USA, LLC. The privacy, terms and SMS consent pages
are copied word for word from what Covered's Twilio campaign approved: don't
reword them without updating that registration.

## Development

Start the dev server (finds a free port from 1313 and runs the Tailwind
watcher + Hugo, all in Docker):

```bash
make dev
```

The Tailwind CLI compiles `assets/css/style.css` → `assets/css/output.css`
(gitignored); Hugo serves the compiled file.

## Hugo build

Check the site builds without errors:

```bash
# If the dev server is already running (use the actual PORT):
docker compose exec hugo hugo --gc --minify

# Or check every page's footer and the CNAME:
make check
```

The site is served at `https://covered.chat/` (`static/CNAME`).

## Accessibility

All HTML targets WCAG 2.1 AAA. After modifying any HTML/layout/CSS, run pa11y (0
errors expected).

```bash
# Single page (use the actual PORT):
docker compose exec hugo npx pa11y --standard WCAG2AAA --config .pa11y.json http://localhost:1313/

# All screens:
docker compose exec hugo npm run pa11y
```

Add new screens to the `paths` array in `.pa11yci.js` as they are built.

## CSS

Tailwind-first. `assets/css/style.css` holds **only** config: `@import
"tailwindcss"`, the `@source` globs, the `@theme` design tokens (one accent color
+ fonts), and a minimal `@layer base`. Express everything else with Tailwind
utilities in the markup — prefer a named utility over an arbitrary value when one
exists (`text-xs`, not `text-[11px]`); reach for arbitrary values
(`h-[calc(…)]`, `[writing-mode:vertical-rl]`) only when there is no close stock
class. **Do not** add component classes.

Recolor the project by changing `--color-accent` (and `-dark` / `-soft`) in
`style.css`; everything else is stock Tailwind. The accent values are chosen to
pass WCAG AAA (white text on accent; accent-dark text on accent-soft).

Reuse repeated markup via **Hugo partials**, not CSS classes. Note: inline
`var()` in a `style=""` attribute is stripped by Hugo's template CSS sanitizer —
set custom properties via arbitrary-property utilities instead.

## JavaScript

JavaScript lives in `assets/javascript/*.js`, never inline in `<script>` tags in
templates. After
modifying any file there, run ESLint and expect 0 errors:

```bash
docker compose exec hugo npm run lint   # or: npm run lint:fix
```

## Comments

A comment is at most 30 words, and a paragraph in a `.md` file the same. Only
what a branch writes is measured. `make comments` runs the check CI runs.

## Code hygiene

If you come across stale code while working — a selector/class/reference that no
longer matches the markup, a dead handler, a pointer to a removed file — **fix
it, don't work around it.** Repair it to match current reality or remove it if
the feature is genuinely gone.

## Git

Commit and push freely on a feature branch — no need to ask first. Never
force-push. Don't push directly to `main` or merge a PR without explicit
approval.
