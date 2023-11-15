/***Load Balancer to be attached to the ECS cluster to distribute the load among instances*/

# resource "aws_elb" "jenkins_elb" {
#   subnets                   = values(var.public_subnet_id)
#   cross_zone_load_balancing = true
#   security_groups           = var.lb_security_group_ids
#   instances                 = values(var.ec2_instance_ids)
#   listener {
#     instance_port     = 8080
#     instance_protocol = "http"
#     lb_port           = 80
#     lb_protocol       = "http"
#   }

#   health_check {
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 3
#     target              = "TCP:8080"
#     interval            = 5
#   }

#   tags = merge(
#     var.tags,
#     {
#       Name = "jenkins_elb"
#     },
#   )
# }

resource "aws_lb" "jenkins" {
  name               = "jenkins"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_security_group_ids

  subnets = values(var.public_subnet_id)

  #   access_logs {
  #     bucket = ""
  #     prefix = ""
  #     enabled = true
  #   }

  tags = merge(
    var.tags,
    {
      Name = "aws_lb.jenkins_elb"
    },
  )
}

resource "aws_lb_listener" "jenkins" {
  load_balancer_arn = aws_lb.jenkins.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins.arn
  }
}
