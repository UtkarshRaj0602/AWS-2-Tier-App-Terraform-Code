# íº€ AWS 2-Tier Application (Terraform | DevOps Project)

## í³Œ Overview

This project demonstrates a **production-style AWS 2-Tier architecture** built using **Terraform** and DevOps best practices.

A **Node.js + Express + MySQL application** runs on **EC2 instances in private subnets**, exposed via an **Application Load Balancer (ALB)** and connected securely to **Amazon RDS**.  
Monitoring, alerting, and secure networking are included.

---

## í·  Application Layer (Reference Project)

The application used in this project is based on the following public GitHub repository:

í±‰ **bezkoder/nodejs-express-mysql**  
í´— https://github.com/bezkoder/nodejs-express-mysql

### Application Stack
- Node.js
- Express.js
- MySQL
- REST APIâ€“based backend

âš ï¸ **Note:**  
Only the **application code and setup** are referenced from this repo.  
The **entire AWS infrastructure is designed and deployed using Terraform**, following modular structure and best practices.

---

## í¿—ï¸ Architecture

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

## í» ï¸ Tech Stack

- **Cloud:** AWS
- **IaC:** Terraform
- **Compute:** EC2
- **Load Balancer:** Application Load Balancer (ALB)
- **Database:** Amazon RDS (MySQL)
- **Application:** Node.js, Express
- **Monitoring:** CloudWatch
- **Alerting:** SNS

---

## í¾¯ Project Goals

- Deploy a **working 2-tier application on AWS**
- Use **Terraform with a modular structure**
- Follow **AWS networking & security best practices**
- Enable **monitoring and alerting**
- Practice **real-world DevOps troubleshooting**

---

## í·© Terraform Structure

```text
terraform/
â”œâ”€â”€ modules/
â”‚   â”œâ”€â”€ vpc/
â”‚   â”œâ”€â”€ subnets/
â”‚   â”œâ”€â”€ security-groups/
â”‚   â”œâ”€â”€ alb/
â”‚   â”œâ”€â”€ ec2/
â”‚   â”œâ”€â”€ rds/
â”‚   â”œâ”€â”€ cloudwatch/
â”‚   â””â”€â”€ sns/
â”œâ”€â”€ envs/
â”‚   â”œâ”€â”€ dev/
â”‚   â”œâ”€â”€ stage/
â”‚   â””â”€â”€ prod/
â”œâ”€â”€ provider.tf
â”œâ”€â”€ backend.tf
â”œâ”€â”€ variables.tf
â”œâ”€â”€ outputs.tf
â””â”€â”€ main.tf

## âš™ï¸ High-Level Deployment Flow

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

## íº¨ Common Issues Covered

| Issue | Description |
|------|------------|
| 502 Error | ALB â†’ EC2 Security Group misconfiguration |
| App unreachable | Incorrect route tables |
| DB connection failure | Wrong RDS credentials or SG rules |
| High memory usage | EC2 RAM exhaustion |
| Unhealthy targets | Incorrect ALB health check path |

---

## ï¿½ï¿½ Monitoring & Alerting

- **CloudWatch Metrics**
  - CPU Utilization
  - Memory Usage
  - Disk Usage
  - EC2 Status Checks
- **CloudWatch Alarms**
- **SNS Email Notifications**

---

## í´ Security Highlights

- EC2 instances are **not publicly accessible**
- ALB is the **only internet-facing component**
- RDS accessible **only from the application layer**
- Least-privilege Security Groups

---

## í³š References

- https://github.com/bezkoder/nodejs-express-mysql  
- https://github.com/aws-samples/aws-refarch-wordpress  
- https://github.com/antonputra/tutorials  

---

## íº€ Future Enhancements

- Auto Scaling Groups
- HTTPS using ACM
- Secrets Manager for database credentials
- CI/CD pipeline (GitHub Actions / Jenkins)
- Migration to ECS / EKS

