# Tech Eazy DevOps

This repository contains the deployment logic and scripts for deploying a Java Spring Boot application onto an AWS EC2 instance using DevOps practices.

## 📦 Project Structure

- `deploy.sh` – Automates deployment (supports `dev` and `prod` environments).
- `target/` – Contains the built `.jar` file.
- `src/` – Java source code.

## 🚀 Deployment

Run the following command from the `tech_eazy_devops` directory:

```bash
./deploy.sh dev https://github.com/siddhantpatil28/test-repo-for-devops.git
#for prod
./deploy.sh prod https://github.com/siddhantpatil28/test-repo-for-devops.git
