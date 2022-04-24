
resource "aws_default_route_table" "dev-default-route-table-id" {
  default_route_table_id = aws_vpc.tfvpc.id
}



resource "aws_route_table_association" "rt-association" {
  route_table_id = aws_default_route_table.dev-default-route-table-id.id
  count = length(aws_subnet.tfvpc-subnet1.*.id)
  subnet_id = element(aws_subnet.tfvpc-subnet1.*.id, count.index )
}

resource "aws_route" "route-to-dev-vpc-rt" {
  route_table_id = var.DEFAULT_VPC_ROUTE_TABLE_ID
  destination_cidr_block = var.vpccidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-connection.id
}

resource "aws_route" "route-to-default-vpc-rt" {
  route_table_id = aws_default_route_table.dev-default-route-table-id.id
  destination_cidr_block = var.DEFAULT_VPC_CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-connection.id
}