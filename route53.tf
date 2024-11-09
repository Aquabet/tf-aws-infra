resource "aws_route53_record" "csye6225_record" {
  zone_id = var.aws_profile == "dev" ? var.dev_zone_id : var.demo_zone_id
  name    = "${var.aws_profile}.${var.domain_name}"
  type    = var.record_type
  alias {
    name                   = aws_lb.webapp_alb.dns_name
    zone_id                = aws_lb.webapp_alb.zone_id
    evaluate_target_health = true
  }
}
