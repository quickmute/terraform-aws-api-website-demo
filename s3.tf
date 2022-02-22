resource "aws_s3_bucket" "example" {
  bucket = var.bucketname
  tags = {
    Name = var.bucketname
  }
}

## 4.0.0 code
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.example.bucket

  index_document {
    suffix = "myCalc.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "allow_from_my_machine" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.example.arn}/*"
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"

      values = [
        var.myip
      ]
    }

  }
}

resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.example.id
  policy = data.aws_iam_policy_document.allow_from_my_machine.json
}

## Existing files shall be overwritten
resource "local_file" "foo" {
  content  = <<EOF
window._config = {
    api: {
        invokeUrl: "${local.invoke_url}"
    }
};
EOF
  filename = "${path.module}/s3/js/config.js"
}

locals {
  s3_path = "${path.module}/s3"
}

##4.0.0
resource "aws_s3_object" "object" {
  for_each = fileset(local.s3_path, "**")
  bucket   = aws_s3_bucket.example.id
  key      = each.key
  source   = join("/", [local.s3_path, each.key])
  etag     = filemd5(join("/", [local.s3_path, each.key]))
}