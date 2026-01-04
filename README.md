# AWS 2-Tier Application (Terraform | DevOps Project)

## Overview

This project demonstrates a **production-style AWS 2-Tier architecture** built using **Terraform** and DevOps best practices.

A **Node.js + Express + ejs + MySQL application** runs on **EC2 instances in private subnets**, exposed via an **Application Load Balancer (ALB)** and connected securely to **Amazon RDS**.  
Monitoring, alerting, and secure networking are included.

---

## Application Layer (Reference Project)

The application used in this project is based on the following public GitHub repository:

**s-a-zhd/Hospital-Management-Using-NodeJs-Mysql-Express**  
https://github.com/s-a-zhd/Hospital-Management-Using-NodeJs-Mysql-Express.git

### Application Stack
- Node.js
- Express.js
- ejs
- MySQL

 **Note:**  
Only the **application code and setup** are referenced from this repo.  
The **entire AWS infrastructure is designed and deployed using Terraform**, following modular structure and best practices.

---

## Architecture

---

<img width="3891" height="1523" alt="AWS-2-Tier-App-Architecture-Diagram" src="https://github.com/user-attachments/assets/0d9f6ef4-e3af-4f0f-9fb2-818b19c72d5f" />

---

### Application Layer
- Application Load Balancer (ALB)
- EC2 instances (private subnets)
- Node.js + Express + ejs application
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

## Tech Stack

- **Cloud:** AWS
- **IaC:** Terraform
- **Compute:** EC2
- **Load Balancer:** Application Load Balancer (ALB)
- **Database:** Amazon RDS (MySQL)
- **Application:** Node.js, Express
- **Monitoring:** CloudWatch
- **Alerting:** SNS

---

## Project Goals

- Deploy a **working 2-tier application on AWS**
- Use **Terraform with a modular structure**
- Follow **AWS networking & security best practices**
- Enable **monitoring and alerting**
- Practice **real-world DevOps troubleshooting**

---

## Terraform Structure

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

## High-Level Deployment Flow

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

## Common Issues Covered

| Issue | Description |
|------|------------|
| 502 Error | ALB → EC2 Security Group misconfiguration |
| App unreachable | Incorrect route tables |
| DB connection failure | Wrong RDS credentials or SG rules |
| High memory usage | EC2 RAM exhaustion |
| Unhealthy targets | Incorrect ALB health check path |

---

## Monitoring & Alerting

- **CloudWatch Metrics**
  - CPU Utilization
  - Memory Usage
  - Disk Usage
  - EC2 Status Checks
- **CloudWatch Alarms**
- **SNS Email Notifications**

---

## Security Highlights

- EC2 instances are **not publicly accessible**
- ALB is the **only internet-facing component**
- RDS accessible **only from the application layer**
- Least-privilege Security Groups

---


