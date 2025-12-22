# ��� AWS 2-Tier Application – STAGE (Terraform | DevOps Project)

## ��� Overview

This project represents the **STAGE environment** for a **production-style AWS 2-Tier architecture**, built using **Terraform** and DevOps best practices.

The stage setup is used for **testing, validation, and troubleshooting** before changes are promoted to production.

A **Node.js + Express + MySQL application** runs on **EC2 instances in private subnets**, exposed via an **Application Load Balancer (ALB)** and connected securely to **Amazon RDS**.

Monitoring, alerting, and secure networking are enabled to closely mirror the production environment.

---

## ��� Application Layer (Reference Project)

The application used in this project is based on the following public GitHub repository:

**bezkoder/nodejs-express-mysql**  
https://github.com/bezkoder/nodejs-express-mysql

### Application Stack
- Node.js
- Express.js
- MySQL
- REST API–based backend

⚠️ **Note:**  
Only the **application code and setup** are referenced from this repository.  
The **entire AWS infrastructure is provisioned using Terraform**, following modular design and environment isolation for **stage**.

---

## ���️ Architecture (Stage)

### Application Layer
- Application Load Balancer (ALB)
- EC2 instances (private subnets)
- Node.js + Express application
- ALB health checks

### Database Layer
- Amazon RDS (MySQL)
- Private subnets only
- Secure access from EC2

### Supporting Services
- VPC (multi-AZ)
- Public & Private subnets
- Internet Gateway & NAT Gateway
- CloudWatch metrics & alarms
- SNS for notifications

---

## ���️ Tech Stack

- **Cloud:** AWS  
- **Infrastructure as Code:** Terraform  
- **Compute:** EC2  
- **Load Balancer:** Application Load Balancer (ALB)  
- **Database:** Amazon RDS (MySQL)  
- **Application:** Node.js, Express  
- **Monitoring:** CloudWatch  
- **Alerting:** SNS  

---

## ��� Stage Environment Goals

- Validate infrastructure changes before production
- Test application deployments safely
- Verify networking and security configurations
- Test monitoring and alerting behavior
- Practice **real-world DevOps troubleshooting**

---

## ��� Terraform Structure (Stage)

```text
terraform/
├── modules/
│   ├── vpc/
│   ├── subnets/
│   ├── security-groups/
│   ├── alb/
│   ├── ec2/
│   ├── rds/
│   ├── cloudwatch/
│   └── sns/
├── envs/
│   ├── stage/
│   └── prod/
├── provider.tf
├── backend.tf
├── variables.tf
├── outputs.tf
└── main.tf
```

## ⚙️ High-Level Deployment Flow (Stage)

1. Create VPC with public and private subnets
2. Configure Internet Gateway, NAT Gateway, and route tables
3. Launch EC2 instances in private subnets
4. Install Node.js application on EC2
5. Deploy RDS MySQL in private subnets
6. Connect application to RDS using environment variables
7. Configure ALB with target groups and health checks
8. Enable CloudWatch monitoring and alarms
9. Send alerts via SNS

---

## ��� Common Issues Tested in Stage

| Issue | Description |
|------|------------|
| 502 Error | ALB → EC2 Security Group misconfiguration |
| App unreachable | Incorrect route tables |
| DB connection failure | Wrong RDS credentials or SG rules |
| High memory usage | EC2 RAM exhaustion |
| Unhealthy targets | Incorrect ALB health check path |

---

## ��� Monitoring & Alerting

### CloudWatch Metrics
- CPU Utilization
- Memory Usage
- Disk Usage
- EC2 Status Checks

### Alerts
- CloudWatch Alarms
- SNS Email Notifications

---

## ��� Security Highlights (Stage)

- EC2 instances are **not publicly accessible**
- ALB is the **only internet-facing component**
- RDS accessible **only from the application layer**
- Least-privilege Security Groups enforced

---

## ��� Purpose of Stage Environment

The **stage environment** acts as a safety net before production:

- Catch misconfigurations early
- Test failure scenarios
- Validate Terraform changes
- Ensure production parity

