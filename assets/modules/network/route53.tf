data "aws_route53_zone" "imminentconcepts" {
  name = "imminentconcepts.net"
}

resource "aws_route53_record" "jenkins" {
  zone_id = data.aws_route53_zone.imminentconcepts.zone_id
  name    = "jenkins"
  type    = "A"

  alias {
    name                   = aws_lb.jenkins.dns_name
    zone_id                = aws_lb.jenkins.zone_id
    evaluate_target_health = true
  }
}
