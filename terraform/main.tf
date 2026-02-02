provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "insecure_sg" {
  name        = "insecure-sg"
  description = "Security group with bad practices"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
