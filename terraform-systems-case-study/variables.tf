# ...
variable "ami" {
  type    = "string"
  default = "ami-9887c6e7"
}

variable "instance_type" {
    type = "string"
    default = "t2.micro"
}

variable "key_name" {
    type = "string"
    default = "case-study"
}

variable "subnet_id" {
    type = "string"
    default = "subnet-086f3ed6742f38a16"
}

variable "vpc_security_group_ids" {
    type = "list"
    default =  ["sg-03e9111b3bb9f8b40"]
}

variable "candidate" {
  description = "Your name"
  type        = "string"
  default = "manjur_khan"
}