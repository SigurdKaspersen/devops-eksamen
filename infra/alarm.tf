module "alarm" {
  source      = "./alarm_module"
  alarm_email = var.alarm_email
  prefix      = "wishifai-${var.candidate_number}"
}