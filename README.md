<h1 align=center>Dockette / Hashicorp</h1>

<p align=center>
   <a href="https://github.com/dockette/hashicorp/actions"><img src="https://github.com/dockette/hashicorp/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/hashicorp"><img src="https://img.shields.io/docker/pulls/dockette/hashicorp.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   🐳 Docker image with preinstalled Nomad, Consul, Levant, Vault, Terraform, Packer and Waypoint.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

-----

One image with the HashiCorp command line tools. Each tool version is pinned in the `Dockerfile`.

## Features

- Nomad, Consul, Vault, Terraform, Levant, Packer and Waypoint on `debian:trixie-slim`
- `bash`, `curl`, `make` and `git`
- `nomad-purge-job` helper script
- `linux/amd64` and `linux/arm64`

## Usage

```sh
docker run -it --rm dockette/hashicorp bash

# Run a tool
docker run -it --rm dockette/hashicorp nomad
docker run -it --rm dockette/hashicorp consul
docker run -it --rm dockette/hashicorp levant deploy app.hcl
```

In GitLab CI:

```yml
stages:
 - deploy

deploy:
  stage: deploy
  image: dockette/hashicorp
  script:
    - nomad job run app.nomad
```

## Versions

| Version | Release |
|---------|---------|
| `dockette/hashicorp:YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/hashicorp:latest` | latest build of `master` |

Releases are listed on [GitHub](https://github.com/dockette/hashicorp/releases).

## Development

```sh
make build          # build the image
make test           # print the version of every tool
make run            # open a shell in the image
make version        # print VERSION
make release        # set today's date in VERSION
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to
[support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
