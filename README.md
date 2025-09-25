# 🚀 End-to-End DevOps Environment for a 3-Tier Web Application

**Stack:** AWS · Terraform · Kubernetes (EKS) · Jenkins · Docker

---

## 📌 Project Overview
This project demonstrates how to build a **production-grade DevOps environment** for a **3-Tier Web Application** (Frontend, Backend, Database) on AWS.  

The goal was to automate **infrastructure provisioning, CI/CD pipelines, and application deployment** in a secure, scalable, and repeatable way.  

### 🎯 Outcomes
- Reduced infrastructure setup time from **days → minutes** with **Terraform**.
- Achieved **reliable & repeatable deployments** using Jenkins CI/CD + Docker.
- Enabled **scaling & high availability** with Kubernetes (EKS).
- Improved **security posture** with IAM roles & private networking.
- Centralized application logs and metrics for better observability (future extension).

---

## 🏗️ Architecture
![Architecture Diagram](docs/design.png) <!-- add a diagram later -->

**Key components:**
1. **Terraform** provisions:
   - VPC (public + private subnets, route tables, IGW).
   - Amazon EKS cluster + worker node group.
   - Amazon RDS (Postgres) in private subnets.
   - Amazon ECR repositories for Docker images.
   - EC2 instance for Jenkins with IAM instance profile.
   - Security groups with least-privilege rules.
   - S3 bucket for artifact storage.

2. **CI/CD with Jenkins:**
   - Jenkins pipeline builds Docker images for frontend & backend.
   - Pushes images to Amazon ECR.
   - Deploys updated images to Kubernetes (EKS).

3. **Kubernetes (EKS):**
   - Namespace `app`.
   - Deployments: `frontend`, `backend`.
   - Services: ClusterIP (backend), LoadBalancer (frontend).
   - (Optional) Ingress for clean domain-based routing.

4. **Application:**
   - **Frontend:** Static HTML served by Nginx.
   - **Backend:** Flask API connected to Postgres.
   - **Database:** Amazon RDS (Postgres).

---

## 📂 Repository Structure
```

k8s-3tier-devops/
├── terraform/        # Infrastructure as Code
├── jenkins/          # Jenkins Docker setup & bootstrap script
├── app/              # Application source (frontend & backend)
├── k8s/              # Kubernetes manifests
├── jenkins-pipeline/ # Jenkinsfile for CI/CD
├── scripts/          # Helper scripts (bootstrap, apply, cleanup)
├── docs/             # Architecture docs, diagrams
└── README.md         # Project documentation

````

---

## ⚙️ Step-by-Step Implementation

### 1️⃣ Provision Infrastructure with Terraform
- Created **VPC** with public & private subnets.
- Launched **Amazon EKS** cluster & node group.
- Provisioned **Amazon RDS Postgres** in private subnet.
- Created **ECR repositories** for storing Docker images.
- Launched **EC2 instance** for Jenkins with IAM permissions.
- Configured **Security Groups** (SSH, Jenkins, DB, app traffic).

👉 Run:
```bash
cd terraform
terraform init
terraform apply -auto-approve
````

📌 Terraform outputs include:

* Jenkins public IP.
* RDS endpoint.
* ECR repo URIs.
* EKS cluster name.

---

### 2️⃣ Setup Jenkins on EC2

* Installed Docker, AWS CLI, and kubectl on EC2.
* Ran Jenkins in Docker (`jenkins/jenkins:lts` image).
* Opened Jenkins at `http://<jenkins_public_ip>:8080`.
* Installed suggested plugins and configured credentials.

👉 Jenkins has IAM permissions (instance profile) for:

* Pushing to **ECR**.
* Updating **EKS** kubeconfig.
* Deploying manifests with `kubectl`.

---

### 3️⃣ Build Application (Frontend & Backend)

* **Backend:** Flask API + Postgres client.
* **Frontend:** Static HTML served with Nginx.
* Both apps containerized with **Docker**.

👉 Local test:

```bash
docker build -t backend:local app/backend
docker run -p 8081:80 backend:local
```

---

### 4️⃣ Configure Jenkins Pipeline (CI/CD)

* Wrote `Jenkinsfile` with stages:

  1. Checkout code.
  2. Authenticate with ECR.
  3. Build & push Docker images (frontend + backend).
  4. Deploy workloads to EKS using `kubectl`.

👉 Trigger pipeline → Jenkins builds → pushes → deploys → app live.

---

### 5️⃣ Deploy Workloads on Kubernetes (EKS)

* **Namespace:** `app`
* **Deployments:**

  * `frontend` (2 replicas, LoadBalancer service).
  * `backend` (2 replicas, ClusterIP service).
* **Config:** Injected RDS endpoint + credentials into backend env vars.

👉 Apply manifests manually (first time):

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/backend-deploy.yaml -f k8s/backend-svc.yaml
kubectl apply -f k8s/frontend-deploy.yaml -f k8s/frontend-svc.yaml
```

---

### 6️⃣ Access the Application

* Check LoadBalancer service:

```bash
kubectl -n app get svc frontend
```

* Open the **EXTERNAL-IP** in a browser to see the frontend.
* Frontend calls backend API (`/api`) → backend connects to RDS.

---

### 7️⃣ Cleanup

To destroy all resources and avoid AWS costs:

```bash
cd terraform
terraform destroy -auto-approve
```

---

## 🔒 Security Notes

* IAM roles follow **least-privilege** principle.
* RDS deployed in **private subnets**, not public.
* DB credentials stored in **Terraform variables** (move to Secrets Manager or Kubernetes secrets in prod).
* Jenkins secured with initial admin password + recommended plugins.

---

## 📈 Next Improvements

* Add **Terraform remote state** (S3 + DynamoDB lock).
* Store secrets in **AWS Secrets Manager** or **HashiCorp Vault**.
* Add **cert-manager** + TLS with Let’s Encrypt.
* Add **monitoring stack** (Prometheus + Grafana).
* Extend CI/CD with **GitHub Actions** or **ArgoCD** for GitOps.

---

## ✅ Skills Demonstrated

* AWS Infrastructure as Code (Terraform).
* Containerization with Docker.
* CI/CD pipelines with Jenkins.
* Kubernetes workloads on EKS.
* Infrastructure security (IAM, private networking).
* Real-world DevOps workflow for 3-Tier applications.

---

## 🧑‍💻 Author

**Abdulrahman A. Muhamad**
DevOps | Cloud | SRE Enthusiast

🔗 [LinkedIn](https://www.linkedin.com/in/abdulrahmanalpha) | [GitHub](https://github.com/AbdulrahmanAlpha) | [Portfolio](https://abdulrahman-alpha.web.app)
