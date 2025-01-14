resource "aws_s3_bucket" "static-online-site" {
  bucket = var.my_bucket_name
}

resource "aws_s3_bucket_ownership_controls" "static" {
  bucket = aws_s3_bucket.static-online-site.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.static-online-site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.static,
    aws_s3_bucket_public_access_block.public,
  ]
  bucket = aws_s3_bucket.static-online-site.id
  acl    = "public-read"
}


resource "aws_s3_bucket_policy" "allow-static" {
  bucket = aws_s3_bucket.static-online-site.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::{your-bucket-name}/*"
        ]
      }
    ]
    }
  )
}

module "template_files" {
  source   = "hashicorp/dir/template"
  base_dir = "${path.module}/website"
}

resource "aws_s3_bucket_website_configuration" "web-conf" {
  bucket = aws_s3_bucket.static-online-site.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "Bucket_files" {
  bucket = aws_s3_bucket.static-online-site.id

  for_each     = module.template_files.files
  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  content = each.value.content
}
