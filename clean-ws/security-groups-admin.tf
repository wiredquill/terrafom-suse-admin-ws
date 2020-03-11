resource "aws_security_group" "admin" {
  description = "security rules for admin nodes"
  name        = "${var.stack_name}-admin"
  vpc_id      = aws_vpc.platform.id

  tags = merge(
    local.basic_tags,
    {
      "Name"  = "${var.stack_name}-admin"
      "Class" = "SecurityGroup"
    },
  )

  # etcd - internal
  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
    description = "etcd"
  }

  # api-server - everywhere
  ingress {
    from_port   = 22
    to_port     = 23
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "kubernetes api-server"
  }

    # everything outgoing - everywhere
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outgoing traffic"
    }
}
