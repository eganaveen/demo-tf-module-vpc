resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tfvpc.id
  tags = {
    Name = "${var.ENV}-igw"
  }
}