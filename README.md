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
helm repo add spark-connect https://your-repo-url
```

2. Install the chart:
```bash
helm install spark-connect spark-connect/spark-connect
```

## Configuration

For detailed configuration options, please refer to the [chart's README](charts/spark-connect/README.md).

## Architecture

The chart deploys the following components:

1. Spark Connect StatefulSet
   - Runs the Spark Connect service
   - Configures object storage integration
   - Manages SSL trust configuration
   - Supports auto-scaling via Kubernetes as the Spark cluster manager

2. NGINX Service (Optional)
   - Provides SSL termination
   - Routes traffic to Spark UI and Spark Connect
   - Uses LoadBalancer service type
   - Configures TLS certificates via cert-manager

3. Celeborn Integration
   - Provides external shuffle service
   - Enhances performance for large-scale data processing
   - Reduces memory pressure on Spark executors

4. Hive Metastore Integration
   - Enables metadata management
   - Supports table and partition management
   - Facilitates data governance

## Security

- SSL/TLS termination is handled by NGINX (when enabled)
- Object storage integration supports SSL trust configuration
- Registry credentials are managed via Kubernetes secrets
- Trust manager handles certificate management for object storage connections

## Notes

- The chart provides flexibility in deployment options:
  - Direct cluster access
  - NGINX-based external access
- Object storage integration requires proper secret and trust bundle configuration
- External DNS is used for automatic DNS record management (when enabled)
- Trust manager is used for certificate management (when required)

## Development

For development guidelines and contribution instructions, please refer to the [chart's README](charts/spark-connect/README.md).

## ToDo

- Implement authentication
- Add Spark History Server integration
- Optimize sizing and autoscaling
- Improve EDP-specific configurations
- Integrate with APISIX for enhanced security
- Add support for multiple object storage providers
- Add support for custom resource definitions (CRDs)
- Add support for custom metrics and monitoring
- Add support for custom logging configurations
- Add support for custom network policies

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
