resource "aws_route_table" "private_ipv6_only" {
  vpc_id = aws_vpc.main.id

  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.main.id
  }

  route {
    ipv6_cidr_block = "64:ff9b::/96"
    nat_gateway_id  = aws_nat_gateway.main.id
  }

  tags = {
    Name = "private-ipv6-only-rt"
  }
}

resource "aws_route_table" "dual_stack_rt" {
  vpc_id = aws_vpc.main.id

  # IPv4 Outbound (via NAT Gateway)
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat64.id
  }

  # IPv6 Outbound (via Egress-Only IGW)
  route {
    ipv6_cidr_block        = "::/0"
    egress_only_gateway_id = aws_egress_only_internet_gateway.main.id
  }

  tags = {
    Name = "dual-stack-rt"
  }
}

resource "aws_route_table_association" "ipv6_only_assoc" {
  subnet_id      = aws_subnet.ipv6_only.id
  route_table_id = aws_route_table.private_ipv6_only.id
}

resource "aws_route_table_association" "dual_stack_assoc" {
  subnet_id      = aws_subnet.dual_stack.id
  route_table_id = aws_route_table.dual_stack_rt.id
}
