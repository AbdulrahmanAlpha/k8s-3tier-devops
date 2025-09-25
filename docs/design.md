# 🏗️ Architecture Diagram (ASCII)

```

```
                  ┌─────────────────────────┐
                  │        Developer        │
                  │   (Git Push to GitHub)  │
                  └─────────────┬───────────┘
                                │
                                ▼
                      ┌─────────────────┐
                      │     Jenkins     │
                      │  (CI/CD Server) │
                      └───────┬─────────┘
                              │
         ┌────────────────────┼─────────────────────┐
         │                    │                     │
         ▼                    ▼                     ▼
```

┌─────────────────┐  ┌─────────────────┐   ┌─────────────────┐
│ Build Docker     │  │ Push Images to  │   │ Apply K8s       │
│ Images (FE/BE)   │  │ ECR (Registry)  │   │ Manifests to EKS│
└─────────────────┘  └─────────────────┘   └─────────────────┘

```
                                │
                                ▼
                   ┌─────────────────────────┐
                   │    AWS EKS Cluster      │
                   │ (Kubernetes Workloads)  │
                   └──────────┬──────────────┘
                              │
         ┌────────────────────┼───────────────────────┐
         │                    │                       │
         ▼                    ▼                       ▼
```

┌─────────────────┐  ┌─────────────────┐     ┌─────────────────┐
│ Frontend (Nginx)│  │ Backend (Flask) │     │   Database (RDS)│
│  Service: LB    │  │  Service: C-IP  │     │   Private Subnet │
└─────────────────┘  └─────────────────┘     └─────────────────┘
│                    │
└───────────calls────┘

```

---

### 🔑 Flow Explanation
1. **Developer** pushes code → GitHub triggers Jenkins job.  
2. **Jenkins**:
   - Builds Docker images for frontend & backend.  
   - Pushes images to **Amazon ECR**.  
   - Applies Kubernetes manifests to **EKS**.  
3. **EKS Cluster** runs:
   - `frontend` pod (exposed via LoadBalancer).  
   - `backend` pod (internal ClusterIP).  
   - `RDS Postgres` (in private subnet).  
4. End users access the **frontend LoadBalancer URL**, which calls the backend API → RDS.
