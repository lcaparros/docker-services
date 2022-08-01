# docker-services

In this repo there are several useful services that could run by Docker. All those services are expected to be running in a docker network can be create using [this docker-compose](docker-compose.yaml) file. Otherwise you can run next command to create this primary network:

```shell
docker network create --driver=bridge --subnet=172.22.0.0/16 primary
```

## nginx-proxy-manager

First time you access go to port 81. Once initialized you can hide this port in the docker compose file for additional security.

Default admin user:

```
Email:    admin@example.com
Password: changeme
```
