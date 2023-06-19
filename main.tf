provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "default" {
  name        = "my-webserver-sg3"
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
  key_name               = "bibinaws123"            # Replace with the desired key pair name
  vpc_security_group_ids = [aws_security_group.default.id]
  tags                   = {
    Name = "my-webserver"
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum install -y java-11-openjdk
    cat <<EOF > /opt/my-java-project/Main.java
package com.example.myjavaproject;

import static spark.Spark.*;

public class Main {
    public static void main(String[] args) {
        port(8080); // Set the server port to 8080

        get("/", (req, res) -> "Hello, World!"); // Define a route and return response
    }
}
EOF"

    javac -d /opt/my-java-project /opt/my-java-project/Main.java
    java -cp /opt/my-java-project com.example.myjavaproject.Main
EOF

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/user_data.sh",
      "/tmp/user_data.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"                           # Replace with the SSH user of your EC2 instance
      host        = self.public_ip
    }
  }
}

