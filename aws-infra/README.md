# :mage_man: AWS Config

setup necessary `aws` resources, mainly users, roles & attach policies

the tfstate is stored in aws backend, see the backend directory for details.

## TF version

`niv` is used to lock the nixpkgs-unstable version

more here
https://github.com/nmattia/niv#update
https://xeiaso.net/blog/how-i-start-nix-2020-03-08

- `niv init` to get `nix/sources.*` to fix the nixpkgs version
- use that source in `shell.nix`

```nix
{
  sources ? import ./nix/sources.nix,
  pkgs ? import sources.nixpkgs {},
}:
pkgs.mkShell {
...
```

to update `niv update nixpkgs -t url.tar.gz`

### nixpkgs-unstable

point to `nixpkgs-unstable`, run

```
niv modify nixpkgs -a branch=nixpkgs-unstable
```

### Older versions

Can [be found here](https://lazamar.co.uk/nix-versions/?package=terraform&version=0.12.31&fullName=terraform-0.12.31&keyName=terraform_0_12&revision=c82b46413401efa740a0b994f52e9903a4f6dcd5&channel=nixpkgs-unstable#instructions)

Then `niv add nixpkgs -t url.tar.gz` for an older nixpkgs version for example

## Memo

The tf state is stored in s3 and state lock in dynamodb, as described in `/tf-backend` directory.

Rest of aws config is in badly named `/tf-misc` directory

## Howto change the backend

- Create the new backend
- Point any config relying on the backend to the new backend
- Delete the old backend

## TODOs

- [x] Migrate to later tf version

- [ ] User module to handle config ? https://registry.terraform.io/modules/trussworks/bootstrap/aws/latest

- [ ] We could have the `aws` provider in `shell.nix` as well, see https://discourse.nixos.org/t/terraform-how-you-override-a-version-using-nixpgks-way/10436/2

- [ ] Document which backend is currently active, looks to be paris

- [ ] Create the dns avoiding ads
