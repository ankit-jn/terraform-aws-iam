data aws_iam_policy_document "force_mfa_policy_document" {

    count = var.create_force_mfa_policy ? 1 : 0

    statement {
        sid = "MFA-AllowViewAccountInfo"
        effect = "Allow"
        actions = [
            "iam:ListVirtualMFADevices",
            "iam:GetAccountPasswordPolicy"
        ]
        resources = ["*"]
    }

    statement {
        sid = "MFA-AllowManageOwnVirtualMFADevice"
        effect = "Allow"
        actions = [
            "iam:CreateVirtualMFADevice",
            "iam:DeleteVirtualMFADevice"
        ]
        resources = ["arn:aws:iam::*:mfa/$${aws:username}"]
    }

    statement {
        sid = "MFA-AllowManageOwnUserMFA"
        effect = "Allow"
        actions = [
            "iam:DeactivateMFADevice",
            "iam:EnableMFADevice",
            "iam:GetUser",
            "iam:ListMFADevices",
            "iam:ResyncMFADevice"
        ]
        resources = [
            "arn:aws:iam::*:user/$${aws:username}"
        ]
    }

    statement {
        sid = "MFA-DenyAllExceptListedIfNoMFA"
        effect = "Deny"
        not_actions = [
            "iam:CreateVirtualMFADevice",
            "iam:EnableMFADevice",
            "iam:GetUser",
            "iam:ListMFADevices",
            "iam:ListVirtualMFADevices",
            "iam:ResyncMFADevice",
            "sts:GetSessionToken",
            "iam:ChangePassword"
        ]
        resources = ["*"]

        condition {
            test = "BoolIfExists"
            variable = "aws:MultiFactorAuthPresent"
            values = [
                "false"
            ]
        }
    }
}

resource aws_iam_policy "force_mfa_policy" {
    count = var.create_force_mfa_policy ? 1 : 0

    name          = "Policy-ForceMFA"
    path          = "/"
    description   = "This policy allows users to manage their own passwords and MFA devices but nothing else unless they authenticate with MFA."

    policy        = data.aws_iam_policy_document.force_mfa_policy_document[0].json

    tags          = var.policy_default_tags
}