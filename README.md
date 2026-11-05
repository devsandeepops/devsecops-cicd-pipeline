# DevSecOps CI/CD Pipeline

A GitHub Actions example that checks Terraform configuration on pushes and pull requests. The workflow runs formatting, initialization, validation, and Trivy configuration scanning. It does not authenticate to Azure, deploy resources, or publish artifacts.

## Checks

- `terraform fmt -check -recursive`
- `terraform init -backend=false`
- `terraform validate`
- Trivy configuration scanning for high and critical findings

## Run locally

From the repository root, with Terraform and Trivy installed:

```sh
terraform -chdir=terraform fmt -check -recursive
terraform -chdir=terraform init -backend=false
terraform -chdir=terraform validate
trivy config --severity HIGH,CRITICAL --exit-code 1 terraform
```

The Terraform files are a small Azure network example used as scan input; the workflow only validates and scans them. Review action versions and scanning policy before adopting this workflow in a production repository.