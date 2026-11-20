#!/usr/bin/env bash
#
# Codespace post-create setup. Non-fatal throughout: a failed optional step must not
# block Codespace creation. See .devcontainer/devcontainer.json.
set -u

echo "post-create complete. Run 'make dev' to start Hugo."
