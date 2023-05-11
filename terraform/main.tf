/*
  Create a Data Action integration
*/
module "data_action" {
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "Agent Rewards Data Action"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
}

/*
  Create a Get Agent ID Data Action
*/
module "get_agent_id_data_action" {
  source             = "./modules/actions/get-agent-id-action"
  action_name        = "Get Agent ID"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

/*
  Create an Update Data Table Data Action
*/
module "update_data_table_data_action" {
  source             = "./modules/actions/update-data-table-action"
  action_name        = "Update Data Table"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

/*
  Create an Update External Gamification Metric Data Action
*/
module "update_external_gamification_metric_action" {
  source             = "./modules/actions/update-external-gamification-metric-action"
  action_name        = "Update Gamification External Metric"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

/*
  Create an External Metric Definition
*/
module "employeeperformance_externalmetrics_definitions" {
  source             = "./modules/employeeperformance_externalmetrics_definitions"
}

/*
  Create a Data Table
*/
module "data_table" {
  source             = "./modules/datatable"
}

/*   
   Configures the architect inbound call flow
*/
module "archy_flow" {
  source                = "./modules/flow"
  data_action_category  = module.data_action.integration_name
  data_action_name_1      = module.get_agent_id_data_action.action_name
  data_action_name_2      = module.update_data_table_data_action.action_name
  data_action_name_3      = module.update_external_gamification_metric_action.action_name
  data_table_name         = module.data_table.datatable_name
  data_table_id           = module.data_table.datatable_id
  metric_id               = module.employeeperformance_externalmetrics_definitions.metric_id
}
