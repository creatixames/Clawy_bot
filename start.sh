#!/bin/sh

set -e

STATE_DIR=${OPENCLAW_STATE_DIR:-/home/node/.openclaw}
WORKSPACE_DIR=${OPENCLAW_WORKSPACE_DIR:-/home/node/.openclaw/workspace}
GATEWAY_PORT=${OPENCLAW_GATEWAY_PORT:-${PORT:-8080}}
GATEWAY_BIND=${OPENCLAW_GATEWAY_BIND:-lan}

export OPENCLAW_STATE_DIR="$STATE_DIR"
export OPENCLAW_WORKSPACE_DIR="$WORKSPACE_DIR"
export OPENCLAW_GATEWAY_PORT="$GATEWAY_PORT"
export OPENCLAW_GATEWAY_BIND="$GATEWAY_BIND"

mkdir -p "$STATE_DIR" "$WORKSPACE_DIR"

if [ ! -w "$STATE_DIR" ] || [ ! -w "$WORKSPACE_DIR" ]; then
  STATE_DIR=/home/node/.openclaw
  WORKSPACE_DIR=/home/node/.openclaw/workspace
  export OPENCLAW_STATE_DIR="$STATE_DIR"
  export OPENCLAW_WORKSPACE_DIR="$WORKSPACE_DIR"
  mkdir -p "$STATE_DIR" "$WORKSPACE_DIR"
fi

CONFIG_FILE="$STATE_DIR/openclaw.json"

if [ -f "$CONFIG_FILE" ] && grep -q '"agent"' "$CONFIG_FILE"; then
  mv "$CONFIG_FILE" "$CONFIG_FILE.legacy.bak"
fi

# Inicia OpenClaw
exec node dist/index.js gateway --bind "$GATEWAY_BIND" --port "$GATEWAY_PORT" --allow-unconfigured --verbose
