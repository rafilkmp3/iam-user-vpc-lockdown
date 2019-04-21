## Terraform module which creates a VPC on AWS and a user with full permission on this vpc.
How can I lock down my user’s Amazon EC2 access to a single VPC using terraform ? 



## Requiriments
- terraform
- [keybase](https://keybase.io/ "keybase")


## Usage

```hcl
module "user01" {
  source   = "git@github.com:rafilkmp3/terraform-iam-user-vpc-lockdown.git"

  region   = "us-west-2"
  username = "user-01"

  keybase-user = "test"
}

output "credentials" {
  value = "${module.applicant-03.credentials}"
}
```