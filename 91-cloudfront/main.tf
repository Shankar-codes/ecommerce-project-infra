resource "aws_cloudfront_distribution" "roboshop" {
  origin {
    # roboshop.ellamma.fun
    domain_name              = "roboshop.${var.domain_name}"
    origin_id                = "roboshop.${var.domain_name}"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true

  #dev.ellamma.fun
  aliases = ["${var.environment}.${var.domain_name}"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "roboshop.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id         = local.caching_disabled_id # CachingDisabled
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "roboshop.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id         = local.caching_optimized_id # CachingOptimized
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/media/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "roboshop.${var.domain_name}"

    viewer_protocol_policy = "https-only"
    cache_policy_id         = local.caching_optimized_id # CachingOptimized
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "IN", "GB", "DE"]
    }
  }


  viewer_certificate {
    acm_certificate_arn = local.cdn_certificate_arn
    ssl_support_method  = "sni-only"
  }
}


resource "aws_route53_record" "cdn" {
  zone_id = var.zone_id
  name    = "${var.environment}.${var.domain_name}" # dev.ellamma.fun
  type    = "A"
  allow_overwrite = true

  alias {
    name                   = aws_cloudfront_distribution.roboshop.domain_name
    zone_id                = aws_cloudfront_distribution.roboshop.hosted_zone_id
    evaluate_target_health = true
  }
}