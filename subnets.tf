resource "aws_subnet" "tfvpc-subnet1" {
  count = length(var.subnet1cidr)
  cidr_block = element(var.subnet1cidr,count.index)
  availability_zone = element(var.AZ,count.index)
  vpc_id     = aws_vpc.tfvpc.id
  tags = {
    Name = "${var.ENV}-${element(var.AZ,count.index)}"
  }
}