resource "aws_lb" "backend_alb" {
  name               = "${local.common_name_suffix}-backend-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [local.backend_alb_sg_id]
  subnets            = local.private_subnet_ids

  #enable_deletion_protection = true

  tags = merge(local.common_tags, {
    Name = "${local.common_name_suffix}-backend-alb"
  })
}

#backend load balancer listener
resource "aws_lb_listener" "back_end" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

# creating R53 record for backend ALB backend-alb.ellamma.fun
resource "aws_route53_record" "backend_alb" {
  zone_id = var.zone_id
  name    = "*.backend-alb.${var.domain_name}" #backend-alb.ellamma.fun
  type    = "A"
  
  # these are details of aws alb
  alias {
    name                   = aws_lb.backend_alb.dns_name
    zone_id                = aws_lb.backend_alb.zone_id
    evaluate_target_health = true
  }
  
}