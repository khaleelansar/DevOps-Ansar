resource "aws_vpc" "cust" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name="dev"
    }
  
}
resource "aws_internet_gateway" "cust" {
    vpc_id = aws_vpc.cust.id
  tags ={
    Name = "cust_ig"
  }
}
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.cust.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name ="cust_subnet"
    }
}
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.cust.id
    cidr_block = "10.0.8.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name ="cust_subnet"
    }
}
resource "aws_route_table" "cust_rt" {
    vpc_id = aws_vpc.cust.id

route {
    gateway_id = aws_internet_gateway.cust.id
    cidr_block = "0.0.0.0/0"

}

}
resource "aws_route_table_association" "cust" {
    route_table_id = aws_route_table.cust_rt.id
    subnet_id = aws_subnet.public.id
    
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.cust.id
  tags = {
    Name = "dev_sg"
  }
 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  }