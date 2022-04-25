resource "aws_subnet" "public-subnet1" {
  count = length(var.SUBNET_CIDR)
  cidr_block = element(var.SUBNET_CIDR, count.index[0]) //["10.0.0.0/25", "10.0.0.128/25"]
  availability_zone = element(var.AZ, count.index)   //["us-east-1a","us-east-1b"]
  vpc_id     = aws_vpc.tfvpc.id
  tags = {
    Name = "${var.ENV}-${element(var.AZ,count.index)}"
  }
}

resource "aws_subnet" "private-subnet1" {
  count = length(var.SUBNET_CIDR)
  cidr_block = element(var.SUBNET_CIDR, count.index[1]) //["10.0.0.0/25", "10.0.0.128/25"]
  availability_zone = element(var.AZ, count.index)   //["us-east-1a","us-east-1b"]
  vpc_id     = aws_vpc.tfvpc.id
  tags = {
    Name = "${var.ENV}-${element(var.AZ,count.index)}"
  }
}