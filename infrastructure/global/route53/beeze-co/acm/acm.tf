module "beeze-co-acm" {
  source  = "terraform-aws-modules/acm/aws"

  domain_name = var.zone_name
  zone_id     = var.zone_id

  subject_alternative_names = [
    "*.${var.zone_name}"
  ]

  wait_for_validation = true

  tags = {
    Name =  var.zone_name
  }
}
