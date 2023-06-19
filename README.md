# Tomcat Server Deployment using Terraform and GitHub Actions

This repository contains Terraform code and a GitHub Actions configuration for deploying a Tomcat server on an EC2 instance in AWS.

## Prerequisites

Before deploying the Tomcat server, make sure you have the following prerequisites:

1. AWS account credentials with appropriate permissions.
2. Terraform installed on your local machine.

## Deployment Steps

Follow the steps below to deploy the Tomcat server using Terraform and GitHub Actions:

1. Clone this repository to your local machine.

2. Navigate to the repository directory.

3. Update the Terraform code (`terra.tf`) with your desired configuration, such as region, AMI, instance type, key name, etc.

4. Update the GitHub Actions file (`main.yml`) if required, such as specifying a different branch for triggering the workflow.

5. Commit and push the changes to the main branch of the repository.

6. GitHub Actions will automatically trigger the workflow and execute the Terraform deployment.

7. Monitor the deployment progress and check the GitHub Actions logs for any errors or issues.

8. Once the deployment is successful, you can access the Tomcat server by using the public IP or DNS of the EC2 instance on port 8080 (e.g., `http://<public-ip>:8080/sample`).

9. To clean up the infrastructure, run the `terraform destroy -auto-approve` command locally or modify the GitHub Actions workflow to include the `terraform destroy` step.

## Conclusion

By following these steps, you can easily deploy a Tomcat server on an EC2 instance using Terraform and automate the deployment process using GitHub Actions.

For more information, please refer to the Terraform documentation and GitHub Actions documentation.
