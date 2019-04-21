{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "NonResourceBasedReadOnlyPermissions",
            "Action": [
                "ec2:Describe*",
                "ec2:CreateKeyPair",
                "ec2:CreateSecurityGroup",
                "iam:GetInstanceProfiles",
                "iam:ListInstanceProfiles"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "AllowInstanceActions",
            "Effect": "Allow",
            "Action": [
                "ec2:RebootInstances",
                "ec2:StopInstances",
                "ec2:TerminateInstances",
                "ec2:StartInstances",
                "ec2:AttachVolume",
                "ec2:DetachVolume"
            ],
            "Resource": "arn:aws:ec2:${REGION}:${ACCOUNT_NUMBER}:instance/*"
        },
        {
            "Sid": "EC2RunInstances",
            "Effect": "Allow",
            "Action": "ec2:RunInstances",
            "Resource": "arn:aws:ec2:${REGION}:${ACCOUNT_NUMBER}:instance/*"
        },
        {
            "Sid": "EC2RunInstancesSubnet",
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "arn:aws:ec2:${REGION}:${ACCOUNT_NUMBER}:subnet/*",
            "Condition": {
                "StringEquals": {
                    "ec2:Vpc": "arn:aws:ec2:${REGION}:${ACCOUNT_NUMBER}:vpc/${VPC_ID}"
                }
            }
        },
        {
            "Sid": "RemainingRunInstancePermissions",
            "Effect": "Allow",
            "Action": "ec2:RunInstances",
            "Resource": [
                "arn:aws:ec2:${REGION}:${ACCOUNT_NUMBER}:volume/*",
                "arn:aws:ec2:${REGION}::image/*",
                "arn:aws:ec2:${REGION}::snapshot/*",
                "arn:aws:ec2:${REGION}:${ACCOUNT_NUMBER}:network-interface/*",
                "arn:aws:ec2:${REGION}:${ACCOUNT_NUMBER}:key-pair/*",
                "arn:aws:ec2:${REGION}:${ACCOUNT_NUMBER}:security-group/*"
            ]
        },
        {
            "Sid": "EC2VpcNonresourceSpecificActions",
            "Effect": "Allow",
            "Action": [
                "ec2:DeleteNetworkAcl",
                "ec2:DeleteNetworkAclEntry",
                "ec2:DeleteRoute",
                "ec2:DeleteRouteTable",
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:RevokeSecurityGroupEgress",
                "ec2:RevokeSecurityGroupIngress",
                "ec2:DeleteSecurityGroup"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "ec2:Vpc": "arn:aws:ec2:${REGION}:${ACCOUNT_NUMBER}:vpc/${VPC_ID}"
                }
            }
        }
    ]
}