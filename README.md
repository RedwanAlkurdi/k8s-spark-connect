# Spark Connect Helm Chart

[![Release](https://img.shields.io/github/v/release/redwanalkurdi/k8s-spark-connect?style=flat-square)](https://github.com/redwanalkurdi/k8s-spark-connect/releases)
[![License](https://img.shields.io/github/license/redwanalkurdi/k8s-spark-connect?style=flat-square)](LICENSE)
[![Docker Image](https://img.shields.io/badge/docker-ghcr.io%2Fredwanalkurdi%2Fk8s--spark--connect-blue?style=flat-square)](https://github.com/redwanalkurdi/k8s-spark-connect/pkgs/container/k8s-spark-connect)
[![Helm Chart](https://img.shields.io/badge/helm-k8s--spark--connect-red?style=flat-square)](https://github.com/redwanalkurdi/k8s-spark-connect/tree/main/charts/spark-connect)

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
helm repo add k8s-spark-connect https://redwanalkurdi.github.io/k8s-spark-connect/
```

2. Update the repository:
```bash
helm repo update
```

3. Install the chart:
```bash
helm install test k8s-spark-connect/spark-connect --version 0.0.3
```

## Configuration

For detailed configuration options, please refer to the [chart's README](charts/spark-connect/README.md).

## Architecture

The chart deploys/configures the following components:

![Spark Connect Architecture](./assets/Arch.png)


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

## Connecting to Spark Connect Server

You can connect to your Spark Connect server from your own IDE. We provide example code in both Python and Java to help you get started.

### Example Code

Check out our examples in the `examples` directory:
- Python examples: `examples/python/`
- Java examples: `examples/java/`

These examples demonstrate how to:
- Connect to the Spark Connect server
- Execute queries
- Manage Spark sessions

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

## Contact & Support

### FABBricate
- **Company**: FABBricate IT Solutions GmbH
- **Website**: [www.fabbricate.io](https://www.fabbricate.io/en)
- **Email**: [contact@fabbricate.io](mailto:contact@fabbricate.io)

For any questions, issues, or support regarding this Helm chart, please don't hesitate to contact us.
