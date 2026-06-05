# 🛒 Ecommerce Project Infrastructure

> Production-grade AWS infrastructure for a microservices-based e-commerce platform, provisioned entirely with **Terraform** and shell scripts.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Repository Structure](#repository-structure)
- [Module Breakdown](#module-breakdown)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Deployment Order](#deployment-order)
- [Technologies Used](#technologies-used)
- [Contributing](#contributing)

---

## Overview

This repository contains Infrastructure-as-Code (IaC) for deploying a scalable, secure, and highly available e-commerce platform on **AWS**. The infrastructure is split into numbered Terraform modules, each responsible for a distinct layer of the stack — from networking and security groups through databases, microservices, load balancers, CDN, and SSL certificates.

The numbered naming convention enforces a clear provisioning order and makes dependencies easy to reason about.

---

## Architecture

```
Internet
    │
    ▼
CloudFront (91)
    │
    ▼
Frontend ALB (80) — ACM / TLS (70)
    │
    ▼
Application Components (90)   ← Catalogue Service (60)
    │                                     │
    ▼                                     ▼
Backend ALB (50)                  Backend ALB (50)
    │
    ▼
Databases — RDS / ElastiCache (40)
    │
    ▼
VPC — Subnets, Route Tables (00)
    │
Security Groups & Rules (10, 30)
    │
Bastion Host / VPN (20, 21)
```

---

## Repository Structure

```
ecommerce-project-infra/
├── 00-vpc/            # VPC, subnets, internet/NAT gateways, route tables
├── 10-sg/             # Base security groups (no rules yet)
├── 20-bastion/        # Bastion host for secure SSH access
├── 21-vpn/            # VPN configuration
├── 30-sg-rules/       # Security group ingress/egress rules
├── 40-databases/      # RDS (MySQL/Postgres) and/or ElastiCache
├── 50-backend-alb/    # Internal Application Load Balancer for backend services
├── 60-catalogue/      # Catalogue microservice (EC2 / ECS)
├── 70-acm/            # AWS Certificate Manager — TLS certificates
├── 80-frontend-alb/   # Public-facing Application Load Balancer
├── 90-components/     # Remaining application microservices / components
├── 91-cloudfront/     # CloudFront CDN distribution
└── .gitignore
```

---

## Module Breakdown

| Module | Layer | Key AWS Resources |
|---|---|---|
| `00-vpc` | Networking | VPC, public/private subnets, Internet Gateway, NAT Gateway, route tables |
| `10-sg` | Security | Security group shells (EC2, RDS, ALB, Bastion) |
| `20-bastion` | Access | EC2 Bastion host in public subnet |
| `21-vpn` | Access | VPN endpoint / site-to-site or client VPN |
| `30-sg-rules` | Security | Inbound/outbound rules wired between security groups |
| `40-databases` | Data | RDS instance, subnet groups, parameter groups; optionally ElastiCache |
| `50-backend-alb` | Load Balancing | Internal ALB, target groups, listeners for backend microservices |
| `60-catalogue` | Application | Catalogue service deployment (EC2 / Launch Template / ECS task) |
| `70-acm` | TLS / DNS | ACM certificate request & Route 53 DNS validation |
| `80-frontend-alb` | Load Balancing | Public ALB, HTTPS listener with ACM cert, target groups |
| `90-components` | Application | Remaining microservices (cart, user, shipping, payment, etc.) |
| `91-cloudfront` | CDN | CloudFront distribution in front of the public ALB |

---

## Prerequisites

| Tool | Minimum Version |
|---|---|
| [Terraform](https://developer.hashicorp.com/terraform/downloads) | `>= 1.3` |
| [AWS CLI](https://aws.amazon.com/cli/) | `>= 2.x` |
| AWS Account | — |
| IAM user/role with sufficient permissions | `AdministratorAccess` or scoped policy |
| An existing Route 53 hosted zone (for ACM DNS validation) | — |

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Shankar-codes/ecommerce-project-infra.git
cd ecommerce-project-infra
```

### 2. Configure AWS credentials

```bash
aws configure
# or export environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

### 3. Initialise and apply each module in order

Each module is self-contained. Navigate into a folder, initialise Terraform, review the plan, then apply:

```bash
cd 00-vpc
terraform init
terraform plan
terraform apply
```

Repeat for each numbered module in sequence (see [Deployment Order](#deployment-order)).

### 4. Passing outputs between modules

Some modules depend on outputs from earlier ones (e.g., VPC ID, subnet IDs, security group IDs). These are typically referenced via remote state or `terraform_remote_state` data sources. Check each module's `variables.tf` / `data.tf` for the expected inputs.

---

## Deployment Order

Follow the modules strictly in numerical order to respect dependencies:

```
00-vpc  →  10-sg  →  20-bastion  →  21-vpn  →  30-sg-rules
    →  40-databases  →  50-backend-alb  →  60-catalogue
    →  70-acm  →  80-frontend-alb  →  90-components  →  91-cloudfront
```

> **Tip:** Destroying the infrastructure requires the **reverse** order.

---

## Technologies Used

- **Terraform (HCL)** — Infrastructure provisioning (~93% of codebase)
- **Shell scripts** — Helper/bootstrap scripts (~7%)
- **AWS Services:**
  - VPC, Subnets, NAT Gateway, Internet Gateway
  - EC2, Security Groups
  - Application Load Balancer (ALB)
  - RDS (Relational Database Service)
  - ElastiCache (optional)
  - AWS Certificate Manager (ACM)
  - CloudFront
  - Route 53

---

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m "feat: describe your change"`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

Please ensure `terraform fmt` and `terraform validate` pass before submitting.

---

> Built with ❤️ by [Shankar-codes](https://github.com/Shankar-codes)
