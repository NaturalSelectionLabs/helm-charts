# RSSHub Helm Chart

* Installs the open source RSS feed aggregator [RSSHub](https://docs.rsshub.app/)

## Get Repo Info

```console
helm repo add nsl https://naturalselectionlabs.github.io/helm-charts
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release nsl/rsshub
```

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## High Availability

This chart installs the non-HA version of RSSHub by default. If you want to run RSSHub in HA mode, you can use one of the example values in the next sections.


```yaml
replicaCount: 3

puppeteer:
  replicaCount: 2
```

Or enable autoscaling example.

```yaml
autoscaling:
  enabled: true
  minReplicas: 3

puppeteer:
  autoscaling:
    enabled: true
    minReplicas: 2
```

## externalRedis

```yaml
redis:
  # -- Enable redis
  enabled: false
env:
  REDIS_URL: redis://external-redis:6379/
```

## Configuration
| Parameter                         | Description                                                                                              | Default                               |
|-----------------------------------|----------------------------------------------------------------------------------------------------------|---------------------------------------|
| `replicaCount`                    | Number of replicas for the RSSHub deployment.                                                            | `1`                                   |
| `image.repository`                | Container image repository for the RSSHub deployment.                                                     | `diygod/rsshub`                       |
| `image.pullPolicy`                | Image pull policy for the RSSHub deployment.                                                             | `IfNotPresent`                        |
| `image.tag`                       | Image tag for the RSSHub deployment.                                                                    | `""` (empty string)                   |
| `global.podAnnotations`           | Annotations to add to all deployed pods.                                                                 | `{}` (empty map)                      |
| `global.podLabels`                | Labels for all deployed pods.                                                                           | `{}` (empty map)                      |
| `global.securityContext`          | Security context for all deployed pods.                                                                  | `{}` (empty map)                      |
| `global.imagePullSecrets`         | Secrets for pulling images from private Docker registries or repositories.                                | `[]` (empty list)                     |
| `global.hostAliases`              | Mapping between IP and hostnames to inject into the pod's hosts file.                                      | `[]` (empty list)                     |
| `global.networkPolicy.create`     | Create NetworkPolicy objects for all components.                                                         | `false`                               |
| `global.networkPolicy.defaultDenyIngress` | Default deny all ingress traffic in NetworkPolicy.                                                    | `false`                               |
| `imagePullSecrets`                | Secrets for pulling images from private Docker registries or repositories.                                | `[]` (empty list)                     |
| `nameOverride`                    | Override the chart name used for resources.                                                              | `""` (empty string)                   |
| `fullnameOverride`                | Override the chart's fullname used for resources.                                                         | `""` (empty string)                   |
| `env.NODE_ENV`                    | Node environment for RSSHub.                                                                            | `production`                          |
| `env.CACHE_TYPE`                  | Cache type for RSSHub (redis/memory).                                                                    | `redis`                               |
| `env.CACHE_EXPIRE`                | Cache expiration time in seconds.                                                                       | `'300'` (string)                      |
| `env.CACHE_CONTENT_EXPIRE`        | Cache content expiration time in seconds.                                                               | `'60'` (string)                       |
| `serviceAccount.create`           | Create a service account for the RSSHub deployment.                                                      | `true`                                |
| `serviceAccount.annotations`      | Annotations to add to the service account.                                                               | `{}` (empty map)                      |
| `serviceAccount.name`             | Name of the service account to use. If not set, a name is generated using the fullname template.        | `""` (empty string)                   |
| `podAnnotations`                  | Annotations to add to the RSSHub pods.                                                                   | `{}` (empty map)                      |
| `podSecurityContext`              | Security context for the RSSHub pods.                                                                    | `{}` (empty map)                      |
| `securityContext`                 | Security context for the RSSHub containers.                                                              | `{}` (empty map)                      |
| `service.type`                    | Type of service for RSSHub.                                                                             | `ClusterIP`                           |
| `service.port`                    | Port for the RSSHub service.                                                                            | `80`                                  |
| `ingress.enabled`                 | Enable Ingress for RSSHub.                                                                              | `false`                               |
| `ingress.className`               | Ingress class for RSSHub Ingress.                                                                       | `""` (empty string)                   |
| `ingress.annotations`             | Annotations for RSSHub Ingress.                                                                         | `{}` (empty map)                      |
| `ingress.hosts`                   | Hosts and paths for RSSHub Ingress.                                                                    | `[]` (empty list)                     |
| `ingress.tls`                     | TLS configuration for RSSHub Ingress.                                                                   | `[]` (empty list)                     |
| `resources`                       | Resource limits and requests for RSSHub containers.                                                      | `{}` (empty map)                      |
| `autoscaling.enabled`             | Enable Horizontal Pod Autoscaling for RSSHub.                                                            | `false`                               |
| `autoscaling.minReplicas`         | Minimum number of replicas for autoscaling.                                                              | `1`                                   |
| `autoscaling.maxReplicas`         | Maximum number of replicas for autoscaling.                                                              | `10`                                  |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage for autoscaling.                                                | `80`                                  |
| `nodeSelector`                    | Node selector for RSSHub pods.                                                                          | `{}` (empty map)                      |
| `tolerations`                     | Tolerations for RSSHub pods.                                                                            | `[]` (empty list)                     |
| `affinity`                        | Affinity rules for RSSHub pods.                                                                         | `{}` (empty map)                      |
| `redis.enabled`                   | Enable Redis for RSSHub caching.                                                                        | `true`                                |
| `redis.name`                      | Name for the Redis deployment.                                                                          | `redis`                               |
| `redis.image.repository`          | Redis container image repository.                                                                       | `redis`                               |
| `redis.image.tag`                 | Redis container image tag.                                                                              | `7.0.7-alpine`                        |
| `redis.imagePullPolicy`           | Image pull policy for Redis.                                                                            | `IfNotPresent`                        |
| `redis.extraArgs`                 | Additional command line arguments for Redis.                                                            | `[]` (empty list)                     |
| `redis.containerPort`             | Redis container port.                                                                                   | `6379`                                |
| `redis.servicePort`               | Redis service port.                                                                                     | `6379`                                |
| `redis.networkPolicy.create`      | Create NetworkPolicy objects for Redis.                                                                 | `false`                               |
| `redis.networkPolicy.defaultDenyIngress` | Default deny all ingress traffic in NetworkPolicy for Redis.                                     | `false`                               |
| `redis.env`                       | Environment variables to pass to the Redis server.                                                      | `[]` (empty list)                     |
| `redis.envFrom`                   | envFrom to pass to the Redis server.                                                                    | `[]` (empty list)                     |
| `redis.podAnnotations`            | Annotations to add to the Redis server pods.                                                             | `{}` (empty map)                      |
| `redis.podLabels`                 | Labels to add to the Redis server pods.                                                                  | `{}` (empty map)                      |
| `redis.nodeSelector`              | Node selector for Redis pods.                                                                           | `{}` (empty map)                      |
| `redis.tolerations`               | Tolerations for Redis pods.                                                                             | `[]` (empty list)                     |
| `redis.affinity`                  | Affinity rules for Redis pods.                                                                          | `{}` (empty map)                      |
| `redis.topologySpreadConstraints`  | TopologySpreadConstraints rules for Redis.                                                               | `[]` (empty list)                     |
| `redis.priorityClassName`         | Priority class for Redis pods.                                                                          | `""` (empty string)                   |
| `redis.containerSecurityContext`  | Container-level security context for Redis.                                                              | `{}` (empty map)                      |
| `redis.securityContext`           | Pod-level security context for Redis.                                                                    | `{"runAsNonRoot": true, "runAsUser": 999}` |
| `redis.serviceAccount.create`     | Create a service account for the Redis pod.                                                              | `false`                               |
| `redis.serviceAccount.name`       | Name of the service account for the Redis pod.                                                            | `""` (empty string)                   |
| `redis.serviceAccount.annotations` | Annotations to add to the service account for Redis.                                                      | `{}` (empty map)                      |
| `redis.serviceAccount.automountServiceAccountToken` | Automount API credentials for the service account.                                        | `false`                               |
| `redis.resources`                 | Resource limits and requests for Redis containers.                                                        | `{}` (empty map)                      |
| `redis.volumeMounts`              | Additional volume mounts for the Redis container.                                                         | `[]` (empty list)                     |
| `redis.volumes`                   | Additional volumes for the Redis pod.                                                                    | `[]` (empty list)                     |
| `redis.extraContainers`           | Additional containers to be added to the Redis pod.                                                       | `[]` (empty list)                     |
| `redis.service.annotations`       | Annotations for the Redis service.                                                                       | `{}` (empty map)                      |
| `redis.service.labels`            | Labels for the Redis service.                                                                           | `{}` (empty map)                      |
| `puppeteer.enabled`               | Enable Puppeteer for RSSHub.                                                                            | `true`                                |
| `puppeteer.name`                  | Name for the Puppeteer deployment.                                                                       | `puppeteer`                           |
| `puppeteer.image.repository`      | Puppeteer container image repository.                                                                   | `browserless/chrome`                  |
| `puppeteer.image.tag`             | Puppeteer container image tag.                                                                          | `1.57-puppeteer-13.1.3`                |
| `puppeteer.imagePullPolicy`       | Image pull policy for Puppeteer.                                                                        | `IfNotPresent`                        |
| `puppeteer.containerPort`         | Puppeteer container port.                                                                               | `3000`                                |
| `puppeteer.servicePort`           | Puppeteer service port.                                                                                 | `3000`                                |
| `puppeteer.replicaCount`          | Number of replicas for the Puppeteer deployment.                                                         | `1`                                   |
| `puppeteer.autoscaling.enabled`    | Enable Horizontal Pod Autoscaling for Puppeteer.                                                         | `false`                               |
| `puppeteer.autoscaling.minReplicas`| Minimum number of replicas for autoscaling of Puppeteer.                                                 | `1`                                   |
| `puppeteer.autoscaling.maxReplicas`| Maximum number of replicas for autoscaling of Puppeteer.                                                 | `10`                                  |
| `puppeteer.autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage for autoscaling of Puppeteer.                            | `80`                                  |
| `puppeteer.podAnnotations`         | Annotations to add to the Puppeteer pods.                                                                | `{}` (empty map)                      |
| `puppeteer.podLabels`             | Labels to add to the Puppeteer pods.                                                                     | `{}` (empty map)                      |
| `puppeteer.securityContext`        | Security context for the Puppeteer containers.                                                           | `{"runAsNonRoot": true, "runAsUser": 999}` |
| `puppeteer.service.annotations`    | Annotations for the Puppeteer service.                                                                   | `{}` (empty map)                      |
| `puppeteer.service.labels`         | Labels for the Puppeteer service.                                                                       | `{}` (empty map)                      |
| `puppeteer.serviceAccount.create`   | Create a service account for the Puppeteer pod.                                                          | `false`                               |
| `puppeteer.serviceAccount.name`     | Name of the service account for the Puppeteer pod.                                                        | `""` (empty string)                   |
| `puppeteer.serviceAccount.annotations` | Annotations to add to the service account for Puppeteer.                                                  | `{}` (empty map)                      |
| `puppeteer.serviceAccount.automountServiceAccountToken` | Automount API credentials for the service account.                                      | `false`                               |
| `puppeteer.resources`             | Resource limits and requests for Puppeteer containers.                                                    | `{}` (empty map)                      |