# Call local_env_setup.sh to export necessary environment variables
source "/mnt/c/Users/harit/Documents/Visual Studio 2022/DevOps/DevOps-Terraform-Sample/helper/scripts/0_local_env_setup.sh"

# Directory to run Terraform commands
TF_INFRA_DIR="/mnt/c/Users/harit/Documents/Visual Studio 2022/DevOps/DevOps-Terraform-Sample/azure-platform/deployment"

# Set the environment variable to dev
# export TF_VAR_environment="dev"

# Change to the directory where Terraform files are located
cd "$TF_INFRA_DIR" || { echo "Directory $TF_INFRA_DIR not found"; exit 1; }

# Apply with the specified environment variable and auto-approve, saving output to a file
echo "Applying Terraform configuration for environment: $TF_VAR_environment"
if ! terraform destroy -var-file="./$TF_VAR_environment.tfvars" -auto-approve -lock=false; then
  echo "Terraform apply failed!"
  exit 1
fi

TF_APP_DIR="/mnt/c/Users/harit/Documents/Visual Studio 2022/DevOps/DevOps-Terraform-Sample/data-upload-app/deployment"

# Change to the directory where Terraform files are located
cd "$TF_APP_DIR" || { echo "Directory $TF_APP_DIR not found"; exit 1; }

# Apply with the specified environment variable and auto-approve, saving output to a file
echo "Applying Terraform configuration for environment: $TF_VAR_environment"
if ! terraform destroy -var-file="./$TF_VAR_environment.tfvars" -auto-approve -lock=false; then
  echo "Terraform apply failed!"
  exit 1
fi

../../helper/scripts/delete_all_rg_except.sh 