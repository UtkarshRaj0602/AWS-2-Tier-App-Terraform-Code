# ��� Phase 1 – AWS 2-Tier Application (Terraform | DevOps Project)

## Overview

This project implements a **production-style AWS 2-Tier architecture** using **Terraform (Infrastructure as Code)**, following **modular design and DevOps best practices**.

The infrastructure provisions and runs a **real Node.js application** on EC2 behind an **Application Load Balancer**, securely connected to **Amazon RDS**, with monitoring and alerting enabled.

The application layer is adapted from a public reference repository and re-architected to align with **production, security, and observability standards**.

---

## Reference Application

This project uses a public Node.js application as the application layer reference:

- Repository: https://github.com/Empyrexn/AWS-Two-Tier-Todo-App-Deployment

Why this repository:
- Real working **Node.js Todo application**
- Proven **EC2 + ALB + RDS** architecture
- Clear separation of application and database layers
- Suitable for production-like DevOps hardening

Note:
The application code is reused, but **all infrastructure is rebuilt from scratch using Terraform modules** and best practices.

---

## Architecture

### Application Layer
- Application Load Balancer (ALB)
- EC2 instances in private subnets
- Node.js application managed using PM2
- Target groups and health checks

### Database Layer
- Amazon RDS (MySQL / PostgreSQL)
- Private subnets only
- Parameter groups and security isolation

### Supporting Components
- Custom VPC (multi-AZ)
- Public and private subnets
- Internet Gateway and NAT Gateway
- CloudWatch metrics and alarms
- SNS for alert notifications

---

## Tech Stack

- Cloud: AWS
- Infrastructure as Code: Terraform (modules-based)
- Compute: EC2
- Load Balancer: Application Load Balancer
- Database: Amazon RDS
- Application Runtime: Node.js
- Process Manager: PM2
- Monitoring: CloudWatch
- Alerting: SNS

---

## Project Objectives

- Build a real, working **AWS 2-tier application**
- Follow **Terraform best practices**
- Design secure networking and access control
- Enable monitoring and alerting
- Practice real-world DevOps troubleshooting
- Maintain clear and reusable documentation

---

## Terraform Structure

terraform/
├── modules/
│ ├── vpc/
│ ├── subnets/
│ ├── security-groups/
│ ├── alb/
│ ├── ec2/
│ ├── rds/
│ ├── cloudwatch/
│ └── sns/
├── envs/
│ ├── dev/
│ ├── stage/
│ └── prod/
├── backend.tf
├── provider.tf
├── variables.tf
├── outputs.tf
└── main.tf


Key points:
- Modular and reusable Terraform code
- Environment-based separation
- Remote backend (S3 + DynamoDB)
- Clean variable and output handling

---

## Deployment Flow

1. Create VPC with public and private subnets
2. Configure Internet Gateway, NAT Gateway, and route tables
3. Deploy EC2 instances in private subnets
4. Install Node.js application using user-data or scripts
5. Deploy RDS in private subnets
6. Secure application-to-database access using Security Groups
7. Deploy Application Load Balancer
8. Configure target groups and health checks
9. Enable CloudWatch metrics and alarms
10. Send alerts using SNS

---

## Real-World Failure Scenarios Covered

This project intentionally covers common production issues:

| Issue | Scenario |
|------|---------|
| 502 Bad Gateway | ALB to EC2 Security Group misconfiguration |
| App unreachable | Incorrect subnet routing |
| DB connection failure | Wrong RDS credentials or SG rules |
| Memory pressure | EC2 RAM exhaustion |
| Unhealthy targets | Incorrect ALB health check path |

Each issue is identified, analyzed, and resolved as part of this project.

---

## Monitoring and Alerting

CloudWatch Metrics:
- CPU Utilization
- Memory Usage
- Disk Usage
- EC2 Status Checks

Alarms:
- High CPU or Memory usage
- Instance health check failures

Notifications:
- SNS email alerts

---

## Security Highlights

- EC2 instances are not publicly accessible
- ALB is the only public entry point
- Least-privilege Security Groups
- RDS isolated in private subnets
- Secrets passed via variables (extendable to AWS Secrets Manager)

---

## Summary

This project reflects how **real AWS production infrastructure** is designed and operated:
- Automation over manual configuration
- Observability over guesswork
- Security by default
- Terraform done the right way

