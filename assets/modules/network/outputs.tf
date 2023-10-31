 output "load_balancer_dns" { 
 	value = aws_elb.jenkins_elb.dns_name 
 }