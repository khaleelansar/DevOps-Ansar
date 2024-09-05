resource "aws_instance" "name" {
    ami = "ami-0e53db6fd757e38c7"
    instance_type = "t2.micro"
    key_name = "Sikindar" 
} 
resource "aws_s3_bucket" "name" {
    bucket = "bhayuuuuuuuu"
  
}