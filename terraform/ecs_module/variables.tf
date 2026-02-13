# defining inputs

variable "cluster_name"     { type = string }
variable "container_name"   { type = string }
variable "container_image"  { type = string }
variable "service_name"     { type = string }
variable "memory"           { type = string }
variable "cpu"              { type = string }
variable "desired_count"    { type = string }
variable "task_family"      { type = string }
variable "subnets"          { type = list(string) }
variable "security_groups"  { type = list(string) }
variable "app_env"          {
     default = "dev"
     type = string
}