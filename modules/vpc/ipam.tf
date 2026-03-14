data "aws_vpc_ipams" "existing" {}

locals {
  ipam_id = data.aws_vpc_ipams.existing.ipams[0].id
}

resource "aws_vpc_ipam_pool" "ipv4" {
  address_family = "ipv4"
  ipam_scope_id  = data.aws_vpc_ipams.existing.ipams[0].private_default_scope_id
  locale         = "eu-central-1"

  # Explicitly allow the size for VPCs
  allocation_min_netmask_length     = 8
  allocation_max_netmask_length     = 32
  allocation_default_netmask_length = 24

  tags = {
    Name = "main-ipv4-pool"
  }
}

# Provision the CIDR to the pool
resource "aws_vpc_ipam_pool_cidr" "ipv4_range" {
  ipam_pool_id = aws_vpc_ipam_pool.ipv4.id
  cidr         = "10.0.0.0/16"
}
