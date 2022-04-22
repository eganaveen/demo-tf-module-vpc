resource "aws_subnet" "tfvpc-subnet1" {
  count = length(var.subnet1cidr)
  cidr_block = element(var.subnet1cidr, count.index) //["10.0.0.0/25", "10.0.0.128/25"]
  availability_zone = element(var.AZ, count.index)   //["us-east-1a","us-east-1b"]
  vpc_id     = aws_vpc.tfvpc.id
  tags = {
    Name = "${var.ENV}-${element(var.AZ,count.index)}"
  }
}