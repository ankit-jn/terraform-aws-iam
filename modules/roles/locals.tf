locals {
    trusted_account_roles_policies_attachments = {
        for attachment in aws_iam_role_policy_attachment.trusted_account_role_policy_attachment:
            attachment.role => attachment.policy_arn...
        }

    service_linked_roles_policies_attachments = {
        for attachment in aws_iam_role_policy_attachment.service_linked_role_policy_attachment:
            attachment.role => attachment.policy_arn...
        }
}