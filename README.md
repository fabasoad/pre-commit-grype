# Grype pre-commit hooks

[![Stand With Ukraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://stand-with-ukraine.pp.ua)
![GitHub release](https://img.shields.io/github/v/release/fabasoad/pre-commit-grype?include_prereleases)
![security](https://github.com/fabasoad/pre-commit-grype/actions/workflows/security.yml/badge.svg)
![linting](https://github.com/fabasoad/pre-commit-grype/actions/workflows/linting.yml/badge.svg)
![functional-tests](https://github.com/fabasoad/pre-commit-grype/actions/workflows/functional-tests.yml/badge.svg)

## Table of Contents

- [How it works?](#how-it-works)
- [Prerequisites](#prerequisites)
- [Hooks](#hooks)
  - [grype-dir](#grype-dir)
- [Customization](#customization)
  - [Description](#description)
  - [Parameters](#parameters)
    - [Grype](#grype)
    - [pre-commit-grype](#pre-commit-grype)
      - [Log level](#log-level)
      - [Log color](#log-color)
  - [Examples](#examples)

## How it works?

At first hook tries to use globally installed `grype` tool. And if it doesn't exist
then hook installs `grype` into a `.pre-commit-grype` temporary directory that
will be removed after scanning is completed.

## Prerequisites

The following tools have to be available on a runner prior using this pre-commit
hook:

- [bash >=4.0](https://www.gnu.org/software/bash/)
- [curl](https://curl.se/)

## Hooks

<!-- markdownlint-disable-next-line MD013 -->

> `<rev>` in the examples below, is the latest revision tag from [fabasoad/pre-commit-grype](https://github.com/fabasoad/pre-commit-grype/releases)
> repository.

### grype-dir

This hook runs [grype dir:.](https://github.com/anchore/grype?tab=readme-ov-file#supported-sources)
command.

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-grype
    rev: <rev>
    hooks:
      - id: grype-dir
```

## Customization

### Description

There are 2 ways to customize scanning for both `grype` and `pre-commit-grype` -
environment variables and arguments passed to [args](https://pre-commit.com/#config-args).

You can pass arguments to the hook as well as to the `grype` itself. To distinguish
parameters you need to use `--grype-args` for `grype` arguments and `--hook-args`
for `pre-commit-grype` arguments. Supported delimiter is `=`. So, use `--hook-args=<arg>`
but not `--hook-args <arg>`. Please find [Examples](#examples) for more details.

### Parameters

#### Grype

You can install `grype` locally and run `grype --help` to see all the available
arguments:

<!-- markdownlint-disable MD013 -->

```shell
$ grype --version
grype 0.79.1

$ grype --help
A vulnerability scanner for container images, filesystems, and SBOMs.

Supports the following image sources:
    grype yourrepo/yourimage:tag             defaults to using images from a Docker daemon
    grype path/to/yourproject                a Docker tar, OCI tar, OCI directory, SIF container, or generic filesystem directory

You can also explicitly specify the scheme to use:
    grype podman:yourrepo/yourimage:tag          explicitly use the Podman daemon
    grype docker:yourrepo/yourimage:tag          explicitly use the Docker daemon
    grype docker-archive:path/to/yourimage.tar   use a tarball from disk for archives created from "docker save"
    grype oci-archive:path/to/yourimage.tar      use a tarball from disk for OCI archives (from Podman or otherwise)
    grype oci-dir:path/to/yourimage              read directly from a path on disk for OCI layout directories (from Skopeo or otherwise)
    grype singularity:path/to/yourimage.sif      read directly from a Singularity Image Format (SIF) container on disk
    grype dir:path/to/yourproject                read directly from a path on disk (any directory)
    grype sbom:path/to/syft.json                 read Syft JSON from path on disk
    grype registry:yourrepo/yourimage:tag        pull image directly from a registry (no container runtime required)
    grype purl:path/to/purl/file                 read a newline separated file of purls from a path on disk

You can also pipe in Syft JSON directly:
 syft yourimage:tag -o json | grype

Usage:
  grype [IMAGE] [flags]
  grype [command]

Available Commands:
  completion  Generate a shell completion for Grype (listing local docker images)
  config      show the grype configuration
  db          vulnerability database operations
  explain     Ask grype to explain a set of findings
  help        Help about any command
  version     show version information

Flags:
      --add-cpes-if-none       generate CPEs for packages with no CPE data
      --by-cve                 orient results by CVE instead of the original vulnerability ID when possible
  -c, --config string          grype configuration file
      --distro string          distro to match against in the format: <distro>:<version>
      --exclude stringArray    exclude paths from being scanned using a glob expression
  -f, --fail-on string         set the return code to 1 if a vulnerability is found with a severity >= the given severity, options=[negligible low medium high critical]
      --file string            file to write the default report output to (default is STDOUT)
  -h, --help                   help for grype
      --ignore-states string   ignore matches for vulnerabilities with specified comma separated fix states, options=[fixed not-fixed unknown wont-fix]
      --name string            set the name of the target being analyzed
      --only-fixed             ignore matches for vulnerabilities that are not fixed
      --only-notfixed          ignore matches for vulnerabilities that are fixed
  -o, --output stringArray     report output formatter, formats=[json table cyclonedx cyclonedx-json sarif template], deprecated formats=[embedded-cyclonedx-vex-json embedded-cyclonedx-vex-xml]
      --platform string        an optional platform specifier for container image sources (e.g. 'linux/arm64', 'linux/arm64/v8', 'arm64', 'linux')
  -q, --quiet                  suppress all logging output
  -s, --scope string           selection of layers to analyze, options=[squashed all-layers] (default "squashed")
      --show-suppressed        show suppressed/ignored vulnerabilities in the output (only supported with table output format)
  -t, --template string        specify the path to a Go template file (requires 'template' output to be selected)
  -v, --verbose count          increase verbosity (-v = info, -vv = debug)
      --version                version for grype
      --vex stringArray        a list of VEX documents to consider when producing scanning results

Use "grype [command] --help" for more information about a command.
```

<!-- markdownlint-enable MD013 -->

#### pre-commit-grype

Here is the precedence order of `pre-commit-grype` tool:

- Parameter passed to the hook as argument via `--hook-args`.
- Environment variable.
- Default value.

For example, if you set `PRE_COMMIT_GRYPE_LOG_LEVEL=warning` and `--hook-args=--log-level
error` then `error` value will be used.

##### Log level

With this parameter you can control the log level of `pre-commit-grype` hook output.
It doesn't impact `grype` log level output. To control `grype` log level output
please look at the [Grype parameters](#grype).

- Parameter name: `--log-level`
- Environment variable: `PRE_COMMIT_GRYPE_LOG_LEVEL`
- Possible values: `debug`, `info`, `warning`, `error`
- Default: `info`

##### Log color

With this parameter you can enable/disable the coloring of `pre-commit-grype`
hook logs. It doesn't impact `grype` logs coloring.

- Parameter name: `--log-color`
- Environment variable: `PRE_COMMIT_GRYPE_LOG_COLOR`
- Possible values: `true`, `false`
- Default: `true`

### Examples

Pass arguments separately from each other:

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-grype
    rev: <rev>
    hooks:
      - id: grype-dir
        args:
          - --hook-args=--log-level debug
          - --grype-args=--fail-on low
          - --grype-args=--by-cve
```

Pass arguments altogether grouped by category:

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-grype
    rev: <rev>
    hooks:
      - id: grype-dir
        args:
          - --hook-args=--log-level debug
          - --grype-args=--fail-on low --by-cve
```

Set these parameters to have the minimal possible logs output:

```yaml
repos:
  - repo: https://github.com/fabasoad/pre-commit-grype
    rev: <rev>
    hooks:
      - id: grype-dir
        args:
          - --hook-args=--log-level=error
          - --grype-args=--quiet
```
