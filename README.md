<h1>DevConnect Web App!</h1>

* <h3>Introduction</h3>
The DevConnect project aims to unite the global DevOps community by creating a platform that fosters communication, collaboration, and knowledge sharing among DevOps professionals. This project focuses on implementing the best DevSecOps practices and leveraging Google Cloud Platform (GCP) technologies.

* <h3>Dockerization</h3>

    * I've crafted a Dockerfile that encapsulates all the necessary requirements for the application to seamlessly run across various environments.

    * To streamline the deployment and removal processes, I've developed two crucial shell scripts: init.sh and delete.sh. These scripts are designed to efficiently handle the initialization and deletion of the application environment.

    * Ensuring data persistence is a priority for the application's reliability. I personally established a persistent volume to securely store essential data, contributing to a robust and consistent user experience.

* <h3>Deployment</h3>

    * I established an artifact repository to store Docker images.

    * I set up a  GKE cluster.

    * I exposed the application through a LoadBalancer service, providing user access via a web browser.
      
* <h3>CI/CD Pipeline with Jenkins</h3>

    * I created a Compute Engine virtual machine for Jenkins automation.

    * I built the Jenkins image, uploaded it to the artifact registry, and executed it within the Compute Engine instance.

    * I implemented a CI/CD pipeline for automated builds and deployments.
      
* <h3>Architecture Diagram</h3>

