variable "instance_tags" {
  type = list
  default = ["worker", "master"]
}
variable "instances_per_subnet" {
  description = "Number of EC2 instances in each private subnet"
  type        = number
  default     = 2
}
variable "instance_type" {
  default = "t2.micro"
}

variable "key_pair" {
  default = "ec2_key"
  type    = string
}