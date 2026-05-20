terraform {
  required_version = ">= 1.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.60"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

# Admin Access Group - Full access to everything
resource "ibm_iam_access_group" "admin" {
  name        = var.admin_group_name
  description = "Access group for administrators with full access to all IBM Cloud resources"
}

# Admin Policy - All Identity and Access enabled services
resource "ibm_iam_access_group_policy" "admin_all_services" {
  access_group_id = ibm_iam_access_group.admin.id
  roles           = ["Administrator", "Manager"]
}

# Admin Policy - Account Management
resource "ibm_iam_access_group_policy" "admin_account_management" {
  access_group_id = ibm_iam_access_group.admin.id
  roles           = ["Administrator"]

  account_management = true
}

# Admin Policy - IAM Identity Service
resource "ibm_iam_access_group_policy" "admin_iam_identity" {
  access_group_id = ibm_iam_access_group.admin.id
  roles           = ["Administrator", "User API key creator", "Service ID creator"]

  resources {
    service = "iam-identity"
  }
}

# Admin Policy - Compliance
resource "ibm_iam_access_group_policy" "admin_compliance" {
  access_group_id = ibm_iam_access_group.admin.id
  roles           = ["Administrator", "Editor"]

  resources {
    service = "compliance"
  }
}

# Admin Policy - Support Center
resource "ibm_iam_access_group_policy" "admin_support" {
  access_group_id = ibm_iam_access_group.admin.id
  roles           = ["Editor"]

  resources {
    service = "support"
  }
}

# Admin Policy - VPC Infrastructure Services (All roles)
resource "ibm_iam_access_group_policy" "admin_vpc" {
  access_group_id = ibm_iam_access_group.admin.id
  roles = [
    "Administrator",
    "Editor",
    "Operator",
    "Viewer",
    "Manager",
    "Writer",
    "Reader",
    "Key Manager",
    "Service Configuration Reader",
    "Console Administrator",
    "IP Spoofing Operator",
    "VPN Client"
  ]

  resources {
    service = "is"
  }
}

# Admin Policy - Resource Groups (Viewer and Editor)
resource "ibm_iam_access_group_policy" "admin_resource_groups" {
  access_group_id = ibm_iam_access_group.admin.id
  roles           = ["Viewer", "Editor"]

  resources {
    resource_type = "resource-group"
  }
}

# System Administrators Access Group - Access to everything except IAM and Account
resource "ibm_iam_access_group" "sysadmin" {
  name        = var.sysadmin_group_name
  description = "Access group for system administrators with access to all resources except IAM and Account management"
}

# System Admin Policy - Editor access to all services
resource "ibm_iam_access_group_policy" "sysadmin_resources" {
  access_group_id = ibm_iam_access_group.sysadmin.id
  roles           = ["Editor", "Operator"]
}

# System Admin Policy - VPC Infrastructure Services
resource "ibm_iam_access_group_policy" "sysadmin_platform_services" {
  access_group_id = ibm_iam_access_group.sysadmin.id
  roles           = ["Editor", "Operator", "Viewer"]

  resources {
    service = "is"  # VPC Infrastructure Services
  }
}

resource "ibm_iam_access_group_policy" "sysadmin_kubernetes" {
  access_group_id = ibm_iam_access_group.sysadmin.id
  roles           = ["Administrator", "Manager"]

  resources {
    service = "containers-kubernetes"
  }
}

resource "ibm_iam_access_group_policy" "sysadmin_cloud_object_storage" {
  access_group_id = ibm_iam_access_group.sysadmin.id
  roles           = ["Manager", "Writer", "Reader"]

  resources {
    service = "cloud-object-storage"
  }
}

resource "ibm_iam_access_group_policy" "sysadmin_power_vs" {
  access_group_id = ibm_iam_access_group.sysadmin.id
  roles           = ["Administrator", "Manager", "Editor", "Operator"]

  resources {
    service = "power-iaas"  # Power Virtual Server
  }
}

# Removed - databases-for-* is not a valid service name
# Users should add specific database service policies as needed

# Operators Access Group - Read and operate deployed resources
resource "ibm_iam_access_group" "operators" {
  name        = var.operators_group_name
  description = "Access group for operators with read and operate access to deployed resources"
}

# Operators Policy - Viewer access to all services
resource "ibm_iam_access_group_policy" "operators_resources" {
  access_group_id = ibm_iam_access_group.operators.id
  roles           = ["Viewer"]
}

# Operators Policy - Viewer access to VPC
resource "ibm_iam_access_group_policy" "operators_vpc" {
  access_group_id = ibm_iam_access_group.operators.id
  roles           = ["Viewer", "Operator"]

  resources {
    service = "is"
  }
}

# Operators Policy - Viewer access to Kubernetes
resource "ibm_iam_access_group_policy" "operators_kubernetes" {
  access_group_id = ibm_iam_access_group.operators.id
  roles           = ["Viewer", "Operator"]

  resources {
    service = "containers-kubernetes"
  }
}

# Operators Policy - Reader access to Cloud Object Storage
resource "ibm_iam_access_group_policy" "operators_cos" {
  access_group_id = ibm_iam_access_group.operators.id
  roles           = ["Reader", "Viewer"]

  resources {
    service = "cloud-object-storage"
  }
}


# Operators Policy - Viewer access to Power Virtual Server
resource "ibm_iam_access_group_policy" "operators_power_vs" {
  access_group_id = ibm_iam_access_group.operators.id
  roles           = ["Viewer"]

  resources {
    service = "power-iaas"
  }
}

# Removed - databases-for-* is not a valid service name
# Users should add specific database service policies as needed
