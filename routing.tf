data "aws_route_table" "default-route-table" {
  vpc_id = var.DEFAULT_VPC_ID
}

data "aws_internet_gateway" "igw" {}

  #resource "aws_default_route_table" "system-default-route-table-id" {
  #  default_route_table_id = data.aws_route_table.default-route-table.route_table_id
  #}

resource "aws_default_route_table" "dev-default-route-table-id" {
  default_route_table_id = aws_vpc.tfvpc.main_route_table_id
}

resource "aws_route_table_association" "rt-association" {
  route_table_id = aws_default_route_table.dev-default-route-table-id.default_route_table_id
  count = length(aws_subnet.tfvpc-subnet1.*.id)
  subnet_id = element(aws_subnet.tfvpc-subnet1.*.id, count.index )
}

resource "aws_route" "route-to-dev-vpc-rt" {
  route_table_id = data.aws_route_table.default-route-table.route_table_id//var.DEFAULT_VPC_ROUTE_TABLE_ID
  destination_cidr_block = var.vpccidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-connection.id
}

resource "aws_route" "route-to-default-vpc-rt1" {
  route_table_id = aws_default_route_table.dev-default-route-table-id.default_route_table_id
  destination_cidr_block = var.DEFAULT_VPC_CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-connection.id
}

resource "aws_route" "route-to-default-vpc-rt2" {
  route_table_id = aws_default_route_table.dev-default-route-table-id.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  local_gateway_id = aws_internet_gateway.igw.id
}