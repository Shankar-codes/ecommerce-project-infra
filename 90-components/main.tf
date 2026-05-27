module "components" {
  for_each = var.components
  source = "git::https://github.com/Shankar-codes/terraform-ecommerce-component-module.git?ref=main"
  component = each.key
  rule_priority = each.value.rule_priority

  project_name  = var.project_name
  environment   = var.environment
  domain_name   = var.domain_name
}