#!/bin/bash
set -e

echo "Moving to deployment archive..."
cd /opt/codedeploy-agent/deployment-root/*/*/deployment-archive

echo "Updating kubeconfig..."
aws eks update-kubeconfig \
  --region ap-south-1 \
  --name brain-eks

echo "Deploying to EKS..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "Deployment completed successfully"
