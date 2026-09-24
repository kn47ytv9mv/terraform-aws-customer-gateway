mock_provider "aws" {
}

run "rejects_neither_asn_variant" {
  command = plan

  variables {
    ip_address = "203.0.113.1"
  }

  expect_failures = [var.bgp_asn_extended]
}

run "rejects_both_asn_variants" {
  command = plan

  variables {
    ip_address       = "203.0.113.1"
    bgp_asn          = "65000"
    bgp_asn_extended = "4200000000"
  }

  expect_failures = [var.bgp_asn_extended]
}

run "standard_asn_passes_through" {
  command = plan

  variables {
    ip_address = "203.0.113.1"
    bgp_asn    = "65000"
  }

  assert {
    condition     = aws_customer_gateway.resource.ip_address == "203.0.113.1"
    error_message = "ip_address should pass through unchanged."
  }

  assert {
    condition     = aws_customer_gateway.resource.bgp_asn == "65000"
    error_message = "bgp_asn should pass through unchanged."
  }

  assert {
    condition     = aws_customer_gateway.resource.type == "ipsec.1"
    error_message = "type should default to 'ipsec.1'."
  }
}

run "extended_asn_passes_through" {
  command = plan

  variables {
    ip_address       = "203.0.113.1"
    bgp_asn_extended = "4200000000"
    device_name      = "on-prem-router"
  }

  assert {
    condition     = aws_customer_gateway.resource.bgp_asn_extended == "4200000000"
    error_message = "bgp_asn_extended should pass through unchanged."
  }

  assert {
    condition     = aws_customer_gateway.resource.device_name == "on-prem-router"
    error_message = "device_name should pass through unchanged."
  }
}

run "tags_pass_through" {
  command = plan

  variables {
    ip_address = "203.0.113.1"
    bgp_asn    = "65000"
    tags = {
      Name = "on-prem-router"
    }
  }

  assert {
    condition     = aws_customer_gateway.resource.tags.Name == "on-prem-router"
    error_message = "tags should pass through unchanged."
  }
}

run "readme_default_example" {
  command = plan

  variables {
    ip_address = "203.0.113.1"
    bgp_asn    = "65000"
  }
}

run "readme_named_device_example" {
  command = plan

  variables {
    ip_address  = "203.0.113.1"
    bgp_asn     = "65000"
    device_name = "on-prem-router"
  }
}
