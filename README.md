# Aegis (DevOps + DevSecOps) project


## Overview
This is a learning project to build an end-to-end DevOps + DevSecOps Framework called Aegis.


## Goals of the project
The primary objectives of this project are to:
- Understand DevOps workflows from code to deployment
- learn containerization through Docker and container orchestration using Kubernetes
- Build and secure CI/CD pipelines
- Apply DevSecOps principles such as shift-left security and runtime detection
- Understand trade-offs between security, and complexity


## Architecture
The framework is composed of the following components:
- Kubernetes cluster
- Docker (containerization)
- CI: GitHub Actions
- CD: Powershell-based deployment script
- Infrastructure as code: Terraform
- Policy enforcement: OPA Gatekeeper
- secrets detection: Gitleaks
- infrastructure scanning (Checkov)
- image and file system scanning: Trivy
- SAST: Semgrep
- DAST (baseline) scan: OWASP ZAP
- Runtime Security: Falco
- Observability: Prometheus & Grafana


## Workflow
Application code is built and containerized using Docker and deployed to a Kubernetes cluster.

During the CI phase, multiple security checks are performed, including static and dynamic testing, secret detection, image scanning,
and infrastructure scanning.
If any critical issues are detected, the pipeline fails and the deployment is blocked. Only validate artifacts are allowed to proceed
to deployment.

This workflow demonstrate shift-left security while maintaining automated delivery.


## Observability
Observability is implemented to provide visibility into both application and kubernetes cluster
- Grafana dashboards are used to monitor pods and cluster health
- Kubernetes logs are used to investigate application level-issues

- Observability helps detect abnormal behavior and supports incident respond.


## Security Decisions & Trade-offs
Strict non-root enforcement is applied to application workloads.
Monitoring components run in a dedicated namespace with controlled policy exception due to operational requirements 


