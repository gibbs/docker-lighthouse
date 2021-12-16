# Docker Lighthouse

![Docker](https://github.com/Gibbs/docker-lighthouse/actions/workflows/build.yml/badge.svg)

A [Lighthouse](https://github.com/GoogleChrome/lighthouse) Docker image using 
Debian and Chromium.

## Example Usage

Return a HTML report:

```bash
docker run --cap-add=SYS_ADMIN genv/lighthouse <url> --output-path=stdout
```

Generate and save a HTML report to the current working directory:

```bash
docker run -v "$(pwd):/home/lighthouse/reports/" --cap-add=SYS_ADMIN genv/lighthouse <url>
```

Return a JSON report:

```bash
docker run --cap-add=SYS_ADMIN genv/lighthouse <url> --output=json --output-path=stdout
```

Write a JSON report to disk:

```bash
docker run --cap-add=SYS_ADMIN genv/lighthouse <url> --output=json --output-path=stdout > $(date +%s)_report.json
```

Save multiple reports to the current working directory:

```bash
docker run -v "$(pwd):/home/lighthouse/reports/" --cap-add=SYS_ADMIN genv/lighthouse <url> --output=csv,json,html
```

For a full list of options see:

```bash
docker run genv/lighthouse --help
```
