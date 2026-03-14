# Create the IPAM Manager
resource "aws_vpc_ipam" "main" {
  operating_regions {
    region_name = "eu-central-1"
  }

  tags = {
    Project = var.project_name
  }
}

# Create the IPAM Pool
resource "aws_vpc_ipam_pool" "ipv4" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.main.private_default_scope_id
  locale         = "eu-central-1"

  allocation_default_netmask_length = 24

  tags = {
    Name = "main-ipv4-pool"
  }
}

# Provision a CIDR to the Pool
resource "aws_vpc_ipam_pool_cidr" "ipv4_range" {
  ipam_pool_id = aws_vpc_ipam_pool.ipv4.id
  cidr         = "10.0.0.0/16" # The total range available for all VPCs
}
