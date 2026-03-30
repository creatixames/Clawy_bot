#!/bin/sh

set -e

STATE_DIR=${OPENCLAW_STATE_DIR:-/data/.openclaw}
WORKSPACE_DIR=${OPENCLAW_WORKSPACE_DIR:-/data/workspace}
GATEWAY_PORT=${OPENCLAW_GATEWAY_PORT:-${PORT:-8080}}

export OPENCLAW_STATE_DIR="$STATE_DIR"
export OPENCLAW_WORKSPACE_DIR="$WORKSPACE_DIR"
export OPENCLAW_GATEWAY_PORT="$GATEWAY_PORT"

mkdir -p "$STATE_DIR" "$WORKSPACE_DIR"

cat > "$STATE_DIR/openclaw.json" <<EOF
{
  "agent": {
    "model": "gemini-3.1-flash-lite-preview"
  },
  "gateway": {
    "port": $GATEWAY_PORT,
    "bind": "0.0.0.0"
  },
  "channels": {
    "telegram": {
      "botToken": "$TELEGRAM_BOT_TOKEN"
    }
  }
}
EOF

# Inicia OpenClaw
exec pnpm openclaw gateway --port "$GATEWAY_PORT" --allow-unconfigured --verbose
