resource "aws_lb" "frontend_alb" {
  name               = "${var.project_name}-frontend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.frontend_alb_sg_id]
  subnets            = local.public_subnet_ids

  #enable_deletion_protection = true

  tags = merge(local.common_tags, {
    Name = "${local.common_name_suffix}-frontend-alb"
  })
}


resource "aws_lb_listener" "frontend_alb" {
  load_balancer_arn = aws_lb.frontend_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.frontend_alb_certificate_arn

    default_action {
        type = "fixed-response"

        fixed_response {
        content_type = "text/html"
        message_body = "<h1>Welcome to the Frontend ALB</h1>"
        status_code  = "200"
        }
    }
}

resource "aws_route53_record" "frontend_alb" {
  zone_id = var.zone_id
  name    = "roboshop.${var.domain_name}" #roboshop.ellamma.fun
  type    = "A"
  
  # these are details of aws alb
  alias {
    name                   = aws_lb.frontend_alb.dns_name
    zone_id                = aws_lb.frontend_alb.zone_id
    evaluate_target_health = true
  }
  
}