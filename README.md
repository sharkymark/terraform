# Terraform examples

Various Terraform examples for different use cases.

## Installation

As of 2025-04-12, brew is no longer supported for installing Terraform due to HashiCorp changing its license type to [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE) or "BUSL". See the [FAQ](https://www.hashicorp.com/en/license-faq) Instead, you can download Terraform directly from the [official website](https://developer.hashicorp.com/terraform/install).

## Common Commands
```bash
# Download provider plugins into `.terraform` | creates `.terraform.lock.hcl` file
terraform init
# Previews the changes that will be made to your infrastructure
terraform plan
# Formats Terraform configuration files to a canonical style | creates `terraform.tfstate` file
terraform fmt
# Applies the planned changes to create or update infrastructure
terraform apply
# Displays the current state or plan in a human-readable format
terraform show
# Lists all resources tracked in the current Terraform state
terraform state list
# Destroys all infrastructure managed by your Terraform project
terraform destroy
```

## Key files
- `main.tf`: The main configuration file where resources are defined. Any basename can be used, but `main.tf` is conventional and the Terraform CLI will load any files with the `.tf` extension in the current directory.
- `variables.tf`: Defines input variables for the Terraform configuration.
- `outputs.tf`: Specifies output values that can be used after the infrastructure is created.
- `terraform.tfvars`: Contains values for the variables defined in `variables.tf`.
- `.terraform.lock.hcl`: Locks the provider versions used in the configuration.
- `.terraform/`: Directory containing provider plugins and other Terraform state files.
- `terraform.tfstate`: The current state of the infrastructure managed by Terraform.
- `terraform.tfstate.backup`: A backup of the previous state file, used for recovery in case of issues.