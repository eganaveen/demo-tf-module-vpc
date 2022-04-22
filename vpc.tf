resource "aws_vpc" "tfvpc" {
  cidr_block = var.vpccidr
  enable_dns_hostnames = true
  tags = {
    Name= "${var.ENV}-vpc"
  }
}
