# IBM Cloud Access Groups - Terraform

This Terraform project creates three Access Groups in IBM Cloud with different permission levels:

## Created Access Groups

### 1. Administrators (Admin)
- **Access**: Full access to all IBM Cloud resources and services
- **Permissions**: 
  - Administrator and Manager roles on all services
  - Complete Account Management (including IAM)
- **Use Case**: For administrators with full account control

### 2. System Administrators (SysAdmin)
- **Access**: All resources except IAM and Account Management
- **Permissions**:
  - Editor and Operator on all services
  - Editor/Operator/Viewer on VPC Infrastructure Services
  - Administrator/Manager on Kubernetes/OpenShift
  - Manager/Writer/Reader on Cloud Object Storage
- **Use Case**: For system administrators who manage infrastructure but not users/permissions
- **Note**: Database service policies should be added manually for specific database services (e.g., databases-for-postgresql, databases-for-mongodb)

### 3. Operators
- **Access**: Read-only and operation access to deployed resources
- **Permissions**:
  - Viewer on all services
  - Viewer/Operator on VPC Infrastructure Services
  - Viewer/Operator on Kubernetes/OpenShift
  - Reader/Viewer on Cloud Object Storage
- **Use Case**: For operators who need to view and operate resources but not modify configurations
- **Note**: Database service policies should be added manually for specific database services

## Prerequisites

- Terraform >= 1.0
- IBM Cloud API Key with administrator permissions
- IBM Cloud CLI (optional, for verification)

## Configuration

### 1. Create terraform.tfvars file

Create a `terraform.tfvars` file with your settings:

```hcl
ibmcloud_api_key = "your-ibm-cloud-api-key"
region           = "eu-de"

# Optional: customize access group names
admin_group_name    = "Administrators"
sysadmin_group_name = "System-Administrators"
operators_group_name = "Operators"
```

**IMPORTANT**: Never commit the `terraform.tfvars` file with the API key!

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Validate configuration

```bash
terraform validate
```

### 4. View execution plan

```bash
terraform plan
```

### 5. Apply configuration

```bash
terraform apply
```

## Variables

| Variable | Description | Type | Default | Required |
|----------|-------------|------|---------|----------|
| `ibmcloud_api_key` | IBM Cloud API Key | string | - | Yes |
| `region` | IBM Cloud region | string | `eu-de` | No |
| `admin_group_name` | Admin group name | string | `Administrators` | No |
| `sysadmin_group_name` | SysAdmin group name | string | `System-Administrators` | No |
| `operators_group_name` | Operators group name | string | `Operators` | No |

## Outputs

After applying, Terraform returns:

- `admin_access_group_id` - Administrators access group ID
- `admin_access_group_name` - Administrators access group name
- `sysadmin_access_group_id` - System Administrators access group ID
- `sysadmin_access_group_name` - System Administrators access group name
- `operators_access_group_id` - Operators access group ID
- `operators_access_group_name` - Operators access group name

## Adding Users to Access Groups

After creating the access groups, you can add users through IBM Cloud Console or CLI:

### Via IBM Cloud Console
1. Go to **Manage > Access (IAM) > Access groups**
2. Select the desired access group
3. Click **Add users**
4. Select users and confirm

### Via IBM Cloud CLI
```bash
# Add user to Admin group
ibmcloud iam access-group-user-add Administrators user@example.com

# Add user to SysAdmin group
ibmcloud iam access-group-user-add System-Administrators user@example.com

# Add user to Operators group
ibmcloud iam access-group-user-add Operators user@example.com
```

## Adding Database Service Policies

To add policies for specific database services, you can extend the configuration:

```hcl
# Example: Add PostgreSQL access for System Administrators
resource "ibm_iam_access_group_policy" "sysadmin_postgresql" {
  access_group_id = ibm_iam_access_group.sysadmin.id
  roles           = ["Administrator", "Manager"]

  resources {
    service = "databases-for-postgresql"
  }
}

# Example: Add MongoDB access for Operators
resource "ibm_iam_access_group_policy" "operators_mongodb" {
  access_group_id = ibm_iam_access_group.operators.id
  roles           = ["Viewer"]

  resources {
    service = "databases-for-mongodb"
  }
}
```

Valid database service names include:
- `databases-for-postgresql`
- `databases-for-mongodb`
- `databases-for-mysql`
- `databases-for-redis`
- `databases-for-elasticsearch`
- `databases-for-etcd`

## State Management

Terraform state is stored locally in `terraform.tfstate`. For production environments, consider using remote state:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "ibm-access-groups/terraform.tfstate"
    region = "eu-de"
  }
}
```

## Cleanup

To remove all created access groups:

```bash
terraform destroy
```

## Security

- **Never** commit files containing API keys
- Use environment variables for API keys in CI/CD:
  ```bash
  export TF_VAR_ibmcloud_api_key="your-api-key"
  ```
- Regularly review access group permissions
- Implement principle of least privilege

## Project Structure

```
.
├── main.tf           # Main resources (access groups and policies)
├── variables.tf      # Variable definitions
├── outputs.tf        # Terraform outputs
├── terraform.tfvars  # Variable values (do not commit!)
├── .gitignore        # Files to ignore in Git
└── README.md         # This documentation
```

## Known Limitations

1. **Resource Group Wildcards**: IBM Cloud IAM does not support wildcards (`*`) for the `resource` attribute in resource group policies. Policies are applied at the account level instead.

2. **Database Service Names**: Generic patterns like `databases-for-*` are not supported. You must specify exact service names (e.g., `databases-for-postgresql`).

3. **Manager Role**: The "Manager" role is not available for resource group policies. Valid roles are: Administrator, Operator, Editor, Viewer, Service Configuration Reader, Key Manager.

## Troubleshooting

### Error: "Insufficient permissions"
- Verify that the API key has Administrator permissions
- Confirm that the API key is active

### Error: "Access group already exists"
- Check if access groups with the same names already exist
- Change the names in variables or remove existing groups

### Error: "Invalid API key"
- Verify that the API key is correct
- Confirm there are no extra spaces or characters

### Error: "Wildcard is not allowed for this CRN attribute"
- This has been fixed in version 1.0.1
- Update to the latest version

## Support

For questions about IBM Cloud IAM:
- [IBM Cloud Docs - Access Groups](https://cloud.ibm.com/docs/account?topic=account-groups)
- [IBM Cloud Docs - IAM Roles](https://cloud.ibm.com/docs/account?topic=account-userroles)

## License

This project is provided as is, without warranties.
