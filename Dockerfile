FROM ghcr.io/openclaw/openclaw:latest

WORKDIR /app

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace
EXPOSE 8080

CMD ["/app/start.sh"]
