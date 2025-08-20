resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16" # range that is large enough and doesn't clash with other vpc/external networks
    
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "${local.env}-main"
    }
}