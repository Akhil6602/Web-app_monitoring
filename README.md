 Kubernetes Monitoring Stack with Prometheus, Grafana, Loki & Promtail

This project sets up a complete observability stack on Kubernetes using open source tools:

Prometheus for metrics

Grafana for visualization

Loki for logs

Promtail for log shipping

A static web app deployed as a demo workload

Built and tested using Rancher Desktop (local Kubernetes) with Helm.

🔧 Technologies Used

Tool

Purpose

Helm

Package manager for Kubernetes

kube-prometheus-stack

All-in-one Prometheus + Grafana monitoring chart

loki-stack

Loki and Promtail for logging

Docker Hub

Hosting static web app image

📂 Project Structure

demo-monitoring-setup/
├── Chart.yaml
├── values.yaml
├── install.sh
├── templates/
│   └── webapp/
│       ├── Deployment.yaml
│       └── service.yaml
├── charts/
│   ├── kube-prometheus-stack-48.1.1.tgz
│   └── loki-stack-2.9.10.tgz

🛠️ Features

📊 Auto-provisioned Prometheus + Grafana for cluster metrics

📦 Auto-deployed Loki + Promtail for log aggregation

🌐 Web app exposed via NodePort

🧠 Dashboards auto-imported from Grafana.com

🔐 Admin password configured via values.yaml

📦 Deployment Steps

1. Clone the Repo

git clone https://github.com/akhil575/demo-monitoring-setup.git
cd demo-monitoring-setup

2. Install Dependencies

helm dependency update

3. Deploy via Script

chmod +x install.sh
./install.sh

4. Access Tools

Tool

URL

Grafana

http://localhost:3000

Prometheus

http://localhost:9090

Loki API

http://localhost:3100

Web App

http://localhost:30080

Default Grafana login: admin / admin

🧠 Dashboards Used

Dashboard Name

ID

Datasource

Kubernetes Cluster Monitoring

11074

Prometheus

Node Exporter Full

1860

Prometheus

Loki Logs Explorer

13639

Loki
