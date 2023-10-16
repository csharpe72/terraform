
/*** The public key for the key pair we'll use to ssh into our bastion instance.*/ 

resource "aws_key_pair" "bastion" { 
	key_name   = "bastion-key" 
    public_key = var.public_key 
 } 
 
 /*** This parameter contains the AMI ID for the most recent Amazon Linux 2 ami,* managed by AWS.*/ 
 
 data "aws_ssm_parameter" "linux2_ami" { 
 	# name = "/aws/service/ami-amazon-linux-latest/amzn-ami-hvm-x86_64-ebs" 
    name = "amazon/amzn2-ami-kernel-5.10-hvm-2.0.20230912.0-x86_64-gp2"
} 

/*** Launch a bastion instance we can use to gain access to the private subnets of* this availabilty zone.*/ 

resource "aws_instance" "bastion" { 
	ami           = data.aws_ssm_parameter.linux2_ami.value 
    key_name      = aws_key_pair.bastion.key_name 
    instance_type = var.instance_type 
    associate_public_ip_address = true 
    # subnet_id                   = element(aws_subnet.public_subnets, 0).id 
    subnet_id = element(module.network-module.public_subnets, 0).id
    vpc_security_group_ids      = [aws_security_group.bastion.id] 
    
    tags = { 
    	Name        = "bastion-server" 
    } 
} 