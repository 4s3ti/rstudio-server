# 4s3ti/rstudio-server

[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release) ![release](https://github.com/4s3ti/rstudio-server/actions/workflows/release.yml/badge.svg) ![cron](https://github.com/4s3ti/rstudio-server/actions/workflows/cron.yml/badge.svg)

Just (another) simple docker image running a simple setup of RStudio server

# How to run

`docker run -p 8787:8787 4s3ti/rstudio-server`

## With docker-compose & Persistent data

```
version: '3.8'
services:

  rstudio-server:
    image: 4s3ti/rstudio-server:latest
    container_name: "rstudio-server"
    restart: unless-stopped
    volumes:
      - rstudiodata:/home/rstudio
    environment:
      - rpwd=rstudioPassword

volumes:
  rstudiodata:
```

You can also run it behind traefik reverse proxy if you wish, here's an example

```
version: '3.8'
services:

  rstudio-server:
    image: 4s3ti/rstudio-server:latest
    container_name: "rstudio-server"
    restart: unless-stopped
    volumes:
      - rstudiodata:/home/rstudio
    environment:
      - rpwd=rstudioPasswd
    labels:
      traefik.enable: "true"
      traefik.docker.network: "rp"
      traefik.http.routers.rstudio.service: "rstudio"
      traefik.http.routers.rstudio.tls: "true"
      traefik.http.routers.rstudio.tls.certResolver: "default"
      traefik.http.routers.rstudio.rule: "Host(`rstudio.yourdomain.com`)"
      traefik.http.services.rstudio.loadbalancer.server.port: 8787

volumes:
  rstudiodata:
```

# How to build

If you want yo build your own

`docker build -t <imageName> .`

# Contribute? 

Pull Requests and suggestions are always welcomed! 

If you find this usefull and want to contribute in a different way, you caan always consider to

<a href="https://www.buymeacoffee.com/4s3ti" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-yellow.png" alt="Buy Me A Coffee" style="height: 51px !important;width: 217px !important;" >