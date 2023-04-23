<a name="readme-top"></a>

## Introduction

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
   <li><a href="#intro">Introduction</a></li>
    <li><a href="#installation">Installation</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<p>This module was used in production to enable an external service provider to migrate an on-prem Oracle DB on two different environments (PROD/DEV) into an AWS RDS. The module has been anonymized here to protect the client. For the migration, the necessary S3 Buckets are already created in the mother account.
  This repo is just to give an illustration of my handling of Terraform.
  The configurations are stored in separate child modules, so that a better overview of the code is given.
</p>

<h5>This Terraform module holds the following configurations: </h5>
<ul>
  <li> Ec2 instance </li>
  <li> Security groups </li>
  <li> KMS keys </li>
  <li> EBS volume & attachment backup </li>
  <li> Associated IAM policies </li>
  <li> DB Subnet Group </li>
</ul>

  Here is the <a href="https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-setup-orcl.html#custom-setup-orcl.iam">link</a> to the documentation for the migration.

  </p>
</div>

## Installation
Following is an example of the imort:
   ```
   module "oracle-migration" {
      source                 = "app.terraform.io/company-a/oracle-migration/aws"
      version                = "0.1.56"
      subnet_id              = aws_subnet.private_a.id
      ami_value              = "AA_Hardened_GOLDAMI"
      aws_current_account_id = var.aws_account_id
      vpc_id                 = aws_vpc.main.id
      standard_sg_rds        = "sg_00000000"
      subnet_group_id_1      = "subnet_00000000"
      subnet_group_id_2      = "subnet_00000000"
}
   ```


<!-- CONTACT -->
## Contact

Patrick Richter - patrick.richter@patos-it.com
<p align="right">(<a href="#readme-top">back to top</a>)</p>
