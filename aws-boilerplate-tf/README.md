# AWS Config

setup necessary aws resources, mainly users, roles & attach policies

the tfstate is stored in aws backend, see the backend directory for details.

## TF version

The tf version is 0.13, checkout the `shell.nix` file to get the specific version

## Memo

Check gists for the tfstate.backup file

The tf state is stored in s3 and state lock in dynamodb, as described in `/backend`

To modify the aws config, modify the badly named `/stack` directory

## `IAM` config as following

| IAM user | Role  |
| -------- | ----- |
| alban    | admin |
| dev      | dev   |

## TODO

- [ ] Migrate to later tf version
