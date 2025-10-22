# Architecture Overview

## Infrastructure Components

### Network Layer
- **VPC**: Default VPC
- **Security Group**: Custom security group allowing HTTP (80) and SSH (22)
- **IP Addressing**: Public IPs auto-assigned

### Compute Layer
- **EC2 Instances**: 2x t2.micro instances
- **AMI**: Amazon Linux 2023 (latest)
- **Web Server**: Apache HTTP Server (httpd)

### Access Layer
- **SSH Key Pair**: RSA 4096-bit key for secure access
- **HTTP Access**: Public internet access on port 80

## Data Flow
```
Internet User
     │
     ▼
  Port 80 (HTTP)
     │
     ▼
Security Group
     │
     ├─────────────┬─────────────┐
     ▼             ▼             ▼
  EC2 #1        EC2 #2
  (Apache)      (Apache)
```

## Security Considerations

- SSH access limited to port 22
- HTTP access on port 80 (public)
- Security group acts as virtual firewall
- Key-based authentication for SSH

## Cost Estimate

- 2x t2.micro instances: ~$0.0116/hour each
- Data transfer: Minimal for basic website
- **Total**: ~$17/month (if running 24/7)

**Free Tier**: First 750 hours/month free for 12 months

## Scalability

Current setup supports:
- Easy horizontal scaling (add more instances)
- Load balancer integration ready
- Auto-scaling group compatible
