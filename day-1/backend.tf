terraform {
  backend "s3" {
    bucket = "ansarrrrrrrr"
    key    = "test/terraform.tfstate"
    region = "ap-south-1"
  }
}