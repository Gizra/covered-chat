# covered.chat

[![Build and Deploy](https://github.com/Gizra/covered-chat/actions/workflows/build.yml/badge.svg)](https://github.com/Gizra/covered-chat/actions/workflows/build.yml)
[![Lint](https://github.com/Gizra/covered-chat/actions/workflows/lint.yml/badge.svg)](https://github.com/Gizra/covered-chat/actions/workflows/lint.yml)
[![Pa11y](https://github.com/Gizra/covered-chat/actions/workflows/pa11y.yml/badge.svg)](https://github.com/Gizra/covered-chat/actions/workflows/pa11y.yml)

The public site for Covered, the shift-coverage assistant for restaurants that Gizra USA, LLC operates. It says what Covered is, and carries its SMS privacy policy, terms and staff consent form.

Built with Hugo and Tailwind v4 from Gizra's `hugo-elm-mock-starter`, without its Elm app.

## Pages

- `/`: what Covered is and who runs it (`content/_index.md`).
- `/privacy/`, `/terms/` and `/sms-consent/`: the SMS documents, word for word as approved for Covered's Twilio A2P campaign.

The campaign also points to the same documents at `adamhstewart.github.io/covered-sms/`. Keep both in step.

## Development

```bash
make dev     # Docker: Tailwind watcher and Hugo, on a free port from 1313
make check   # builds into public/ and checks every page's operator line, contact and CNAME
```

## Accessibility

Target is WCAG 2.1 AAA. With the dev server up:

```bash
docker compose exec hugo npm run pa11y
```

## Lint and comments

```bash
docker compose exec hugo npm run lint
make comments   # every new comment at most 30 words, as CI checks
```

## Deploy

Each push to `main` runs `make build`, which deploys to the `gh-pages` branch. GitHub Pages serves that branch at `covered.chat` (`static/CNAME`). DNS is in Cloudflare: a CNAME for `covered.chat` to `gizra.github.io`.
