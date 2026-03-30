FROM node:24-alpine

WORKDIR /app

RUN apk add --no-cache git bash build-base python3 make g++ cmake

RUN git clone https://github.com/openclaw/openclaw.git .

RUN npm install -g pnpm
RUN pnpm install 2>&1 | grep -v "node-llama-cpp" || true

RUN pnpm build 2>&1 | grep -v "node-llama-cpp" || true

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENV OPENCLAW_GATEWAY_PORT=8080
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
EXPOSE 8080

CMD ["/app/start.sh"]
