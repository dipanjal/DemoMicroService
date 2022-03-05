terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0892d3c7ee96c0bf7"
  instance_type = var.instance_type
  count = var.instances_per_subnet
  key_name= var.key_pair
  tags = {
    Name  = element(var.instance_tags, count.index)
  }
}

# keypair in key pairs
resource "aws_key_pair" "deployer" {
  key_name   = var.key_pair
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2EbBNIMDBz7mGvx5BsHvqVxgX+CfR9Bq1pzskgGDRr/OTmlalxbMDLkp364VIphbdyOwfgF8obIzv1p2h5MczW/1MB1vtvM6/V2pLP2HDB1BL0rrIEV8/i/qQT8zF0zsuNb4SsMasKHN6uCJcMKN0Gpk26ZENSaLiQOP4OL1SFXny1XavXHp9g0oEL6GfpGrkUabYItOM+1JAM/YdPjpUfpw/HEh37h24nw14knpI//IpRIJHWn6PYec7hOD14Sis+t5k/NAYkrT0AyBFJkFTmMA0lpKjuSlmjtIjt1pDbD6uq3sRI2iw2StBgtVWAOJmA2x5biYIXZM+dU30LdRr safayet@safayet-MS-7D17"
}

module "network" {
  source = "./modules"
}
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}