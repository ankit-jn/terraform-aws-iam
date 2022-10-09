# ARJ-Stack: AWS IAM Terraform module

A Terraform module for configuring IAM (Organization, Groups, Users, Polcies etc.) in AWS.

---
## Resources
This module features the following components to be provisioned with different combinations:

- AWS Organization [[aws_organizations_organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organization)]
- AWS Organization Unit [[aws_organizations_organizational_unit](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit)]
- AWS Organization Policy [[aws_organizations_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy)]
- AWS Organization Member Account [[aws_organizations_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account)]
- Account Password Management Policy [[aws_iam_account_password_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy)]
- IAM Policy [[aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)]
    - MFA Enforcement Policy
    - Policies to allow different permissions
    - Policies to allow assuming the Cross Account roles
- IAM Role [[aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)]
- IAM Group [[aws_iam_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group)]
- IAM user [[aws_iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user)]
- IAM User: Login profile [[aws_iam_user_login_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile)]
- IAM User: Access key [[aws_iam_access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key)]
- IAM User: SSH Key [[aws_iam_user_ssh_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_ssh_key)]
- Associate IAM users to IAM Groups [[aws_iam_user_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership)]
- Attachment of IAM Policy to IAM Group [[aws_iam_group_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)]
- Attachment of IAM Policy with IAM role [[aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)]


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22.0 |

## Examples

Refer [Configuration Examples](https://github.com/arjstack/terraform-aws-examples/tree/main/aws-iam) for effectively utilizing this module.

## Inputs

#### Organization Specific Properties
---

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|

## Outputs
| Name | Type | Description |
|:------|:------|:------|

## Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-iam/graphs/contributors).
