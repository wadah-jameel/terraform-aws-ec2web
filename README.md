# Terraform AWS Website Deployment

Deploy a basic website on two AWS EC2 instances using Terraform and Infrastructure as Code principles.

## 🚀 Project Overview

This project demonstrates how to:
- Use Terraform to provision AWS infrastructure
- Deploy a web server on multiple EC2 instances
- Automate infrastructure deployment
- Document infrastructure as code

## 📋 Prerequisites

- AWS Account
- Terraform installed (>= 1.0)
- AWS CLI configured
- SSH key pair generated

## 🏗️ Architecture
```
┌─────────────────────────────────────┐
│         AWS Cloud (us-east-1)       │
│                                     │
│  ┌──────────────────────────────┐  │
│  │    Security Group            │  │
│  │  - HTTP (80)                 │  │
│  │  - SSH (22)                  │  │
│  └──────────────────────────────┘  │
│                                     │
│  ┌─────────────┐  ┌─────────────┐  │
│  │  EC2 #1     │  │  EC2 #2     │  │
│  │  t2.micro   │  │  t2.micro   │  │
│  │  Apache     │  │  Apache     │  │
│  └─────────────┘  └─────────────┘  │
└─────────────────────────────────────┘
```

## 📁 Project Structure
```
terraform-aws-website/
├── README.md                 # This file
├── website/
│   └── index.html           # Website content
└── terraform/
    ├── main.tf              # Main Terraform config
    ├── variables.tf         # Input variables
    ├── outputs.tf           # Output values
    └── providers.tf         # Provider configuration
```

## 🛠️ Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/terraform-aws-website.git
cd terraform-aws-website
```

### 2. Configure AWS Credentials
```bash
aws configure
```

Enter your AWS Access Key ID, Secret Access Key, and preferred region.

### 3. Generate SSH Key (if needed)
```bash
ssh-keygen -t rsa -b 4096 -C "your.email@example.com"
```

### 4. Initialize Terraform
```bash
cd terraform
terraform init
```

### 5. Review the Plan
```bash
terraform plan
```

### 6. Deploy Infrastructure
```bash
terraform apply
```

Type `yes` when prompted.

### 7. Access Your Websites

After deployment completes, Terraform will output the website URLs:
```
website_urls = [
  "http://54.123.45.67",
  "http://54.123.45.68"
]
```

Open these URLs in your browser!

## 📊 Resources Created

- **2x EC2 Instances** - t2.micro (Free Tier eligible)
- **1x Security Group** - Allows HTTP (80) and SSH (22)
- **1x SSH Key Pair** - For instance access

## 🔧 Customization

### Change Instance Count

Edit `terraform/variables.tf`:
```hcl
variable "instance_count" {
  default = 3  # Change to desired number
}
```

### Change AWS Region

Edit `terraform/variables.tf`:
```hcl
variable "aws_region" {
  default = "us-west-2"  # Change to desired region
}
```

### Change Instance Type

Edit `terraform/variables.tf`:
```hcl
variable "instance_type" {
  default = "t3.micro"  # Change to desired type
}
```

## 🧹 Cleanup

To destroy all resources and avoid AWS charges:
```bash
cd terraform
terraform destroy
```

Type `yes` when prompted.

## 📝 Common Commands
```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Show outputs
terraform output

# Destroy infrastructure
terraform destroy

# Format code
terraform fmt

# Show current state
terraform show
```

## 🐛 Troubleshooting

### SSH Key Error
If you get an error about the SSH key:
```bash
ssh-keygen -t rsa -b 4096
```

### AWS Credentials Error
Reconfigure AWS CLI:
```bash
aws configure
```

### Security Group Issues
Ensure your security group allows inbound traffic on port 80.

## 📚 Learn More

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## 📄 License

MIT License - feel free to use this project for learning!

## 👤 Author

Wadah Ahmed - [Wadah Github](https://github.com/wadah-jameel)

## 🙏 Acknowledgments

- HashiCorp for Terraform
- AWS for cloud infrastructure
- The DevOps community for inspiration

---

**Note:** Remember to destroy resources when done to avoid AWS charges!
```bash
terraform destroy
```
