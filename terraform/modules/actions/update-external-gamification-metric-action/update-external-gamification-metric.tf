/*
  Creates the action
*/
resource "genesyscloud_integration_action" "action-3" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "agentId" = {
        "type" = "string"
      },
      "metricId" = {
        "type" = "string"
      },
      "date" = {
        "type" = "string"
      },
      "score" = {
        "type" = "integer"
      }
    }
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {}
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/employeeperformance/externalmetrics/data"
    request_type         = "POST"
    request_template     = "{\n   \"items\": [\n      {\n         \"userId\": \"$${input.agentId}\",\n         \"metricId\": \"$${input.metricId}\",\n         \"dateOccurred\": \"$${input.date}\",\n         \"value\": $${input.score},\n         \"type\": \"Total\"\n      }\n   ]\n}"
    headers = {}
  }
  config_response {
    translation_map = {}
    translation_map_defaults = {}
    success_template = "$${rawResult}"
  }
}
