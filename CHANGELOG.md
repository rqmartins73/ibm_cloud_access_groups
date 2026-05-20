# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.4] - 2026-05-20

### Added
- Power Virtual Server (power-iaas) Viewer access for Operators

## [1.0.3] - 2026-05-20

### Added
- Power Virtual Server (power-iaas) access for System Administrators with Administrator, Manager, Editor, and Operator roles

## [1.0.2] - 2026-05-20

### Added
- Comprehensive Administrator access group policies matching IBM Cloud best practices:
  - IAM Identity Service with Administrator, User API key creator, and Service ID creator roles
  - Compliance service with Administrator and Editor roles
  - Support Center with Editor role
  - VPC Infrastructure Services with all available roles (Administrator, Editor, Operator, Viewer, Manager, Writer, Reader, Key Manager, Service Configuration Reader, Console Administrator, IP Spoofing Operator, VPN Client)
  - Resource Groups with Viewer and Editor roles

### Changed
- Enhanced Admin access group with granular service-specific policies
- Admin now has explicit policies for IAM Identity, Compliance, Support, VPC, and Resource Groups
- Improved policy structure for better access control and auditing

## [1.0.1] - 2026-05-20

### Fixed
- Fixed "Wildcard is not allowed for this CRN attribute: resource" error by removing wildcard from resource attribute in policies
- Fixed "RoleDoesnotExist: Manager was not found" error by removing Manager role from resource group policies
- Fixed "Service name databases-for-* is not an IAM registered service" error by removing generic database wildcard policies
- Admin policy now applies Administrator and Manager roles at account level without resource group wildcards
- System Admin policy now uses Editor and Operator roles instead of Manager for resource groups
- Operators policy now uses Viewer role at account level

### Changed
- Admin access group now has account-level Administrator and Manager roles
- System Admin access group now has Editor and Operator roles for general access
- Operators access group now has Viewer role for general access
- Removed generic database policies (databases-for-*) - users should add specific database service policies as needed

### Documentation
- Updated README.md with known limitations section
- Added instructions for adding specific database service policies
- Added troubleshooting section for common errors
- Updated documentation to reflect policy changes

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

[1.0.4]: https://github.com/rqmartins/ibm_cloud_access_groups/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/rqmartins/ibm_cloud_access_groups/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/rqmartins/ibm_cloud_access_groups/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/rqmartins/ibm_cloud_access_groups/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/rqmartins/ibm_cloud_access_groups/releases/tag/v1.0.0
