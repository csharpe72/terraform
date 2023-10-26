# RSA key of size 4096 bits - Not to be used in production environment. This should be created outside of terraform
# Because it is stored unencrypted in the state file.
# resource "tls_private_key" "rsa" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

/*** The public key for the key pair we'll use to ssh into our bastion instance.*/
# resource "aws_key_pair" "bastion" {
#   key_name   = "Jenkins_Server"
#   public_key = ""
# }

# resource "local_file" "bastion" {
#   content         = tls_private_key.rsa.private_key_pem
#   filename        = "bastion"
#   file_permission = "0400"
#   # filename = "${path.module}/foo.bar"
# }
/*** Launch a bastion instance we can use to gain access to the private subnets of* this availabilty zone.*/
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "random_shuffle" "subnets" {
  input        = var.subnets
  result_count = 1
}

resource "aws_instance" "bastion" {

  ami                         = data.aws_ami.ubuntu.image_id
  key_name                    = var.key_name
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = random_shuffle.subnets.result[0]
  vpc_security_group_ids      = [var.bastion_security_groups]


  tags = merge(
    var.tags,
    {
      Name = "jenkins-bastion"
    },
  )
}

# /*** Launch a jenkins master instance in the private subnet. */

resource "aws_instance" "jenkins_master" {

  for_each                    = var.private_subnets
  ami                         = data.aws_ami.ubuntu.image_id
  key_name                    = var.key_name
  instance_type               = var.instance_type
  associate_public_ip_address = false
  subnet_id                   = var.private_subnets[each.key]
  vpc_security_group_ids      = [var.web_security_groups]

  user_data = file("${path.module}/scripts/bootstrap.sh")
  tags = {
    Terraform = "true"
    Name      = "jenkins-master-${each.value}"
  }
}
