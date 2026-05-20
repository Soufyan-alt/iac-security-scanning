
 🛡️ IaC Security Infrastructure as Code Security  IaC Scanning 

This project demonstrates a production-grade **Shift-Left Security** implementation using Infrastructure as Code (IaC) auditing frameworks. By incorporating automated security policy enforcement prior to deployment, we mitigate critical cloud misconfigurations—such as wide-open ports and unencrypted storage blocks—ensuring secure-by-default cloud provisioning.

---

## 🛠️ Tech Stack & Tools

Technologies and tools implemented in this project:

### ⚙️ Automation & Infrastructure
* ![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
* ![Checkov](https://img.shields.io/badge/Checkov-FF6B6B?style=for-the-badge&logo=prisma&logoColor=white)

### ☁️ Virtualization & Containers
* ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
* ![LocalStack](https://img.shields.io/badge/LocalStack-1D2026?style=for-the-badge&logo=localstack&logoColor=FF9900)

### 🐧 Operating Systems
* ![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
* ![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

---

## 🎯 Project Overview & Objective

The primary focus of this project is to intercept insecure cloud definitions before they are applied to live environments. 

* **The Problem:** DevOps engineers might accidentally expose internal infrastructure services (e.g., leaving SSH Port 22 open to `0.0.0.0/0`) or provision storage resources without data-at-rest encryption pipelines.
* **The Solution:** Integrating static application security testing (SAST) for infrastructure templates to flag deviations from security baselines, generating rigorous remediation paths.

---

## 📊 Security Scanning Lifecycle

### 🚨 Phase 1: Vulnerability Detection (`FAIL`)
Initially, the infrastructure definition contained critical weaknesses, leading to an immediate block during the Checkov audit phase:
* **`CKV_AWS_24`**: Security Group configured to allow global ingress to Port 22.
* **`CKV_AWS_145`**: AWS S3 Bucket lacking server-side encryption configurations.
