variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key for authentication"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "IBM Cloud region where resources will be created"
  type        = string
  default     = "eu-de"
}

variable "admin_group_name" {
  description = "Name for the administrators access group with full access"
  type        = string
  default     = "Administrators"
}

variable "sysadmin_group_name" {
  description = "Name for the system administrators access group (no IAM/Account access)"
  type        = string
  default     = "System-Administrators"
}

variable "operators_group_name" {
  description = "Name for the operators access group with read-only access"
  type        = string
  default     = "Operators"
}
