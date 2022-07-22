# AWS Config

setup necessary aws resources, mainly users, roles & attach policies

the tfstate is stored in aws backend, see the backend directory for details.

## TF version

current is `1.2.5`, use `niv` to fix the version?

## Memo

The tf state is stored in s3 and state lock in dynamodb, as described in `/backend` directory.

To modify the aws config, modify the badly named `/stack` directory

## `IAM` config as following

| IAM users | Groups |
| --------- | ------ |
| alban     | admin  |

## Howto change the backend

- Create the new backend
- Point any config relying on the backend to the new backend
- Delete the old backend

## TODOs

- [ ] Migrate to later tf version
- [ ] User module to handle state config ? https://registry.terraform.io/modules/trussworks/bootstrap/aws/latest
