variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "terraform-website"
}
