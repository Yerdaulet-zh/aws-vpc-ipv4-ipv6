resource "aws_subnet" "ipv4_only" {
  vpc_id = aws_vpc.main.id
  # Using index 4 to move away from the contested lower ranges
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 4, 4)

  tags = {
    Name = "ipv4-only-subnet"
  }
}

resource "aws_subnet" "dual_stack" {
  vpc_id = aws_vpc.main.id
  # Using index 5 to ensure no overlap with index 4
  cidr_block      = cidrsubnet(aws_vpc.main.cidr_block, 4, 5)
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 2)

  assign_ipv6_address_on_creation = true

  tags = {
    Name = "dual-stack-subnet"
  }
}

resource "aws_subnet" "ipv6_only" {
  vpc_id          = aws_vpc.main.id
  ipv6_native     = true
  ipv6_cidr_block = cidrsubnet(aws_vpc.main.ipv6_cidr_block, 8, 3)

  assign_ipv6_address_on_creation = true
  enable_dns64                    = true

  # REQUIRED for ipv6_native = true
  enable_resource_name_dns_aaaa_record_on_launch = true

  tags = {
    Name = "ipv6-only-subnet"
  }
}
