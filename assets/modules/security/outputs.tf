output "bastion_security_group_ids" {
  value = aws_security_group.bastion.id
}

output "web_security_group_ids" {
  value = aws_security_group.web.id
}

output "lb_security_group_ids" {
  value = aws_security_group.lb.id
}
output "bastion_port" {
  value = local.bastion-sg
}

output "jenkins_ports" {
  value = {
    for k, v in local.jenkins-sg : k => v
  }
}

output "jenkins_ips" {
  value = {}
}
