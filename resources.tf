resource "aws_customer_gateway" "resource" {
  bgp_asn          = var.bgp_asn
  bgp_asn_extended = var.bgp_asn_extended
  ip_address       = var.ip_address
  type             = var.type
  device_name      = var.device_name
  certificate_arn  = var.certificate_arn
  tags             = var.tags
}

output "id" {
  description = "The ID of the customer gateway."
  value       = aws_customer_gateway.resource.id
}

output "arn" {
  description = "The ARN of the customer gateway."
  value       = aws_customer_gateway.resource.arn
}
