resource "aws_vpc" "tfvpc" {
  cidr_block = var.vpccidr
  enable_dns_hostnames = true
  tags = {
    Name= "${var.ENV}-vpc"
  }
}

output "dev-vpc-route-id" {
  value = aws_vpc.tfvpc.id
}
