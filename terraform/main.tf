resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "kubernetes_nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = "subnet-05005979f45f3dbb7"
  tags = {
    Name = "kubernetes-nat-gateway"
  }
}

resource "aws_route_table" "nat_gateway_private_subnet_route_table" {
  vpc_id = "vpc-0e76b5906fe7fcc3d"
}

resource "aws_route" "nat_gateway_route" {
  route_table_id         = "rtb-0b00a8e8bf0226e73"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.kubernetes_nat_gateway.id
}
