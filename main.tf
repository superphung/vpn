provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_key_pair" "example" {
  key_name   = "example"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "example" {
  ami           = "ami-ba0329dc"
  instance_type = "t2.micro"
  security_groups = [
    "${aws_security_group.allow_shadowsocks.name}"
  ]
  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }
  key_name = aws_key_pair.example.key_name
}

resource "aws_security_group" "allow_shadowsocks" {
  name        = "allow_shadowsocks"
  description = "allow shadowsocks inbound traffic"

  ingress {
    from_port   = 12345
    to_port     = 12345
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shadowsocks"
  }
}

resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.example.id
}

output "ip" {
  value = aws_eip.ip.public_ip
}

