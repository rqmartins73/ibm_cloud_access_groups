#!/bin/bash
# Sync Terraform files from Git repository to working folder
# Usage: ./sync_to_working.sh

GIT_REPO="$HOME/Git/ibm_cloud_access_groups"
WORKING_DIR="$HOME/Terraform/BCCE/ibm_cloud_access_groups"

echo "Syncing from Git repository..."
echo "Git repo: $GIT_REPO"
echo "Working dir: $WORKING_DIR"
echo ""

# Navigate to Git repo and pull latest changes
cd "$GIT_REPO" || exit 1
echo "Pulling latest changes from GitHub..."
git pull

# Copy Terraform files to working directory
echo ""
echo "Copying files to working directory..."
cp -v main.tf variables.tf outputs.tf README.md terraform.tfvars.example "$WORKING_DIR/"

echo ""
echo "✅ Sync complete! Files updated in working directory."
echo ""
echo "Next steps:"
echo "  cd $WORKING_DIR"
echo "  terraform plan"
echo "  terraform apply"
