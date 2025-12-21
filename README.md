��� Phase 1 – AWS 2-Tier Application (Terraform | DevOps Project)
��� Overview

This project implements a production-style AWS 2-Tier architecture using Terraform (Infrastructure as Code), following modular design and DevOps best practices.

The infrastructure provisions and runs a real Node.js application on EC2 behind an Application Load Balancer, connected securely to Amazon RDS, with monitoring and alerting enabled.

The application layer is adapted from a public reference implementation and re-architected to align with production, security, and observability standards.

��� Reference Application (Upstream)

The application used in this project is based on the following public GitHub repository:

��� Empyrexn/AWS-Two-Tier-Todo-App-Deployment
��� https://github.com/Empyrexn/AWS-Two-Tier-Todo-App-Deployment

Why this repo was chosen:

Real Node.js Todo application

Proven EC2 + ALB + RDS setup

Clear separation of app and DB layers

Suitable for production-like DevOps hardening

⚠️ Note:
This project does not copy infrastructure as-is.
Instead, the app is reused while the entire infrastructure is rebuilt using Terraform modules, best practices, and environment isolation.

���️ Architecture
Tier 1 – Application Layer

Application Load Balancer (ALB)

EC2 instances (private subnets)

Node.js application (PM2-managed)

Health checks & target groups

Tier 2 – Database Layer

Amazon RDS (MySQL / PostgreSQL)

Private subnets only

Parameter groups & security isolation

Supporting Components

Custom VPC (multi-AZ)

Public & Private subnets

Internet Gateway + NAT Gateway

CloudWatch metrics & alarms

SNS for alert notifications

���️ Tech Stack

Cloud: AWS

IaC: Terraform (modules-based)

Compute: EC2

Load Balancer: Application Load Balancer

Database: Amazon RDS

App Runtime: Node.js

Process Manager: PM2

Monitoring: CloudWatch

Alerting: SNS

��� Project Objectives

Build a real, working 2-tier application

Implement Terraform best practices

Design secure networking and access control

Enable monitoring and alerting

Practice real-world DevOps troubleshooting

Maintain clear documentation

��� Terraform Structure (Best Practices)
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
│   ├── dev/
│   ├── stage/
│   └── prod/
├── backend.tf
├── provider.tf
├── variables.tf
├── outputs.tf
└── main.tf


✔ Modular & reusable
✔ Environment-specific configs
✔ Remote backend (S3 + DynamoDB)
✔ Clean variable & output usage

⚙️ Deployment Flow

Provision VPC with public & private subnets

Configure IGW, NAT Gateway, and route tables

Deploy EC2 instances in private subnets

Install Node.js app via user-data / scripts

Deploy RDS in private subnets

Secure app → DB connectivity via SG rules

Deploy ALB (HTTPS-ready)

Configure target groups & health checks

Enable CloudWatch metrics and alarms

Send alerts using SNS

��� Real-World Failure Scenarios Covered

This project intentionally focuses on production-grade issues, not just happy paths.

Issue	Scenario
502 Bad Gateway	ALB → EC2 Security Group misconfiguration
App unreachable	Incorrect subnet routing
DB connection failure	Wrong RDS credentials or SG rules
Memory pressure	EC2 RAM exhaustion
Unhealthy targets	Incorrect ALB health check path

Each issue is documented, diagnosed, and resolved.

��� Monitoring & Alerting

CloudWatch Metrics

CPU Utilization

Memory Usage

Disk Usage

EC2 Status Checks

Alarms

High CPU / Memory

Instance health failure

Notifications

SNS email alerts

��� Security Highlights

No public EC2 instances

ALB is the only public entry point

Least-privilege Security Groups

RDS isolated in private subnets

Secrets passed via variables (extendable to Secrets Manager)
