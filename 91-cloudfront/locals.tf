locals {
  cdn_certificate_arn = data.aws_ssm_parameter.certificate_arn.value
  caching_disabled_id = data.aws_cloudfront_cache_policy.cachingDisabled.id
  caching_optimized_id = data.aws_cloudfront_cache_policy.cachingOptimised.id
}
