# AWS VPC with public EC2 instance

This project will build the VPC with 9 subnets and EC2 in public subnet

## Dependencies

```
- terraform v0.12+

## Commands
```
- terraform init
- terraform fmt --recursive
- terraform validate
- terraform plan
- terraform apply -var-file=devops-vpc.tfvars -auto-approve
- terraform destroy -var-file=devops-vpc.tfvars -auto-approve
```

## Step to deploy the code

```
- Please make sure terraform is installed (terraform version)
- Make sure you have the connectivity to the AWS (aws sts get-caller-identity)
- validate variables in .tfvars file
- run the terraform commands

```