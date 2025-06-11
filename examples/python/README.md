# Spark Connect Python Notebook Setup Guide

This guide will help you set up and run the Spark Connect Python notebooks. The environment is configured using Conda and matches the exact versions used in development.

## Prerequisites

- [Conda](https://docs.conda.io/en/latest/) or [Miniforge](https://github.com/conda-forge/miniforge) installed on your system
- Git (to clone the repository if needed)

## Setup Instructions

1. **Create and activate the Conda environment**

   ```bash
   # Create a new conda environment using the provided environment.yaml
   conda env create -f environment.yaml

   # Activate the environment
   conda activate pyspark
   ```

   This will create an environment with Python 3.10.17 and all necessary dependencies, including:
   - PySpark 3.5.4
   - Jupyter notebooks

2. **Set up the Jupyter Kernel**

   ```bash
   # Install ipykernel if not already installed
   conda install -n pyspark ipykernel

   # Create a kernel for the pyspark-test environment
   python -m ipykernel install --user --name pyspark --display-name "Python (pyspark)"
   ```

3. **Start Jupyter Notebook**

   Try one of these methods to start Jupyter Notebook:

   ```bash
   # Method 1: Using Python (recommended)
   python -m notebook

   # Method 2: Using Jupyter command (if Method 1 doesn't work)
   jupyter notebook

   # Method 3: If both above fail, try installing notebook explicitly
   conda install notebook
   python -m notebook
   ```

4. **Choose and Open the Appropriate Notebook**
   
   Once Jupyter opens in your browser, you'll find two notebooks:

   - `port_forward_connection.ipynb`: Use this notebook when connecting directly to Spark Connect through Kubernetes port-forwarding
     - Configured for direct spark cluster access via kubernetes port forwarding
     - No TLS configurations required
     - No NGINX required

   - `test_exposed-spark-connect_TLS_S3.ipynb`: Use this notebook when connecting through NGINX
     - Configured for external access through NGINX
     - Uses proper FQDNs and TLS configurations
     - Requires NGINX to be enabled in the Helm chart
     - Requires that the CA certificate is available for the client

   For either notebook:
   - Click to open the notebook
   - Make sure to select the "Python (pyspark)" kernel from the kernel menu (Kernel > Change kernel)
   - Update the connection details according to your deployment
   - You can now run the cells in the notebook

## Environment Details

The environment includes:
- Python 3.10.17
- PySpark 3.5.4
- Delta Lake 3.0.0
- PyArrow 20.0.0
- Other dependencies for cloud storage (AWS, Azure) and data processing

## Troubleshooting

If you encounter any issues:

1. **Environment Creation Fails**
   - Make sure you have the latest version of conda
   - Try updating conda: `conda update -n base conda`

2. **Package Conflicts**
   - Clear conda cache: `conda clean --all`
   - Try creating the environment again

3. **Jupyter Kernel Issues**
   - List available kernels: `jupyter kernelspec list`
   - If needed, remove the kernel: `jupyter kernelspec remove pyspark`
   - Reinstall the kernel using the steps in section 2

4. **Jupyter Notebook Launch Issues**
   - Ensure notebook is installed: `conda list | grep notebook`
   - Try installing notebook explicitly: `conda install notebook`
   - Check if jupyter is in PATH: `which jupyter`
   - Try running with full path: `python -m notebook`

5. **Connection Issues**
   - Verify your Helm chart configuration matches the notebook you're using
   - Check if NGINX is enabled/disabled as required
   - Ensure the hostname and port match your deployment
   - Verify network connectivity to the Spark Connect service

## Notes

- The environment is configured to use the conda-forge channel for package installation
- All package versions are pinned to ensure reproducibility
- The environment includes support for AWS and Azure cloud storage integration
- Choose the appropriate notebook based on your deployment configuration

## License

Copyright 2024

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. 