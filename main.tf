provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "default" {
  name        = "my-webserver-sg1"
  description = "Security group for the web server"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "web" {
  ami                    = "ami-022e1a32d3f742bd8"  # Replace with the desired AMI ID
  instance_type          = "t2.micro"
  key_name               = "bibinaws123"    # Replacee with the desired key pair name
  vpc_security_group_ids = [aws_security_group.default.id]
  tags = {
    Name = "my-webserver"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y java-11-openjdk",
      "curl -O https://my-webserver-code-url.jar",  # Replace with the actual URL of your web server code JAR
      "java -jar my-webserver-code.jar &"          # Replace with the actual JAR file name
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"                      # Replace with the SSH user of your EC2 instance
      host        = self.public_ip
    }
  }
}
