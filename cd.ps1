Write-Host "Deploying Aegis to Minikube..."


kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml
kubectl apply -f k8s/deployment.yaml


# Update Deployment image
kubectl set image deployment/aegis-deployment `
aegis-container=ghcr.io/fruststorm/aegis-app:latest `
-n aegis

