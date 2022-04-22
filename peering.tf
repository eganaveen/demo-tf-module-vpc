resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = aws_vpc.tfvpc.id
  vpc_id        = var.DEFAULT_VPC_ID
  auto_accept   = true

  tags = {
    Name = "peer-from-${var.ENV}-to-deafault-vpc"
  }
}