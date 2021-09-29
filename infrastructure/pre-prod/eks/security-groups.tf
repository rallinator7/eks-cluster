resource "aws_security_group" "linux_group" {
  name_prefix = "linux_group_security"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "192.168.0.0/16",
      "172.16.0.0/12",
    ]
  }
}