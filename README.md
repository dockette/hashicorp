<h1 align=center>Dockette / Hashicorp</h1>

<p align=center>
   🐳 Docker image with preinstalled Nomad, Consul, Levant, Vault, Terraform, Packer and Waypoint.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

-----

## Usage

**Bash**

```
docker run -it --rm dockette/hashicorp bash
```

**Nomad**

```
docker run -it --rm dockette/hashicorp nomad
```

**Consul**

```
docker run -it --rm dockette/hashicorp consul
```

**Levant**

```
docker run -it --rm dockette/hashicorp lavant deploy app.hcl
```

**Gitlab CI**

```yml
stages:
 - deploy

deploy:
  stage: deploy
  image: dockette/hashicorp
  script:
    - nomad job run app.nomad
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
