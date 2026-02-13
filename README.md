# ECS Fargate Infrastructure Concept - Terraform

## Description

This project is implementing serverless container architecture through AWS ECS Fargate.
It was designed with Terraform module reusability in mind, and is split into several components.

They are listed below in a logical order of how the process went:



**_terraform/provider.tf_** - Specified the TF and AWS version scopes, declared the required tag so that it applies to all resources in the project

**_../ecs_module/main.tf_** - Contains the ECS Cluster, Task Definition and Service

**_../ecs_module/variables.tf_** - Contains the necessary variable placeholders such as cluster_name, notably only the app_env has a default value as requested which is configurable

**_../ecs_module/iam.tf_** - Defines the Execution Role for tasks like image pull, logging

_**../ecs_module/outputs.tf**_ - Cluster name and Service name outputs

_**terraform/network.tf**_ - VPC, two subnets for high availability, ingress/egress and a security group

_**terraform/variables.tf**_ - Defined 3 variables for /main.tf

_**terraform/main.tf**_ - Root module that calls upon the Child module from /ecs_module. It has 3 previously noted configurable values as proof of concept and 6 predefined values

Lastly, in the root module there is the _**terraform.tfvars**_ file with an example for _terraform plan_ phase


## How to use

1. Once the repository is cloned into your IDE, execute the _terraform init_ command in the root folder of the project
2. File /terraform/terraform.tfvars contains specific enfironment values for deployment


## Problems encountered when trying _terraform plan_

- Resource _aws_cloudwatch_log_group_ has the retention_in_days attribute, for which I have specified 10 days not realizing that
  the expected values are 1, 3, 7, 14 and further. This is because I was mistakenly looking at the data-sources doc instead of the resource doc

- Mock provider configuration - I copied it from the assignment PDF but forgot to add in a region, without which _terraform plan_ failed initially

## References for the building blocks, for readability they are also placed in code comments accordingly:

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AmazonECSTaskExecutionRolePolicy.html
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudwatch_log_group
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
