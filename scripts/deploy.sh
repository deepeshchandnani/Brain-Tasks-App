#!/bin/bash
set -e

echo "Finding latest deployment archive..."
LATEST_DIR=$(ls -td /opt/codedeploy-agent/deployment-root/*/*/deployment-archive | head -1)

echo "Moving to deployment archive: $LATEST_DIR"
cd "$LATEST_DIR"

echo "Updating kubeconfig..."
aws eks update-kubeconfig \
  --region ap-south-1 \
  --name brain-eks

echo "Deploying to EKS..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "Deployment completed successfully"
