# Define the provider and region
provider "aws" {
  access_key = ""
  secret_key = ""
  # Change to your desired AWS region
  region = "" 
}

# Data source to retrieve an existing VPC
data "aws_vpc" "existing_vpc" {
  # Replace with the ID of your existing VPC
  id = ""  
}

# Data source to retrieve an existing subnet
data "aws_subnet" "existing_subnet2" {
  # Replace with the ID of your existing subnet
  id = ""  
}

# Data source to retrieve an existing security group
data "aws_security_group" "existing_sg" {
  # Replace with the name of your existing security group
  id = ""  
}

# Create the second EC2 instance in the existing subnet
resource "aws_instance" "instance2" {
  # Replace with your desired AMI ID
  ami           = ""
  instance_type = "t2.micro"
  # Reference the existing subnet
  subnet_id     = data.aws_subnet.existing_subnet2.id  
  security_groups = [data.aws_security_group.existing_sg.id]
  # Replace with your SSH key pair name
  key_name      = ""
  # Specify the desired availability zone
  availability_zone = ""
  user_data = "${file("deploy.sh")}"

  tags = {
    Name = "TF_DP-4_instance"
  }
}

output "instance_ip" {
  value = aws_instance.instance2.public_ip
}
