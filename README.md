Brain-Tasks-App – Production Deployment on AWS (EKS)

Project Overview

This project demonstrates end-to-end production deployment of a React-based static application using Docker, AWS ECR, AWS EKS, CodeBuild, CodeDeploy, CodePipeline, and CloudWatch.

The application is containerized using NGINX, deployed on Kubernetes (EKS), and fully automated using CI/CD pipeline.

Tech Stack Used

Frontend: React (Static build)

Web Server: NGINX

Containerization: Docker

Container Registry: AWS ECR

Orchestration: AWS EKS (Kubernetes)

CI/CD: GitHub → CodePipeline → CodeBuild → CodeDeploy

Monitoring: AWS CloudWatch Logs

Region: ap-south-1 (Mumbai)


Repository Structure

.
├── dist/                 # React build files
├── k8s/
│   ├── deployment.yaml   # Kubernetes Deployment
│   └── service.yaml      # Kubernetes LoadBalancer Service
├── scripts/
│   └── deploy.sh         # CodeDeploy deployment script
├── Dockerfile            # Docker image build (NGINX)
├── nginx.conf            # Custom NGINX config (port 3000)
├── buildspec.yml         # CodeBuild instructions
├── appspec.yml           # CodeDeploy configuration
└── README.md

Application Setup Instructions

1. Clone Repository

git clone https://github.com/deepeshchandnani/Brain-Tasks-App.git
cd Brain-Tasks-App

2. Docker Image Build (Local / CodeBuild)
 
docker build -t brain-tasks-nginx .

3. Push Image to AWS ECR

Create ECR repository

Authenticate Docker to ECR

Tag & push image

(Handled automatically via CodeBuild)

4. Kubernetes Deployment (EKS)

Apply Kubernetes manifests:

kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

Service type is LoadBalancer, exposing the application publicly.

5. Application Access

Application is accessible via AWS Load Balancer DNS on port 3000.

CI/CD Pipeline Explanation
 Source Stage

GitHub (via GitHub App)

Any push to main branch triggers the pipeline

 Build Stage (AWS CodeBuild)

Uses buildspec.yml

Steps performed:

Docker image build

Docker image tag

Push image to AWS ECR

 Deploy Stage (AWS CodeDeploy)

Uses appspec.yml

Runs scripts/deploy.sh

Steps performed:

Updates kubeconfig

Applies Kubernetes deployment & service YAML

Deploys updated image to EKS cluster

 Pipeline Flow Diagram
GitHub
  ↓
CodePipeline
  ↓
CodeBuild (Docker → ECR)
  ↓
CodeDeploy
  ↓
EKS (Kubernetes Deployment)

 Monitoring & Logs (CloudWatch)
 CodeDeploy Logs

Deployment lifecycle logs available in:

CloudWatch → Log groups → /aws/codedeploy/brain-tasks-app

 EKS Application Logs

Fluent Bit streams pod logs to:

/aws/eks/brain-eks/application


Includes:

Container stdout/stderr

NGINX access & error logs

 Kubernetes LoadBalancer Details

Service Type: LoadBalancer

Application Port: 3000

 LoadBalancer ARN
http://a192825c0868644e08bbd11a77f9276c-1755325760.ap-south-1.elb.amazonaws.com:3000


Note: Infrastructure was cleaned up after successful deployment to avoid unnecessary cloud costs.
ARN was captured at deployment time as proof.

 Screenshots Included

CodePipeline execution (Success)

CodeBuild logs

CodeDeploy deployment

EKS cluster & nodes

CloudWatch log groups

Application running via LoadBalancer URL

 Conclusion

This project demonstrates a production-ready DevOps workflow using AWS managed services with best practices such as:

Containerized deployment

Automated CI/CD

Kubernetes orchestration

Centralized logging & monitoring

 Author
Deepesh Chandanani

   




