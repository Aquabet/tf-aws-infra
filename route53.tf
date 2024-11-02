resource "aws_route53_record" "csye6225_record" {
  count   = length(var.aws_regions)
  zone_id = var.aws_profile == "dev" ? var.dev_zone_id : var.demo_zone_id
  name    = "${var.aws_profile}.${var.domain_name}"
  type    = var.record_type
  ttl     = var.ttl
  records = [aws_instance.webapp_instance[count.index].public_ip]
}
