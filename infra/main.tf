terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}




####--------------------------------  CERTIFICADO DIGITAL  ------------------------------------####
####        CRIAÇAO DO CERTIFICADO PARA CONEXÃO HTTPS AO SITE ESTÁTICO         ####
resource "aws_acm_certificate" "marceladaguercom" {
  domain_name       = "marceladaguer.com"
  validation_method = "DNS"

  tags = {
    Environment = "Production"
    Purpose     = "Certificado para o site marceladaguer.com"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Configuração do DNS no Route 53 para validação do certificado
data "aws_route53_zone" "marceladaguercom" {
  name         = "marceladaguer.com"
  private_zone = false
}

resource "aws_route53_record" "marceladaguercom" {
  for_each = {
    for dvo in aws_acm_certificate.marceladaguercom.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.marceladaguercom.zone_id
}

resource "aws_acm_certificate_validation" "marceladaguercom" {
  certificate_arn         = aws_acm_certificate.marceladaguercom.arn
  validation_record_fqdns = [for record in aws_route53_record.marceladaguercom : record.fqdn]
}



####--------------------------------  BUCKET S3  ----------------------------------------------####
####        CRIAÇAO DO BUCKET S3 PARA ARMAZENAR O SITE ESTÁTICO               ####
resource "aws_s3_bucket" "websitemarceladaguerS3" {
  bucket = "frontend-website-marceladaguer"

  tags = {
    Name        = "WebSite Marcela Daguer"
    Environment = "Production"
    Purpose     = "Bucket S3 para o site marceladaguer.com"
  }
}

####        CONFIGURAÇÃO DO BUCKET S3 PARA SER PRIVADO (SEM ACESSO PÚBLICO)   ####
resource "aws_s3_bucket_ownership_controls" "websitemarceladaguerS3" {
  bucket = aws_s3_bucket.websitemarceladaguerS3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "websitemarceladaguerS3" {
  depends_on = [aws_s3_bucket_ownership_controls.websitemarceladaguerS3]

  bucket = aws_s3_bucket.websitemarceladaguerS3.id
  acl    = "private"
}

####        CONFIGURAÇÃO DO BUCKET S3 PARA HOSPEDAR UM WEB SITE               ####
resource "aws_s3_bucket_website_configuration" "websitemarceladaguerS3" {
  bucket = aws_s3_bucket.websitemarceladaguerS3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}





####--------------------------------  CLOUDFRONT  ----------------------------------------------####
####        CONFIGURAÇÃO DO CLOUDFRONT CRIAÇÃO DE UM CONTROLE DE ORIGEM PARA BUCKET S3          ####
resource "aws_cloudfront_origin_access_control" "websitemarceladaguerS3origin" {
  name                              = aws_s3_bucket.websitemarceladaguerS3.bucket_regional_domain_name
  description                       = "Política para acesso ao bucket S3 a partir do CloudFront"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

####        CONFIGURAÇÃO DA DISTRIBUIÇAO DO CLOUDFRONT PARA CDN DO WEBSITE DE ORIGEM BUCKET S3  ####
resource "aws_cloudfront_distribution" "websitemarceladaguerS3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.websitemarceladaguerS3.bucket_regional_domain_name
    origin_id                = "myS3Origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.websitemarceladaguerS3origin.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  aliases = ["marceladaguer.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "myS3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    Environment = "Production"
    Purpose     = "Distribuição CLOUDFRONT para o site marceladaguer.com"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    acm_certificate_arn            = aws_acm_certificate.marceladaguercom.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2018"
  }
}


####        CONFIGURAÇÃO DO REGISTRO PARA O DOMINIO MARCELADAGUER.COM NO ROUTE 53     ####
resource "aws_route53_record" "cloudfront_alias" {
  zone_id = data.aws_route53_zone.marceladaguercom.zone_id
  name    = "marceladaguer.com"  # Substitua pelo nome do seu domínio
  type    = "A"

  alias {
    name    = aws_cloudfront_distribution.websitemarceladaguerS3_distribution.domain_name
    zone_id = aws_cloudfront_distribution.websitemarceladaguerS3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
