# Data source to get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Create a security group
resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-sg"
  description = "Security group for web servers"

  # Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP"
  }

  # Allow SSH from anywhere (restrict this in production!)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name    = "${var.project_name}-sg"
    Project = var.project_name
  }
}

# Create SSH key pair
resource "aws_key_pair" "web_key" {
  key_name   = "${var.project_name}-key"
  public_key = file("~/.ssh/id_rsa.pub")

  tags = {
    Name    = "${var.project_name}-key"
    Project = var.project_name
  }
}

# User data script to install Apache and deploy website
locals {
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install httpd -y
              systemctl start httpd
              systemctl enable httpd
              
              # Create a simple website
              cat > /var/www/html/index.html << 'HTML'
              <!DOCTYPE html>
              <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>Terraform Deployed Website</title>
                  <style>
                      body {
                          font-family: Arial, sans-serif;
                          max-width: 800px;
                          margin: 50px auto;
                          padding: 20px;
                          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                          color: white;
                      }
                      .container {
                          background: rgba(255, 255, 255, 0.1);
                          padding: 30px;
                          border-radius: 10px;
                          backdrop-filter: blur(10px);
                      }
                      h1 { margin-top: 0; }
                      .server-info {
                          background: rgba(0, 0, 0, 0.2);
                          padding: 15px;
                          border-radius: 5px;
                          margin-top: 20px;
                      }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>🚀 Welcome to My Terraform-Deployed Website!</h1>
                      <p>This website is running on AWS EC2, deployed using Terraform.</p>
                      <p><strong>Infrastructure as Code FTW!</strong></p>
                      <div class="server-info">
                          <p><strong>Server:</strong> $(hostname)</p>
                          <p><strong>Deployed:</strong> $(date)</p>
                      </div>
                  </div>
              </body>
              </html>
              HTML
              
              chmod 644 /var/www/html/index.html
              EOF
}

# Create EC2 instances
resource "aws_instance" "web" {
  count                  = var.instance_count
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.web_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data              = local.user_data

  tags = {
    Name    = "${var.project_name}-${count.index + 1}"
    Project = var.project_name
    Server  = "web-${count.index + 1}"
  }

  # Ensure the instance is fully ready
  user_data_replace_on_change = true
}
