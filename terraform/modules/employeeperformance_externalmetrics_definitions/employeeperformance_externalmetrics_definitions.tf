/*
  Creates the external metric
*/
resource "genesyscloud_employeeperformance_externalmetrics_definitions" "externalmetrics_definition" {
  name                   = "Agent Rewards"
  precision              = 0
  default_objective_type = "HigherIsBetter"
  enabled                = true
  unit                   = "Number"
}
