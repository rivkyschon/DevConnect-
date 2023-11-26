# DevConnect - Final Project

**Author:** Rivky Schon

**Platform:** Google Cloud Platform (GCP)

## Overview

DevConnect is a project that unites the global DevOps community, employing Docker, Google Kubernetes Engine (GKE), Jenkins, and Google Cloud Platform (GCP). This README provides a brief summary of key stages and features.

## Key Stages

### Stage 1 - Dockerization

- DevConnect web app Dockerized using a lean Dockerfile.
- Automation scripts (`init.sh` and `delete.sh`) for container building and management.
- Persistent storage using Docker volumes.

### Stage 2 - Deployment

- Artifact repository (`rivkyschon-artifacts`) for image version control.
- GKE cluster deployment with efficient workload management.
- Application deployment within the "production" namespace.

### Stage 3 - CI/CD Pipeline

- Jenkins server hosted on a Compute Engine instance.
- Custom Jenkins image with Docker, Docker Compose, and Google Cloud SDK.
- CI/CD pipeline with stages for SCM checkout, build & launch, testing, pushing to the repository, and cleanup.

## Troubleshooting

- Resolved issues such as "Page Not Found," "TemplateSyntaxError," "TemplateDoesNotExist," and "DEFAULT_AUTO_FIELD" warnings.

## Conclusion

DevConnect successfully integrates Docker, GKE, Jenkins, and GCP for efficient containerization, deployment, and CI/CD. This project enhances skills in these technologies, ensuring readiness for future endeavors.

## Architecture Diagram
   
![final2](https://github.com/rivkyschon/DevConnect-/assets/113901370/55c7a3a6-adbc-4f6c-8fd2-3c7cdad06ccc)
