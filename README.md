# terraform-aws-api-website-demo
A demo terraform solution for S3-APIGW-Lambda. 

This demo will create S3 bucket and configure it as a website to host your static website. There is a code that will reach out to your API Gateway that has been configured to reach into Lambda function. The Lambda function will simple return a square of the number you provided in the website. 
For additional information, review the code.

# Caution
This demo generates actual live content. You must provide your own IP address or range to test this site. You will incur cost for resources that this demo will create for you. 

# How to use
1. Go to Demo directory
2. Rename sample.auto.Xtfvars to sample.auto.tfvars (safeguard this file!)
3. Do terraform init
4. Do terraform plan/apply
5. Browse to the output website link
6. Run terraform destroy



