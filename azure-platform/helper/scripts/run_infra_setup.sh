# Define common variables for logs and directories
LOG_DIR="/mnt/c/Users/harit/Documents/devops_test_logs"
BASE_DIR="/mnt/c/Users/harit/Documents/Visual Studio 2022/DevOps/DevOps-Terraform-Sample"
HELPER_DIR="$BASE_DIR/helper/scripts"
APP_PATH="$BASE_DIR/data-upload-app/src"
TF_INFRA_DIR="$BASE_DIR/azure-platform/deployment"

# Ensure log directory exists
mkdir -p $LOG_DIR

# Function to run a script with logging and a delay
run_with_logging() {
    local script_path="$1"
    local log_file="$2"
    
    echo "Running $script_path..."
    source "$script_path"

    # Log output separately
    date >> "$log_file"
    cat "$script_path" >> "$log_file"
    
    sleep 5
}

# Step 0: Set the local environments and check required environment variables
export ENV_DIR="$TF_INFRA_DIR"
run_with_logging "$HELPER_DIR/0_local_env_setup.sh" \
 "$LOG_DIR/infra_environments_output.log"

# Check necessary environment variables
if [ -z "$TF_VAR_environment" ] || [ -z "$TF_VAR_subscription_id" ]; then
    echo "Error: Required environment variables are not set."
    exit 1
fi

# Step 1: Run the Terraform script
export TF_DIR="$TF_INFRA_DIR"
run_with_logging "$HELPER_DIR/1_run_terraform.sh" \
 "$LOG_DIR/infra_terraform_output.log"

# # Step 2: Set the AKS cluster configuration
# run_with_logging "$HELPER_DIR/2_set_aks-cluster-config.sh" \
#  "$LOG_DIR/infra_aks_config_output.log"

# # Step 3: Deploy Docker image to ACR
# export APP_PATH="$APP_PATH"
# run_with_logging "$HELPER_DIR/3_deploy_image_acr.sh" \
#  "$LOG_DIR/infra_docker_acr_output.log"