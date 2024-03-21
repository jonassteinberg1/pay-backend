resource "aws_vpc_endpoint" "efs" {
  vpc_id       = "vpc-0e76b5906fe7fcc3d"
  service_name = "com.amazonaws.us-west-2.elasticfilesystem"
  vpc_endpoint_type = "Interface"

  subnet_ids = ["subnet-001e96937b3824333"]

  # security_group_ids = [/* List of security group IDs */]

  private_dns_enabled = true

  tags = {
    Name = "EFSVpcEndpoint"
  }
}

