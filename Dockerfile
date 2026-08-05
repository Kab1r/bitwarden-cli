FROM debian:sid@sha256:24c766c06ebdbda66a026e92361ede7d9212819701b2fca82e347ef0c240cb2c

ARG BW_CLI_VERSION

RUN set -eux; \
    apt update; \
    apt install -y wget unzip; \
    release_url="https://github.com/bitwarden/clients/releases/download/cli-v${BW_CLI_VERSION}"; \
    wget "${release_url}/bw-oss-linux-${BW_CLI_VERSION}.zip" --no-verbose -O bw.zip; \
    if wget "${release_url}/bw-oss-linux-sha256-${BW_CLI_VERSION}.txt" --no-verbose -O bw.zip.sha256; then \
        echo "$(cat bw.zip.sha256) bw.zip" | sha256sum --check -; \
    else \
        echo "No checksum asset found for ${BW_CLI_VERSION}; skipping checksum verification"; \
        rm -f bw.zip.sha256; \
    fi; \
    unzip bw.zip && \
    chmod +x bw && \
    mv bw /usr/local/bin/bw && \
    rm -rfv bw.zip*

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
