resource "aws_vpc" "main" {
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.ipv4.id
  ipv4_netmask_length = 24

  assign_generated_ipv6_cidr_block     = true
  enable_dns_support                   = true
  enable_dns_hostnames                 = true
  enable_network_address_usage_metrics = true

  tags = {
    Project = var.project_name
  }
}
