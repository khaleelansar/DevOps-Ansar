provider "aws" {
    region = "ap-south-1" 
} 
 
resource "aws_key_pair" "example" {
  key_name   = "test"  # Replace with your desired key name
  public_key = file("~/.ssh/id_rsa.pub") 


} 
 
 resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
   
 } 
  
resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
} 
  
resource "aws_subnet" "sub2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
}
resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
    
} 

resource "aws_route_table" "myRt" {
    vpc_id = aws_vpc.myvpc.id

    route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
    }
} 
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.sub1.id
    route_table_id = aws_route_table.myRt.id
  
} 
resource "aws_security_group" "webSg" {
  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
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

  tags = {
    Name = "Web-sg"
  }
}
resource "aws_instance" "myterraforminstance" {
    ami = "ami-02b49a24cfb95941c"
    instance_type = "t2.micro"
    key_name = aws_key_pair.example.id
    vpc_security_group_ids = [aws_security_group.webSg.id]
    subnet_id = aws_subnet.sub1.id

  connection {
    type        = "ssh"
    user        = "linuxos"  # Replace with the appropriate username for your EC2 instance
    # private_key = file("C:/Users/veerababu/.ssh/id_rsa")
    private_key = file("~/.ssh/id_rsa")  #private key path
    host        = self.public_ip
  }  
    provisioner "local-exec" {
    command = "touch file500"
 
    }
 }