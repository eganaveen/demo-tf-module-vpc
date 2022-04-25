resource "aws_subnet" "public-subnet" {
#  count = length(var.SUBNET_CIDR)
  cidr_block = var.SUBNET_CIDR[0] //["10.0.0.0/25", "10.0.0.128/25"]
  availability_zone = var.AZ[0]   //["us-east-1a","us-east-1b"]
  vpc_id     = aws_vpc.tfvpc.id
  tags = {
    Name = "${var.ENV}-public-${var.AZ[0]}"
  }
}

resource "aws_subnet" "private-subnet" {
#  count = length(var.SUBNET_CIDR)
  cidr_block = var.SUBNET_CIDR[1] //["10.0.0.0/25", "10.0.0.128/25"]
  availability_zone = var.AZ[1]   //["us-east-1a","us-east-1b"]
  vpc_id     = aws_vpc.tfvpc.id
  tags = {
    Name = "${var.ENV}-private-${var.AZ[1]}"
  }
}