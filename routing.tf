data "aws_route_table" "default-route-table" {
  vpc_id = var.DEFAULT_VPC_ID
}

resource "aws_route_table" "dev-private_route_table" {
  vpc_id = aws_vpc.tfvpc.id
}

resource "aws_default_route_table" "dev-public-route-table-id" {
  default_route_table_id = aws_vpc.tfvpc.main_route_table_id
}

resource "aws_route_table_association" "public-rt-association" {
  route_table_id = aws_default_route_table.dev-public-route-table-id.default_route_table_id
  subnet_id = aws_subnet.public-subnet.id
}

resource "aws_route_table_association" "private-rt-association" {
  route_table_id = aws_route_table.dev-private_route_table.id
  subnet_id = aws_subnet.private-subnet.id
}

resource "aws_route" "route-to-default-vpc-rt" {
  route_table_id = data.aws_route_table.default-route-table.route_table_id
  destination_cidr_block = var.vpccidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-connection.id
}

resource "aws_route" "route-to-dev-vpc-rt" {
  route_table_id = aws_default_route_table.dev-public-route-table-id.id
  destination_cidr_block = var.DEFAULT_VPC_CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-connection.id
}

resource "aws_route" "route-to-dev-vpc-rt" {
  route_table_id = aws_default_route_table.dev-public-route-table-id.id
  destination_cidr_block = var.DEFAULT_VPC_CIDR
  gateway_id = aws_internet_gateway.igw.id
}

#resource "aws_route" "route-to-default-vpc-rt" {
#  route_table_id = data.aws_route_table.default-route-table.route_table_id
#  destination_cidr_block = var.vpccidr
#  vpc_peering_connection_id = aws_vpc_peering_connection.peering-connection.id
#}
#
#resource "aws_route" "route-to-dev-vpc-rt1" {
#  route_table_id = aws_default_route_table.dev-default-route-table-id.default_route_table_id
#  destination_cidr_block = var.DEFAULT_VPC_CIDR
#  vpc_peering_connection_id = aws_vpc_peering_connection.peering-connection.id
#}
#
#resource "aws_route" "route-to-dev-vpc-rt2" {
#  route_table_id = aws_default_route_table.dev-default-route-table-id.default_route_table_id
#  destination_cidr_block = "0.0.0.0/0"
#  gateway_id = aws_internet_gateway.igw.id
#}