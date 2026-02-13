#Cluster creation
resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
}

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "ecs_log_group" {
   name = "ecs/${var.container_name}"
   retention_in_days = 7
}

/*Task definition https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition
Placing the cpu and memory variables within the task level rather than container definition
*/
resource "aws_ecs_task_definition" "app" {
  requires_compatibilities = ["FARGATE"]
  family                   = var.task_family
  cpu                      = var.cpu
  memory                   = var.memory
  
  container_definitions = jsonencode([
    {
      name                 = var.container_name
      image                = var.container_image
      essential            = true
      
      environment = [
        {
          name  = "APP_ENV"
          value = var.app_env
        }
      ]
    }
  ])
}

/*Service for scheduling and running the task
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service */
resource "aws_ecs_service" "this" {
  name = var.service_name
  cluster = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count = var.desired_count
  launch_type = "FARGATE"

  /*network_configuration is generally optional but here it's mandatory
  as we are using awsvpc is in use */
  network_configuration {
    assign_public_ip = true
    subnets = var.subnets
    security_groups = var.security_groups
  }
}