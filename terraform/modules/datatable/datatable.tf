/*
  Creates the datatable
*/
resource "genesyscloud_architect_datatable" "agent_score" {
  name        = "Agent Rewards Table"
  description = "Agent score for rewards"
  properties {
    name  = "key"
    type  = "string"
    title = "agentID"
  }
  properties {
    name  = "Score"
    type  = "integer"
    title = "Score"
  }
}
