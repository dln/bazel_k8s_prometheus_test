#!/bin/bash
set -ex
mkdir -p manifests
helm repo update
helm fetch --untar stable/prometheus
helm template --namespace prometheus --name infra --values values.yaml --output-dir=manifests prometheus

