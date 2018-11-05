variable "candidate" {
  description = "Your name"
  type        = "string"
  default = "manjur_khan"
}

variable "ami" {
  description = "Provided AMI"
  type        = "string"
}

variable "instance_type" {
  description = "Instance size"
  type        = "string"
}

variable "key_name" {
  description = "SSH key name"
  type        = "string"
}

variable "subnet_id" {
  description = "Provided subnet id"
  type        = "string"
}

variable "vpc_security_group_ids" {
  description = "Provided security group id"
  type        = "list"
}

variable "tags" {
  description = "Extra tags"
  type        = "map"
}
