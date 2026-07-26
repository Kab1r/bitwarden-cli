# bitwarden-cli

bitwarden-cli docker image

this is based on the code in the [external-secrets documentation](https://external-secrets.io/latest/examples/bitwarden/).

both the `Dockerfile` and `entrypoint.sh` are a near-identical copy/paste.

the only changes are to the `Dockerfile` to add shasum checking (thanks [majabojarska](https://github.com/majabojarska)!), and to convert `BW_CLI_VERSION` from an `ENV` to an `ARG`,
so that the official upstream version can be read from the `VERSION` file for the `ARG` as well as the image tag.

# tag convention

```bash
docker pull ghcr.io/kab1r/bitwarden-cli:<official bitwarden cli version>
```

The version in [VERSION](/VERSION) is updated automatically alongside the image below:

```bash
ghcr.io/kab1r/bitwarden-cli:2026.6.0
```
