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

# Wait for key pods to be ready
echo "Waiting for Grafana pod to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=grafana -n web-app --timeout=120s

echo "Waiting for Prometheus pod to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=prometheus -n web-app --timeout=120s

echo "Waiting for Loki pod to be ready..."
kubectl wait --for=condition=ready pod -l app=loki -n web-app --timeout=120s

# Port-forward services
echo "Starting port-forwarding..."

kubectl port-forward svc/web-app-monitoring-grafana 3000:80 -n web-app &
kubectl port-forward svc/web-app-monitoring-kube-pr-prometheus 9090:9090 -n web-app &
kubectl port-forward svc/web-app-monitoring-loki 3100:3100 -n web-app &

echo "Grafana:    http://localhost:3000"
echo "Prometheus: http://localhost:9090"
echo "Loki:       http://localhost:3100"
echo "Web App:    http://<node-ip>:30080 (since it's exposed via NodePort)"

# Keep the script alive to maintain port-forwarding
wait
