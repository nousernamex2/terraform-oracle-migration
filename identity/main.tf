module "security" {
  source          = "../security"
  standard_sg_rds = "0000000"
  vpc_id          = "0000000"
}

resource "aws_iam_policy" "aws_rds_custom_instance_role_for_rds" {
  name = "aws_rds_custom_instance_role_for_rds"
  path = "/"

  policy = jsonencode({
    "Version" : "2012_10_17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:DescribeAssociation",
          "ssm:GetDeployablePatchSnapshotForInstance",
          "ssm:GetDocument",
          "ssm:DescribeDocument",
          "ssm:GetManifest",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:ListAssociations",
          "ssm:ListInstanceAssociations",
          "ssm:PutInventory",
          "ssm:PutComplianceItems",
          "ssm:PutConfigurePackageResult",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ssm:UpdateInstanceInformation",
          "ssm:GetConnectionStatus",
          "ssm:DescribeInstanceInformation",
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
          "iam:CreateServiceLinkedRole"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:PutRetentionPolicy",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:DescribeLogGroups",
          "logs:CreateLogStream",
          "logs:CreateLogGroup"
        ],
        "Resource" : [
          "arn:aws:logs:eu-central-1:*:log-group:rds-custom-instance*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:GetObjectTagging",
          "s3:ListBucket",
          "s3:GetObjectVersion"
        ],
        "Resource" : [
          "arn:aws:s3:::my-company-migration-dev/*",
          "arn:aws:s3:::my-company-migration-dev",
          "arn:aws:s3:::my-company-migration-prod",
          "arn:aws:s3:::my-company-migration-prod/*",
          "arn:aws:s3:::do-not-delete-rds-custom-*/*"
        ]
      },
      {
        "Sid" : "PermissionForByom",
        "Effect" : "Allow",
        "Action" : [
          "mediaimport:CreateDatabaseBinarySnapshot"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "ValidateIamRole",
        "Effect" : "Allow",
        "Action" : "iam:SimulatePrincipalPolicy",
        "Resource" : "*"
      },
      {
        "Sid" : "CreateCloudTrail",
        "Effect" : "Allow",
        "Action" : [
          "cloudtrail:CreateTrail",
          "cloudtrail:StartLogging"
        ],
        "Resource" : ["arn:aws:cloudtrail:*:*:trail/do-not-delete-rds-custom-*",
          "arn:aws:cloudtrail:*:*:trail/my-company-migration-dev*",
        "arn:aws:cloudtrail:*:*:trail/my-company-migration-prod*"]
      },
      {
        "Sid" : "CreateS3Bucket",
        "Effect" : "Allow",
        "Action" : [
          "s3:CreateBucket",
          "s3:PutBucketPolicy",
          "s3:PutBucketObjectLockConfiguration",
          "s3:PutBucketVersioning"
        ],
        "Resource" : [
          "arn:aws:s3:::do-not-delete-rds-custom-*",
          "arn:aws:s3:::my-company-migration-dev",
          "arn:aws:s3:::my-company-migration-dev/*",
          "arn:aws:s3:::my-company-migration-prod/*",
          "arn:aws:s3:::my-company-migration-prod"
        ]
      },
      {
        "Sid" : "CreateKmsGrant",
        "Effect" : "Allow",
        "Action" : [
          "kms:CreateGrant",
          "kms:DescribeKey"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "cloudwatch:PutMetricData"
        ],
        "Resource" : [
          "*"
        ],
        "Condition" : {
          "StringEquals" : {
            "cloudwatch:namespace" : [
              "RDSCustomForOracle/Agent"
            ]
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "events:PutEvents"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ],
        "Resource" : [
          "arn:aws:secretsmanager:eu-central-1:${var.aws_current_account_id}:secret:do-not-delete-rds-custom-*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucketVersions"
        ],
        "Resource" : [
          "arn:aws:s3:::my-company-migration-dev*",
          "arn:aws:s3:::my-company-migration-prod*",
          "arn:aws:s3:::do-not-delete-rds-custom-*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : "ec2:CreateSnapshots",
        "Resource" : [
          "arn:aws:ec2:*:*:instance/*",
          "arn:aws:ec2:*:*:volume/*"
        ],
        "Condition" : {
          "StringEquals" : {
            "ec2:ResourceTag/AWSRDSCustom" : "custom_oracle"
          }
        }
      },
      {
        "Effect" : "Allow",
        "Action" : "ec2:CreateSnapshots",
        "Resource" : [
          "arn:aws:ec2:*::snapshot/*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        "Resource" : [
          "arn:aws:kms:eu-central-1:${var.aws_current_account_id}:key/${module.security.kms_key_id}"

        ]
      },
      {
        "Effect" : "Allow",
        "Action" : "ec2:CreateTags",
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "ec2:CreateAction" : [
              "CreateSnapshots"
            ]
          }
        }
      },
      {
        "Sid" : "AllowListSingleKMSKey",
        "Effect" : "Allow",
        "Action" : "kms:ListKeys",
        "Resource" : "arn:aws:kms:eu-central-1:00000000:key/00000-0000-0000-0000-00000000"
      },
      {
        "Effect" : "Allow",
        "Action" : "iam:PassRole",
        "Resource" : "arn:aws:iam::0000000:role/AWSRDSCustom-instance-role-for-rds",
      }
    ]
  })

  tags = {
    tf_resource = "aws_iam_policy.aws_rds_custom_instance_role_for_rds"
    Name        = "AWSRDSCustom-instance-role-for-rds"
  }

}

resource "aws_iam_role" "aws_rds_custom_instance_role_for_rds" {
  name               = "AWSRDSCustom-instance-role-for-rds"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "rds_custom_attachement" {
  role       = aws_iam_role.aws_rds_custom_instance_role_for_rds.name
  policy_arn = aws_iam_policy.aws_rds_custom_instance_role_for_rds.arn
}

resource "aws_iam_role_policy_attachment" "external_providers" {
  role       = data.aws_iam_role.external_providers.name
  policy_arn = aws_iam_policy.aws_rds_custom_instance_role_for_rds.arn
}

resource "aws_iam_role_policy_attachment" "AmazonRDSFullAccess" {
  for_each   = var.iam_roles
  role       = each.value
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

resource "aws_iam_role_policy_attachment" "rds_full_access_custom_for_external_provider_role" {
  role       = data.aws_iam_role.external_providers.name
  policy_arn = aws_iam_policy.aws_rds_custom_instance_role_for_rds.arn
}

resource "aws_iam_instance_profile" "aws_rds_custom_instance_role_for_rds" {
  name = "AWSRDSCustomInstanceRole"
  role = aws_iam_role.aws_rds_custom_instance_role_for_rds.name
}