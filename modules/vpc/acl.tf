resource "aws_network_acl" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Project = "${var.project_name}"
  }
}

# IPv4 rules
resource "aws_network_acl_rule" "acl_rule_ingress" {
  network_acl_id = aws_network_acl.main.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 65535
}

resource "aws_network_acl_rule" "acl_rule_egress" {
  network_acl_id = aws_network_acl.main.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  cidr_block     = "0.0.0.0/0"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 65535
}

# IPv6 rules
resource "aws_network_acl_rule" "ipv6_ingress_ephemeral" {
  network_acl_id  = aws_network_acl.main.id
  rule_number     = 110
  egress          = false
  protocol        = "-1"
  rule_action     = "allow"
  ipv6_cidr_block = "::/0"
  from_port       = 0
  to_port         = 65535
}

resource "aws_netork_acl_rule" "ipv6_egress_ephemeral" {
  network_acl_id  = aws_network_acl.main.id
  rule_number     = 110
  egress          = true
  protocol        = "-1"
  rule_action     = "allow"
  ipv6_cidr_block = "::/0"
  from_port       = 0
  to_port         = 65535
}
