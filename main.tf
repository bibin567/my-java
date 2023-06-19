provider "aws" {
  region = "us-west-2"  # Update with your desired AWS region
}

resource "aws_instance" "web" {
  ami           = "ami-022e1a32d3f742bd8"  # Update with your desired AMI ID
  instance_type = "t2.micro"

  key_name               = "bibinaws123"  # Update with your key pair name
  security_group_ids     = [aws_security_group.default.id]
}

resource "aws_security_group" "default" {
  name        = "my-webserver-sG123"
  description = "Security group for the web server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
