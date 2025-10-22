# Contributing to Terraform AWS Website

Thank you for your interest in contributing! Here's how you can help improve this project.

## How to Contribute

### Reporting Bugs

If you find a bug:
1. Check if it's already reported in [Issues](../../issues)
2. If not, create a new issue with:
   - Clear title
   - Steps to reproduce
   - Expected vs actual behavior
   - Terraform and AWS CLI versions

### Suggesting Enhancements

Have an idea? Open an issue with:
- Clear description of the enhancement
- Use cases
- Implementation suggestions (optional)

### Pull Requests

1. Fork the repository
2. Create a feature branch:
```bash
   git checkout -b feature/your-feature-name
```

3. Make your changes
4. Test your changes:
```bash
   terraform fmt
   terraform validate
   terraform plan
```

5. Commit with clear message:
```bash
   git commit -m "Add feature: description"
```

6. Push to your fork:
```bash
   git push origin feature/your-feature-name
```

7. Open a Pull Request

## Code Standards

- Use Terraform formatting: `terraform fmt`
- Add comments for complex logic
- Update documentation for new features
- Follow existing code style

## Testing

Before submitting:
```bash
# Format code
terraform fmt -recursive

# Validate syntax
terraform validate

# Check plan
terraform plan
```

## Questions?

Feel free to open an issue for any questions!
