output "organizations_accounts" {
    value = { for account_name, account in aws_organizations_account.this :
                account_name => {
                    id  = account.id
                    arn = account.arn
                }
            }
}

output "organizations_units" {
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