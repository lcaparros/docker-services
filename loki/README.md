# Grafana Loki

## First time usage

This stack needs to be configured first time it is run. Follow the next steps for initial configuration:

- Go to Grafana configuration  section
- Click on `Add data source`
- Add `Loki` data source
- Modify URL from `http://localhost:3100` to `http://loki:3100`

## Docker logs forwarding

To forward logs for docker it is necessary to prepare `promtail-config` file to receive logs from docker.

```
scrape_configs:
- job_name: docker
  pipeline_stages:
    - docker: {}
  static_configs:
  - labels:
    job: docker
    __path__: /var/lib/docker/containers/*/*-json.log
```

On the other hand, in the client it is necessary to install [grafana client docker plugin](https://grafana.com/docs/loki/latest/clients/docker-driver/):

```shell
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

Then it is possible to modify any service logging option insided a docker-compose file as in this example below:

```
version: "3"
services:
  grafana:
    image: grafana/grafana
    logging:
      driver: loki
      options:
        loki-url: http://host.docker.internal:3100/loki/api/v1/push
        loki-batch-size: 400
    ports:
      - "3000:3000"
```

Otherwise, the Loki logging driver can be the default for all containers changing `/etc/docker/daemon.json` (if not exists yet must be created) making it include:

```
{
  "log-driver": "loki",
  "log-opts": {
    "loki-url": "https://loki.3100/loki/api/v1/push",
    "loki-batch-size": "400",
    "no-file": "true"
  }
}
```

## Troubleshooting

If Grafana does not initialize properly and the next lines are thrown in the logs:

```
mkdir: can't create directory '/var/lib/grafana/plugins': Permission denied
GF_PATHS_DATA='/var/lib/grafana' is not writable.
```

It is necessary to create the directory grafana as same level where docker-compose.yml file is located.
