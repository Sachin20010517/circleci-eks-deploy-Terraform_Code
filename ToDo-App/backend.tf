terraform {
  backend "s3" {
    bucket = "circleci-eks-deploy-s3-bucket"
    key    = "backend/circleci-eks-deploy.tfstate"
    region = "us-east-1"
    dynamodb_table = "circleci-eks-deploy-dynamodb-table"
  }
}