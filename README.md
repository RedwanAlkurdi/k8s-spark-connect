# Spark Connect Helm Chart

This Helm chart deploys Spark Connect on Kubernetes, providing a service for connecting to Apache Spark clusters.

## Prerequisites

- Kubernetes cluster
- Helm 3.x
- Object Storage secret with access key and secret key (if using object storage)
- ConfigMap with trust bundle (if using object storage)
- Registry credentials secret (regcred)
- cert-manager cluster issuer (platform-issuer)
- external-dns installed and configured
- trust-manager installed and configured

## Installation

1. Add the Helm repository:
```bash
helm repo add spark-connect https://your-repo-url
```

2. Install the chart:
```bash
helm install spark-connect spark-connect/spark-connect
```

## Configuration

The following table lists the configurable parameters of the Spark Connect chart and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `containerPorts.sparkUi` | Port for Spark UI | `4040` |
| `containerPorts.sparkConnect` | Port for Spark Connect | `15002` |
| `nginx.enabled` | Enable/disable NGINX | `true` |
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

## Architecture

The chart deploys the following components:

1. Spark Connect StatefulSet
   - Runs the Spark Connect service
   - Configures object storage integration
   - Manages SSL trust configuration

2. NGINX Service
   - Provides SSL termination
   - Routes traffic to Spark UI and Spark Connect
   - Uses LoadBalancer service type
   - Configures TLS certificates via cert-manager

## Security

- SSL/TLS termination is handled by NGINX
- Object storage integration supports SSL trust configuration
- Registry credentials are managed via Kubernetes secrets

## Notes

- The chart uses NGINX for SSL termination and routing
- Object storage integration requires proper secret and trust bundle configuration
- External DNS is used for automatic DNS record management
- Trust manager is used for certificate management

## ToDo

- Implement authentication
- Add Spark History Server integration
- Optimize sizing and autoscaling
- Improve EDP-specific configurations
- Integrate with APISIX for enhanced security
- Integrate with Celebron for shuffle service
- Consider Hive metastore integration
