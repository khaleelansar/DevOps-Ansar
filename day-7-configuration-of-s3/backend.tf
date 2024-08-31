terraform {
  backend "s3" {
    bucket = "ansarrrrrrrr"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "mytable" # DynamoDB table used for state locking, note: first run "day-5-resources-s3-dynamodb-for-statefile" to create s3 and dynamodb resources
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
  }
}