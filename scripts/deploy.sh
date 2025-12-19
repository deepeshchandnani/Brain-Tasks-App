#!/bin/bash
set -e

echo "Updating kubeconfig..."
aws eks update-kubeconfig \
  --region ap-south-1 \
  --name brain-eks

echo "Deploying to EKS..."
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo "Deployment completed"
