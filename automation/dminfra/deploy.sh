#!/bin/bash

# deploy a preview of the infrastructure
gcloud deployment-manager deployments create dminfra --config=config.yaml --preview

# commit the preview
gcloud deployment-manager deployments update dminfra
