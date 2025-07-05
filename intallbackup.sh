#!/bin/bash

# Initialize Helm
helm dependency update

# Deploy everything
helm upgrade --install web-app-monitoring . \
  --namespace web-app \
  --create-namespace \
  --values values.yaml

# Print access info
echo "Grafana URL: $(kubectl get svc -n web-app web-app-monitoring-grafana -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
echo "Web App URL: $(kubectl get svc -n web-app web-app-monitoring-web-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}')"
