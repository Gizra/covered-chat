#!/usr/bin/env bash
# Checks the built site in public/: every page names its operator, contact and
# gizra.com link, and CNAME keeps the custom domain.
set -u
failed=0
for page in index.html about/index.html privacy/index.html terms/index.html sms-consent/index.html; do
  if [ ! -f "public/$page" ]; then echo "missing: $page"; failed=1; continue; fi
  for needle in "Covered is operated by Gizra USA, LLC" "https://www.gizra.com" "info@gizra.com"; do
    grep -q "$needle" "public/$page" || { echo "$page lacks: $needle"; failed=1; }
  done
done
[ "$(cat public/CNAME 2>/dev/null)" = "covered.chat" ] || { echo "public/CNAME is not covered.chat"; failed=1; }
[ "$failed" -eq 0 ] && echo "check: every page passes"
exit "$failed"
