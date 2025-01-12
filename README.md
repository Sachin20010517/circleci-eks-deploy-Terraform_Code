
# Provisioning the Amazon EKS cluster using Terraform
This repository contains the terraform file code, which we can use to provision the **Amazon EKS** cluster as part of Project 4 of our **10WeeksofCloudOps** series! In this comprehensive hands-on project, we dive deep into the world of **GitOps and ArgoCD**, demonstrating how to implement these essential DevOps practices step by step by **dockerizing** the application and provisioning the infrastructure using **Terraform**(this repo).

## Architecture Diagram

![Architecture Diagram](https://cdn-images-1.medium.com/max/800/1*T5IRoSoiqT8qnYLUprsRUQ.png)


## Installation of Terraform
Follow the below steps to Install the Terraform and another dependency.

1️⃣ Clone the repo

``` git clone https://github.com/piyushsachdeva/10weeksofcloudops-week4-tf.git ```

2️⃣ Let's install dependency to deploy the application

``` 
  cd kube_terraform/ToDo-App/
  terraform init
```

3️⃣ **Create the S3 Bucket and DynamoDB Table**:

Before configuring the backend in Terraform, ensure you create the S3 bucket and DynamoDB table in your AWS account.

### I) Create the S3 Bucket:

- Go to the AWS S3 console and create a bucket with a unique name (e.g., `your-unique-s3-bucket-name`).  
- Ensure the bucket's region matches your EKS cluster's region.

### II) Create the DynamoDB Table:

- Go to the DynamoDB console and create a table.  
  - **Table Name**: Choose a name (e.g., `your-dynamodb-table-name`).  
  - **Partition Key**: Set the **partition key** as `LockID` of type `String`.  
    This key is required for Terraform to use DynamoDB for state locking.

    
4️⃣ Edit the below file according to your configuration

`vim kube_terraform/ToDo-App/backend.tf`

add below code

```
terraform {
  backend "s3" {
    bucket = "S3-BUCKET-NAME"
    key    = "backend/TFSTATE-FILE.tfstate"
    region = "us-east-1"
    dynamodb_table = "DYNAMODB-TABLE-NAME"
  }
}
```

Let's set up the variable for our Infrastructure and create one file with the name of terraform.tfvars inside kube_terraform/ToDo-App/backend.tf and add the below conntent into that file.

```
REGION          = "us-east-1"
PROJECT_NAME    = "Circleci-EKS-Deploy"
VPC_CIDR        = "10.0.0.0/16"
PUB_SUB1_CIDR   = "10.0.1.0/24"
PUB_SUB2_CIDR   = "10.0.2.0/24"
PRI_SUB3_CIDR   = "10.0.3.0/24"
PRI_SUB4_CIDR   = "10.0.4.0/24"
```

Please note that the above file is crucial for setting up the infrastructure, so pay close attention to the values you enter for each variable.

<!-- The below command will tell you what terraform is going to create.

`terraform plan`

Finally, HIT the below command to create the infrastructure...

`terraform apply`

type yes, and it will prompt you for permission or use --auto-approve in the command above. -->

5️⃣Configure AWS:

```
  aws configure
```

6️⃣Set up an alias for Terraform:

To avoid typing terraform repeatedly, set up an alias for it. Run the following command:
```
  alias tf=terraform
```
It's time to build the infrastructure
```
  cd ToDo-App
```
```
  tf init
  tf plan
  tf apply --auto-approve
```

8️⃣ Log in to your EKS Cluster:

After provisioning your EKS cluster, use the following command to configure your kubectl to connect to it:

```
aws eks update-kubeconfig --region us-east-1 --name Circleci-EKS-Deploy
```

**This project contains Three GitHub repositories**

➡️ [App Code] (https://github.com/Sachin20010517/circleci-eks-deploy-AppCode)

➡️ [Terraform code] (https://github.com/Sachin20010517/circleci-eks-deploy-Terraform_Code)

➡️ [Manifest Repo] (https://github.com/Sachin20010517/circleci-eks-deploy-Kube_manifest)
