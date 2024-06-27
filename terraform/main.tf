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

resource "aws_internet_gateway" "main" {
  vpc_id = "vpc-0e76b5906fe7fcc3d"
}

resource "aws_route_table" "public_route_table" {
  vpc_id = "vpc-0e76b5906fe7fcc3d"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_instance" "ubuntu_server" {
  ami                    = "ami-00a140d6713ea188d" # Ubuntu Server 22.04 AMI ID, update if necessary
  instance_type          = "t3a.small"
  key_name               = "jonas"
  associate_public_ip_address = true
  iam_instance_profile   = "admin"

  subnet_id              = "subnet-05005979f45f3dbb7"

  vpc_security_group_ids = ["sg-0153c7640dad0cd3d"]

  tags = {
    Name = "bastion"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get upgrade -y
              EOF
}

