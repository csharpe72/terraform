# resource "aws_route53_zone" "primary" {
#   name = "imminentconcepts.net"
# }

# resource "aws_route53_record" "www" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "imminentconcepts.net"
#   type    = "A"

#   alias {
#     name                   = aws_elb.jenkins_elb.dns_name
#     zone_id                = aws_elb.jenkins_elb.zone_id
#     evaluate_target_health = true
#   }
# }

# resource "aws_route53_record" "ns" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "imminentconcepts.net"
#   type    = "NS"
#   ttl     = "30"
#   records = aws_route53_zone.primary.name_servers
# }


# resource "aws_route53_record" "soa" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "imminentconcepts.net"
#   type    = "SOA"
#   ttl     = 5
# }

