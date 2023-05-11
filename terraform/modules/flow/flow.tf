resource "genesyscloud_flow" "inbound_call_flow" {
  filepath = "${path.module}/agent-rewards.yaml"
  file_content_hash = filesha256("${path.module}/agent-rewards.yaml")
  substitutions = {
    flow_name               = "Agent Rewards"
    division                = "Home"
    default_language        = "en-us"
    data_action_category    = var.data_action_category
    data_action_name_1      = var.data_action_name_1
    data_action_name_2      = var.data_action_name_2
    data_action_name_3      = var.data_action_name_3
    data_table              = var.data_table_name
    data_table_id           = var.data_table_id
    metric_id               = var.metric_id
  }
}