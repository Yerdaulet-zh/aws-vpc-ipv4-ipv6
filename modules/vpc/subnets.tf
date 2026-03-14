resource "aws_subnet" "ipv4_only" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.ipv6_only_subnet_cidr

  tags = {
    Name = "ipv4-only-subnet"
  }
}

resource "aws_subnet" "dual_stack" {
  vpc_id          = aws_vpc.main.id
  cidr_block      = var.dual_stack_cidr
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

  enable_dns64 = true

  tags = {
    Name = "ipv6-only-subnet"
  }
}
