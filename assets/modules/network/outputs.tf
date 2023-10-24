 output "load_balancer_ip" { 
 	value = aws_elb.jenkins_elb.dns_name 
 }