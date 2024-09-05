provider "aws" {
  
}
 
resource "aws_s3_bucket" "ansar" {
    bucket = "ansarrrrrrrrr"
  
} 
resource "aws_dynamodb_table" "mytable" { 
    name = "mytable"
    hash_key = "LockID"
    read_capacity = 20
    write_capacity = 20 

    attribute {
    name = "LockID"
    type = "S"
  }
  
}