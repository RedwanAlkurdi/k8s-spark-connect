# Spark Connect Helm Chart

This Helm chart deploys Spark Connect on Kubernetes.

## Prerequisites

Before installing this chart, ensure you have the following:

### Kubernetes Cluster Requirements
- Kubernetes cluster
- Helm 3.x

### Required Secrets
- Registry credentials secret for pulling images (if using a private registry)

### Optional Secrets
- Object Storage secret with access key and secret key (if using object storage)

### Optional ConfigMaps
- ConfigMap with the trust bundle (if using object storage and a self-signed CA)

### Required Components
- cert-manager cluster issuer (platform-issuer) - if exposing via nginx
- external-dns installed and configured on the cluster - if exposing via nginx
- trust-manager installed and configured on the cluster - if using object storage & using TLS enabled Spark-connect client

### Optional Components
- Hive metastore (if using Hive catalog)
- Celeborn (if using external shuffle service)

## Quick Start

```bash
# Add the Helm repository
helm repo add spark-connect https://mhdredwanalkurdi.github.io/k8s-spark-connect

# Update the repository
helm repo update

# Install the chart
helm install spark-connect spark-connect/spark-connect
```

## Configuration

The following table lists the configurable parameters of the Spark Connect chart and their default values.

### Basic Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of Spark Connect server replicas | `1` |
| `image.repository` | Docker image repository | `loco144/spark-connect` |
| `image.tag` | Docker image tag | `3.5.4` |
| `image.pullPolicy` | Image pull policy | `Always` |
| `image.imagePullSecrets` | Image pull secrets | `[{name: regcred}]` |
| `nameOverride` | Override the name of resources | `""` |
| `fullnameOverride` | Override the full name of resources | `""` |

### Container Ports

| Parameter | Description | Default |
|-----------|-------------|---------|
| `containerPorts.sparkUi` | Port for Spark UI | `4040` |
| `containerPorts.sparkConnect` | Port for Spark Connect | `15002` |

### Spark Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `spark.eventLog.enabled` | Enable event logging | `true` |
| `spark.eventLog.dir` | Event log directory | `""` |
| `spark.celeborn.enabled` | Enable Celeborn for shuffle service | `false` |
| `spark.celeborn.masterEndpoints` | Celeborn master endpoints | `""` |
| `spark.dynamicAllocation.enabled` | Enable dynamic allocation | `true` |
| `spark.driver.cores` | Driver CPU cores | `2` |
| `spark.driver.memoryMiB` | Driver memory in MiB | `2048` |
| `spark.driver.memoryOverheadMiB` | Driver memory overhead in MiB | `384` |
| `spark.executor.cores` | Executor CPU cores | `1` |
| `spark.executor.requestCoresMilliCPU` | Executor CPU request in milliCPU | `2000` |
| `spark.executor.memoryMiB` | Executor memory in MiB | `2048` |
| `spark.executor.memoryOverheadMiB` | Executor memory overhead in MiB | `384` |
| `spark.executor.minExecutors` | Minimum number of executors | `1` |
| `spark.executor.maxExecutors` | Maximum number of executors | `4` |
| `spark.scratchDir` | Temporary directory for Spark | `/tmp` |
| `spark.kubernetesEndpoint` | Kubernetes API endpoint | `https://kubernetes.default.svc.cluster.local:443` |
| `spark.packages` | Additional Spark packages | `[]` |
| `spark.catalog.enabled` | Enable Hive catalog | `false` |
| `spark.catalog.hiveMetastoreConfigMap` | ConfigMap containing hive-site.xml | `spark-connect-hive` |

### NGINX Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `nginx.enabled` | Enable/disable NGINX | `false` |
| `nginx.image.repository` | NGINX image repository | `europe-west3-docker.pkg.dev/nz-mgmt-shared-artifacts-8c85/docker-hub/nginx` |
| `nginx.image.tag` | NGINX image tag | `latest` |
| `nginx.image.pullPolicy` | NGINX image pull policy | `Always` |
| `nginx.service.type` | NGINX service type | `LoadBalancer` |
| `nginx.service.port` | NGINX service port | `443` |
| `nginx.service.targetPort` | NGINX service target port | `https` |
| `nginx.certificate.enabled` | Enable/disable certificate | `true` |
| `nginx.certificate.issuerRef.name` | Certificate issuer name | `platform-issuer` |
| `nginx.certificate.issuerRef.kind` | Certificate issuer kind | `ClusterIssuer` |
| `nginx.certificate.dnsNames` | Certificate DNS names | `["spark-connect.zerocarbon-1.nzero.net", "spark-ui.zerocarbon-1.nzero.net"]` |
| `nginx.certificate.secretName` | Certificate secret name | `nginx-tls` |

### Object Storage Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `objectStorage.enabled` | Enable/disable object storage | `false` |
| `objectStorage.endpoint` | Object storage endpoint | `""` |
| `objectStorage.secret.name` | Secret name for object storage credentials | `minio-secret` |
| `objectStorage.secret.accessKeyRef` | Key in secret for access key | `accessKey` |
| `objectStorage.secret.secretKeyRef` | Key in secret for secret key | `secretKey` |
| `objectStorage.sslTrust.enabled` | Enable/disable SSL trust | `false` |
| `objectStorage.sslTrust.trustManager.configMapName` | ConfigMap name for trust bundle | `edp-ca` |
| `objectStorage.sslTrust.trustManager.configMapKey` | Key in ConfigMap for trust store | `nzero.de.jks` |
| `objectStorage.sslTrust.trustManager.mountPath` | Path to mount trust bundle | `/etc/ssl/certs/object-storage` |
| `objectStorage.sslTrust.trustManager.password` | Trust store password | `changeit` |

### Security Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `serviceAccount.create` | Create service account | `true` |
| `serviceAccount.name` | Service account name | `spark-connect` |
| `serviceAccount.automountServiceAccountToken` | Automount API credentials | `true` |
| `securityContext.runAsUser` | User ID to run as | `185` |
| `securityContext.runAsGroup` | Group ID to run as | `185` |

### Additional Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `command` | Additional command to run | `[]` |
| `extraArgs` | Additional command arguments | `[]` |
| `extraEnv` | Additional environment variables | `[]` |
| `podAnnotations` | Additional pod annotations | `{}` |
| `podSecurityContext` | Pod security context | `{}` |

## Usage

### Basic Installation

```bash
helm install spark-connect spark-connect/spark-connect
```

### With Custom Values

```bash
helm install spark-connect spark-connect/spark-connect \
  --set objectStorage.enabled=true \
  --set objectStorage.endpoint="https://your-minio-endpoint"
```

### With Values File

```bash
helm install spark-connect spark-connect/spark-connect -f values.yaml
```

## Development

### Building from Source

```bash
# Clone the repository
git clone https://github.com/mhdredwanalkurdi/k8s-spark-connect.git

# Package the chart
helm package charts/spark-connect

# Install the chart
helm install spark-connect spark-connect-0.1.0.tgz
```

### Running Tests

```bash
# Lint the chart
helm lint charts/spark-connect

# Template the chart
helm template spark-connect charts/spark-connect
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Apache Spark
- Kubernetes
- Helm
- NGINX
- cert-manager
- trust-manager
