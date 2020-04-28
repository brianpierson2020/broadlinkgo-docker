FROM alpine:latest

EXPOSE 42011
HEALTHCHECK --interval=60s --timeout=10s --retries=3 CMD (curl -sS http://localhost:42011) || exit 1

RUN mkdir /app \
	&& apk --no-cache add curl \
    && apk --no-cache add wget \
    && curl -s https://api.github.com/repos/rob121/broadlinkgo/releases/latest | grep browser_download_url.*broadlinkgo-linux-amd64 | cut -d : -f 2,3 | sed $'s/\x22//g' | tr -d '[:space:]' | wget -O /app/broadlinkgo -qi - \
    && apk del wget --quiet \
    && chmod +x /app/broadlinkgo

ENTRYPOINT ["/app/broadlinkgo", "--port=42011", "--cmdpath=/config", "--mode=manual"]