module "dev" {
    source = "../day-2-dotfiles"
    ami_id = "ami-066784287e358dad1"
    instance_type ="t2.micro"
    key_name ="Annu" 
    
}