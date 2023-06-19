# Define provider (AWS)
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-053b0d53c279acc90"  # Replace with the Ubuntu AMI ID for your desired region
  instance_type = "t2.micro"
  key_name      = "bibinaws123"

  tags = {
    Name = "Tomcat Instance"
  }

  # Configure security group for ports 8080 and 22
  vpc_security_group_ids = [aws_security_group.tomcat_security_group.id]

  # Define user data with Tomcat installation and deployments
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y tomcat9
              sudo apt-get install -y wget

              # Download the sample.war file
              wget -P /tmp https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war

              # Deploy the sample.war to Tomcat
              sudo cp /tmp/sample.war /var/lib/tomcat9/webapps/sample.war
              sudo systemctl restart tomcat9
              EOF
}

# Create a security group for Tomcat instance
resource "aws_security_group" "tomcat_security_group" {
  name        = "tomcat_security_group"
  description = "Security group for Tomcat instance"

  # Allow inbound traffic on ports 8080 and 22
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

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
