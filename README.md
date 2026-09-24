# terraform-aws-customer-gateway

Terraform module for a customer gateway — the AWS-side representation
of a remote VPN endpoint (on-premises hardware, or another cloud), for
[`terraform-aws-vpn-connection`](https://github.com/kn47ytv9mv/terraform-aws-vpn-connection)
to build a Site-to-Site VPN against.

## Cost

A customer gateway has no charge of its own — it is a static
description of a remote endpoint, not a running resource. Site-to-Site
VPN's per-connection-hour charge originates on the VPN connection
itself. See AWS's
[Site-to-Site VPN pricing](https://aws.amazon.com/vpn/pricing/) page
for current rates.

## Design

Requires exactly one of `bgp_asn` (a standard 2-byte ASN) or
`bgp_asn_extended` (a 4-byte ASN above 65534) — AWS rejects both or
neither. This module does not require the remote endpoint to actually
exist or respond: it is a plain AWS-side record, so `ip_address` can
name real, not-yet-provisioned, or even placeholder hardware without
affecting whether this resource itself creates successfully.

## Usage

```hcl
module "customer_gateway" {
  source = "kn47ytv9mv/customer-gateway/aws"

  ip_address = "203.0.113.1"
  bgp_asn    = "65000"
}
```

Or directly from this repository:

```hcl
module "customer_gateway" {
  source = "github.com/kn47ytv9mv/terraform-aws-customer-gateway"

  ip_address  = "203.0.113.1"
  bgp_asn     = "65000"
  device_name = "on-prem-router"
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.9 |
| aws | ~> 6.61 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| bgp_asn | BGP ASN of the customer gateway device. Mutually exclusive with bgp_asn_extended (use bgp_asn_extended for a 4-byte ASN above 65534). | `null` | no |
| bgp_asn_extended | 4-byte BGP ASN of the customer gateway device, for an ASN above 65534. Mutually exclusive with bgp_asn. | `null` | no |
| ip_address | Public IP address of the customer gateway device. | `null` | no |
| type | VPN connection type this gateway supports. AWS currently only accepts 'ipsec.1'. | `"ipsec.1"` | no |
| device_name | A name for the customer gateway device, for reference only. | `null` | no |
| certificate_arn | ARN of an ACM Private CA certificate, for certificate-based authentication instead of a pre-shared key. | `null` | no |
| tags | A map of tags to assign to the customer gateway. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The ID of the customer gateway. |
| arn | The ARN of the customer gateway. |

## License

MIT — see [LICENSE.md](LICENSE.md).
