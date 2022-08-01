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

Then `/etc/docker/daemon.json` (if not exists yet must be created) must contain:

```
{
  "log-driver": "loki",
  "log-opts": {
    "loki-url": "https://loki.3100/loki/api/v1/push",
    "loki-batch-size": "400"
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
