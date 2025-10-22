# Detailed Deployment Guide

## Pre-Deployment Checklist

- [ ] AWS account created and verified
- [ ] AWS CLI installed and configured
- [ ] Terraform installed (version >= 1.0)
- [ ] SSH key pair generated
- [ ] Git repository cloned locally

## Step-by-Step Deployment

### Phase 1: Preparation (5 minutes)

1. **Verify Terraform installation:**
```bash
   terraform version
```

2. **Verify AWS credentials:**
```bash
   aws sts get-caller-identity
```

3. **Check SSH key:**
```bash
   ls -la ~/.ssh/id_rsa.pub
```

### Phase 2: Configuration Review (3 minutes)

1. **Review variables:**
```bash
   cat terraform/variables.tf
```

2. **Customize if needed:**
   Edit `terraform/variables.tf` to change defaults.

### Phase 3: Terraform Initialization (2 minutes)
```bash
cd terraform
terraform init
```

Expected output:
```
Terraform has been successfully initialized!
```

### Phase 4: Planning (3 minutes)
```bash
terraform plan
```

Review the plan output carefully. You should see:
- Plan: 4 to add, 0 to change, 0 to destroy

### Phase 5: Deployment (5-7 minutes)
```bash
terraform apply
```

1. Review the plan again
2. Type `yes` to confirm
3. Wait for resources to be created

### Phase 6: Verification (2 minutes)

1. **Get outputs:**
```bash
   terraform output
```

2. **Test websites:**
   - Copy each URL from output
   - Open in browser
   - Verify website loads

3. **Test SSH access:**
```bash
   ssh -i ~/.ssh/id_rsa ec2-user@<PUBLIC_IP>
```

## Post-Deployment Tasks

### Monitor Resources
```bash
# Check instance status
aws ec2 describe-instances --filters "Name=tag:Project,Values=terraform-website"

# View CloudWatch metrics (optional)
aws cloudwatch get-metric-statistics --namespace AWS/EC2 --metric-name CPUUtilization
```

### Update Website Content

1. SSH into instance:
```bash
   ssh -i ~/.ssh/id_rsa ec2-user@<PUBLIC_IP>
```

2. Edit website:
```bash
   sudo nano /var/www/html/index.html
```

3. Verify changes in browser

## Troubleshooting Deployment Issues

### Issue: Terraform Init Fails

**Solution:**
```bash
rm -rf .terraform
terraform init
```

### Issue: AWS Credentials Error

**Solution:**
```bash
aws configure
# Re-enter credentials
```

### Issue: SSH Key Not Found

**Solution:**
```bash
# Generate new key
ssh-keygen -t rsa -b 4096

# Update Terraform
terraform plan
terraform apply
```

### Issue: Port 80 Not Accessible

**Solution:**
1. Check security group rules
2. Verify Apache is running:
```bash
   ssh -i ~/.ssh/id_rsa ec2-user@<IP>
   sudo systemctl status httpd
```

### Issue: Insufficient Capacity

**Solution:**
- Change region in `variables.tf`
- Or change instance type

## Deployment Timeline

| Phase | Duration | Activity |
|-------|----------|----------|
| Prep | 5 min | Install tools, configure credentials |
| Review | 3 min | Check configuration files |
| Init | 2 min | Initialize Terraform |
| Plan | 3 min | Review execution plan |
| Deploy | 7 min | Create AWS resources |
| Verify | 2 min | Test websites and access |
| **Total** | **~22 min** | Complete deployment |

## Rollback Procedure

If deployment fails or you need to start over:
```bash
terraform destroy
# Type 'yes' to confirm

# Fix issues, then redeploy
terraform apply
```

## Next Steps After Deployment

1. Set up monitoring and alerts
2. Configure backups
3. Implement CI/CD pipeline
4. Add load balancer
5. Set up custom domain
6. Enable HTTPS with SSL/TLS

