variable "my_public_key" {}

variable "instance_type" {}

variable "redhat-ami" {}

variable "security_group" {}

variable "subnets" {
  type = list(string)
}
