# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-05-20

### Added
- Initial release of IBM Cloud Access Groups Terraform configuration
- Three access groups with different permission levels:
  - Administrators: Full access to all IBM Cloud resources and Account Management
  - System-Administrators: Access to all resources except IAM and Account Management
  - Operators: Read-only and operation access to deployed resources
- Comprehensive policies for VPC, Kubernetes, Cloud Object Storage, and Databases
- Complete documentation in English (README.md)
- Configuration variables for customization
- Output values for access group IDs and names
- Example configuration file (terraform.tfvars.example)
- Git ignore file for Terraform sensitive files

[1.0.0]: https://github.com/rqmartins/ibm_cloud_access_groups/releases/tag/v1.0.0
