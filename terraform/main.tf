terraform {
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Public ALB SG: allow inbound HTTPS from Internet"

  ingress {
    description = "Allow HTTPS from Internet to ALB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow egress from ALB"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "App SG: allow inbound only from ALB SG"

  ingress {
    description              = "Allow HTTP from ALB only"
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    source_security_group_id = aws_security_group.alb_sg.id
  }

  egress {
    description = "Allow egress from app"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


