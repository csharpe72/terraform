resource "aws_lb_target_group" "jenkins" {
  name       = "jenkins-lb"
  port       = 8080
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  slow_start = 0

  load_balancing_algorithm_type = "round_robin"

  stickiness {
    enabled = true
    type    = "lb_cookie"
  }

  health_check {
    enabled             = true
    port                = 8080
    interval            = 30
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "jenkins" {
  for_each = var.ec2_instance_ids
    target_group_arn = aws_lb_target_group.jenkins.arn
    target_id = each.value
    port = 8080
}
