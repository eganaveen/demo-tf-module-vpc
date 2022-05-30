resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tfvpc.id
  tags = {
    Name = "${var.ENV}-igw"
  }
}
resource "aws_eip" "eip" {}
resource "aws_nat_gateway" "ngw" {
  subnet_id = aws_subnet.public-subnet.id
  allocation_id = aws_eip.eip.id
  tags = {
    Name = "${var.ENV}-ngw"
  }
  depends_on = [aws_internet_gateway.igw]
}