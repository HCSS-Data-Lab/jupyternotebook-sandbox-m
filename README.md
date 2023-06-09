# About Jupyternotebook Sandbox-m
[![Publish hcss jupyter docker image](https://github.com/HCSS-Data-Lab/jupyternotebook-sandbox-m/actions/workflows/action.yml/badge.svg?branch=main)](https://github.com/HCSS-Data-Lab/jupyternotebook-sandbox-m/actions/workflows/action.yml)

HCSS Jupyternotebook Definition for M.

## Frameworks used
- Jupyter
- scipy

# Docker image details
## Jupyter notebook
Base image: jupyter/scipy-notebook:33add21fab64         # special version for jupyterhub (https://github.com/jupyter/docker-stacks)
Exposed ports: 8888
Additional installed resources:
- Troubleshooting: vim, net-tools, dos2unix
- Data science: sklearn, pandas, seaborn

# Development
````powershell
# Build docker image
docker build --target hcss-jupyternotebook-m-deploy -t ghcr.io/hcss-data-lab/jupyternotebook-sandbox-m/hcss_jupyternotebook_m:latest .
````
