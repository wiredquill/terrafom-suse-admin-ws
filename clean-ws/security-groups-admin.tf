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

  # All Local - internal
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
    description = "All Local traffic"
  }

 # api-server - everywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "RDP"
  }


  # api-server - everywhere
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "RDP"
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
