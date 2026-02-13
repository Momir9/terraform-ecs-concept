module "ecs_deployment" {
  source          = "./ecs_module"
  
  subnets         = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  security_groups = [aws_security_group.ecs_sg.id]

  #Configurable values
  cluster_name    = var.root_cluster_name
  service_name    = var.root_service_name
  desired_count   = var.root_desired_count
  
  #Task config
  container_name  = "test-server"
  container_image = "nginx:latest"
  cpu             = "256"
  memory          = "512"
  app_env         = "dev"
  task_family     = "test-family"
}