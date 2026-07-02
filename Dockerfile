FROM debian:sid@sha256:5d1a66dd4100ff2faba25ae02984de721d8faf3957e1d8e68bc50f3e5adbc2f9

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
