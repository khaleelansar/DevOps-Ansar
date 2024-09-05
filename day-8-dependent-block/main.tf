resource "aws_instance" "mine" {
    ami = "ami-0e53db6fd757e38c7"
    instance_type = "t2.micro"
    key_name = "Sikindar"
    depends_on = [aws_s3_bucket.Ansar]
}

resource "aws_s3_bucket" "Ansar" {
    bucket = "ammiiiiiiiiiii"
  
}