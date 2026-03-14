terraform {
  backend "s3" {
    bucket       = "aws-terrafrom-states-files"
    key          = "vpc-ipv6/VPC/terraform.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
    profile      = "second"
  }
}
