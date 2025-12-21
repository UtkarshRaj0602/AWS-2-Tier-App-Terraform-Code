AWS 2-Tier Application (Terraform | DevOps Project)


Overview

This project implements a production-style AWS 2-Tier architecture using Terraform (Infrastructure as Code), following modular design and DevOps best practices.

The infrastructure provisions and runs a real Node.js application on EC2 behind an Application Load Balancer, connected securely to Amazon RDS, with monitoring and alerting enabled.

The application layer is adapted from a public reference implementation and re-architected to align with production, security, and observability standards.


Reference Application (Upstream)

The application used in this project is based on the following public GitHub repository:

Empyrexn/AWS-Two-Tier-Todo-App-Deployment
https://github.com/Empyrexn/AWS-Two-Tier-Todo-App-Deployment

Why this repo was chosen:

Real Node.js Todo application

Proven EC2 + ALB + RDS setup

Clear separation of app and DB layers

Suitable for production-like DevOps hardening


Architecture

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


Tech Stack

Cloud: AWS

IaC: Terraform (modules-based)

Compute: EC2

Load Balancer: Application Load Balancer

Database: Amazon RDS

App Runtime: Node.js

Process Manager: PM2

Monitoring: CloudWatch

Alerting: SNS
