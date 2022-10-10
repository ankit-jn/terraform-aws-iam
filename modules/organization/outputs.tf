output "organization" {
    description = "Organization Attributes"
    value = {
                id = aws_organizations_organization.this.id
                arn = aws_organizations_organization.this.arn
                master_account_id = aws_organizations_organization.this.master_account_id
                master_account_arn = aws_organizations_organization.this.master_account_arn
                master_account_email = aws_organizations_organization.this.master_account_email
                accounts = aws_organizations_organization.this.accounts
                non_master_accounts = aws_organizations_organization.this.non_master_accounts
            }
}

output "organizations_accounts" {
    description = <<EOF
Map of all the Organization accounts that are created as a member of the organization 
where each entry of the map is again a map of the Account attributes"
EOF
    value = { for account_name, account in aws_organizations_account.this :
                account_name => {
                    id  = account.id
                    arn = account.arn
                }
            }
}

output "organizations_units" {
    description = <<EOF
Map of all the Organization Units that are created 
where each entry of the map is again a map of the OU attributes"
EOF
    value = merge(
                { for ou_name, ou in aws_organizations_organizational_unit.level_1 :
                    ou_name => {
                        id  = ou.id
                        arn = ou.arn
                    }
                },
                { for ou_name, ou in aws_organizations_organizational_unit.level_2 :
                    ou_name => {
                        id  = ou.id
                        arn = ou.arn
                    }
                },
                { for ou_name, ou in aws_organizations_organizational_unit.level_3 :
                    ou_name => {
                        id  = ou.id
                        arn = ou.arn
                    }
                },
                { for ou_name, ou in aws_organizations_organizational_unit.level_4 :
                    ou_name => {
                        id  = ou.id
                        arn = ou.arn
                    }
                },
                { for ou_name, ou in aws_organizations_organizational_unit.level_5 :
                    ou_name => {
                        id  = ou.id
                        arn = ou.arn
                    }
                })

}