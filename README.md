## Terraform module which creates a VPC on AWS and a user with full permission on this vpc.

As a cloud support engineer, I am frequently asked this question: “How can I lock down my user’s Amazon EC2 access to a single VPC?” This blog post will answer the question and explain how you can help control this level of access through the use of AWS Identity and Access Management (IAM) policies and IAM roles.

AWS have this [Post ](https://aws.amazon.com/pt/blogs/security/how-to-help-lock-down-a-users-amazon-ec2-capabilities-to-a-single-vpc/ "Post") teaching how to achieve this, but it seems painful to me, so I developed this module, I hope this can be useful for you to allow you to easily create a credential for your developers or candidates for vacancies in your company :)

This module outputs creditials can be decrypted either using keybase.io web-site or using command line to get user's password and user's secret key:

For example, user with username `test` has done it properly and you can [verify it here](https://keybase.io/test/pgp_keys.asc).
## Requiriments
- Terraform
- [Keybase](https://keybase.io/ "Keybase")


## Usage

```hcl
module "user01" {
  source   = "git@github.com:rafilkmp3/terraform-iam-user-vpc-lockdown.git"

  region   = "us-west-2"
  username = "user-01"

  keybase-user = "test"
}

output "credentials" {
  value = "${module.user01.credentials}"
}
```