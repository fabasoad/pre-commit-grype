# Grype pre-commit hooks

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![GitHub release](https://img.shields.io/github/v/release/fabasoad/pre-commit-grype?include_prereleases)
![security](https://github.com/fabasoad/pre-commit-grype/actions/workflows/security.yml/badge.svg)
![linting](https://github.com/fabasoad/pre-commit-grype/actions/workflows/linting.yml/badge.svg)

1. [grype-dir](#grype-dir)

## How it works?

At first hook tries to use globally installed `grype` tool. And if it doesn't exist
then hook installs `grype` into a temporary directory that will be removed after
scanning is completed.

## Documentation

<!-- markdownlint-disable-next-line MD013 -->

> `<rev>` in the examples below, is the latest revision tag from [fabasoad/pre-commit-grype](https://github.com/fabasoad/pre-commit-grype/releases)
> repository.

### grype-dir

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-grype
    rev: <rev>
    hooks:
      - id: grype-dir
        args: ["--exclude-base-image-vulns"]
```

> `args` is optional. In this example you can skip base image vulnerabilities.

### snyk-iac

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-grype
    rev: <rev>
    hooks:
      - id: snyk-iac
        args:["<folder>","--severity-threshold=<severity-level>"]
```

Where:

- `<folder>` is the folder path that you want to test.
- `<severity-level>` only vulnerabilities of the specified level or higher are reported.

  Options are:

  - low
  - medium
  - high
  - critical

### snyk-test

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-grype
    rev: <rev>
    hooks:
      - id: snyk-test
        args: ["--severity-threshold=critical"]
```

### snyk-code

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-grype
    rev: <rev>
    hooks:
      - id: snyk-code
        args: ["--severity-threshold=critical"]
```

### snyk-log4shell

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-grype
    rev: <rev>
    hooks:
      - id: snyk-log4shell
```
