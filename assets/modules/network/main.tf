/***Load Balancer to be attached to the ECS cluster to distribute the load among instances*/

resource "aws_elb" "jenkins_elb" {
  subnets = var.public_subnet_id[public-subnet-1].id
  #subnets = [ for subnet in var.public_subnet_id[public-subnet-1] : subnet.id ]
  cross_zone_load_balancing = true
  security_groups           = var.lb_security_group_ids
  instances                 = [var.ec2_instance_ids]
  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 5
  }

  tags = merge(
    var.tags,
    {
      Name = "jenkins_elb"
    },
  )
}
