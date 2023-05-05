/*
  Creates the action
*/
resource "genesyscloud_integration_action" "action-2" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "datatableid" = {
        "type" = "string"
      },
      "key" = {
        "type" = "string"
      },
      "score" = {
        "type" = "integer"
      }
    }
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {
      "key" = {
        "type" = "string"
      },
      "score" = {
        "type" = "integer"
      }
    }
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/flows/datatables/$${input.datatableid}/rows/$${input.key}"
    request_type         = "PUT"
    request_template     = "{\n  \"Score\": $${input.score},\n  \"key\": \"$${input.key}\"\n}"
    headers = {
      "Content-Type": "application/json"
    }
  }
  config_response {
    translation_map = {
      score   = "$.['Score']",
      key   = "$.key"
    }
    translation_map_defaults = {}
    success_template = "{\"key\": $${key},\"score\": $${score}}"
  }
}
