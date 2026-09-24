variable "bgp_asn" {
  default     = null
  description = "BGP ASN of the customer gateway device. Mutually exclusive with bgp_asn_extended (use bgp_asn_extended for a 4-byte ASN above 65534)."
}

variable "bgp_asn_extended" {
  default     = null
  description = "4-byte BGP ASN of the customer gateway device, for an ASN above 65534. Mutually exclusive with bgp_asn."

  validation {
    condition     = (var.bgp_asn != null) != (var.bgp_asn_extended != null)
    error_message = "Exactly one of bgp_asn or bgp_asn_extended is required."
  }
}

variable "ip_address" {
  default     = null
  description = "Public IP address of the customer gateway device."
}

variable "type" {
  default     = "ipsec.1"
  description = "VPN connection type this gateway supports. AWS currently only accepts 'ipsec.1'."
}

variable "device_name" {
  default     = null
  description = "A name for the customer gateway device, for reference only."
}

variable "certificate_arn" {
  default     = null
  description = "ARN of an ACM Private CA certificate, for certificate-based authentication instead of a pre-shared key."
}

variable "tags" {
  default     = null
  description = "A map of tags to assign to the customer gateway."
}
