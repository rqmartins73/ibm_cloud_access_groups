output "admin_access_group_id" {
  description = "ID of the Administrators access group"
  value       = ibm_iam_access_group.admin.id
}

output "admin_access_group_name" {
  description = "Name of the Administrators access group"
  value       = ibm_iam_access_group.admin.name
}

output "sysadmin_access_group_id" {
  description = "ID of the System Administrators access group"
  value       = ibm_iam_access_group.sysadmin.id
}

output "sysadmin_access_group_name" {
  description = "Name of the System Administrators access group"
  value       = ibm_iam_access_group.sysadmin.name
}

output "operators_access_group_id" {
  description = "ID of the Operators access group"
  value       = ibm_iam_access_group.operators.id
}

output "operators_access_group_name" {
  description = "Name of the Operators access group"
  value       = ibm_iam_access_group.operators.name
}
