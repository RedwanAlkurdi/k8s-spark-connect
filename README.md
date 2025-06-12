# Spark Connect Helm Chart

This Helm chart deploys Spark Connect on Kubernetes, providing a service for connecting to Apache Spark clusters.

## Prerequisites

### Required Components
- Kubernetes cluster
- Helm 3.x

### Optional Components (Based on Your Use Case)
- Registry credentials secret (regcred) - Required if pulling images from a private repository
- Object Storage secret with access key and secret key - Required if using object storage
- ConfigMap with trust bundle - Required if using object storage that:
  - Is not reachable from inside the same cluster via a clusterIP type service
  - Uses a self-signed CA
- cert-manager cluster issuer - Required if utilizing the provided NGINX to expose:
  - Spark Connect
  - Spark UI
- external-dns - Required if utilizing the provided NGINX and assigning FQDNs to:
  - spark-connect endpoint
  - Spark UI endpoint
- trust-manager - Required if using a private CA for TLS certificate for the connection between Spark and object storage

## Installation

1. Add the Helm repository:
```bash
helm repo add spark-connect oci://ghcr.io/redwanalkurdi/helm-charts
```

2. Install the chart:
```bash
helm install spark-connect spark-connect/spark-connect
```

## Configuration

For detailed configuration options, please refer to the [chart's README](charts/spark-connect/README.md).

## Architecture

The chart deploys/configures the following components:

1. Spark Connect
   - Runs the Spark Connect service
   - Supports auto-scaling via Kubernetes as the Spark cluster manager
   - Optional: Configures object storage integration
   - Optional: Manages SSL trust configuration to object storage
   - Optional: Integrates with Celeborn as an external shuffle service
   - Optional: Integrates with Hive Metastore for metadata management

2. NGINX Service (Optional)
   - Provides SSL termination for the Grpc connections to the spark connect server
   - Routes traffic to Spark UI and Spark Connect
   - Configures TLS certificates via cert-manager
   - Configures DNS via external dns


## Security

- SSL/TLS termination is handled by NGINX (when enabled)
- Object storage integration supports SSL trust configuration
- Registry credentials are managed via Kubernetes secrets
- Trust manager handles certificate management for object storage connections

## Notes

- The chart provides flexibility in deployment options:
  - Direct Spark cluster access via Port-Forwarding
  - NGINX-based external access through the integration with cert-manger and external-dns
- Object storage integration requires proper secret and trust bundle configuration (in case you're using a self-signed CA)
- External DNS is used for automatic DNS record management (when pre-installed and pre-configured on your cluster)
- Trust manager is used for certificate management (when pre-installed and pre-configured on your cluster)

## Development

For development guidelines and contribution instructions, please refer to the [chart's README](charts/spark-connect/README.md).

## ToDo

- Implement authentication & authorization
- Add Spark History Server deployment option
- Integrate with APISIX for enhanced security 
- Add support for multiple object storage providers
- Add support for Observability


## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
