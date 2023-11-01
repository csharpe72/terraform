data "aws_route53_zone" "imminentconcepts" {
  name = "imminentconcepts.net"
}

resource "aws_route53_record" "jenkins" {
  zone_id = data.aws_route53_zone.imminentconcepts.zone_id
  name    = "jenkins"
  type    = "A"

  alias {
    name                   = aws_elb.jenkins_elb.dns_name
    zone_id                = aws_elb.jenkins_elb.zone_id
    evaluate_target_health = true
  }
}
