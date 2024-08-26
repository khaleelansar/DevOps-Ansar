variable "ami" {
    description = "inserting ami values to main.tf"
    type = string
    default = "ami-02b49a24cfb95941c"
  
}

variable "type" {
    description = "inserting instance type to main.tf"
    type = string
    default = "t2.micro"
  
}
variable "key" {
    type = string
    default = "Sikindar"
  
}