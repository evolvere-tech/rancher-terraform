provider "rancher2" {
  api_url    = "https://rancher.example.com"
  access_key = "token"
  secret_key = "secret"
}

# Create a new Rancher2 Project Alert Group
resource "rancher2_project_alert_group" "robbietherobot" {
  name = "robbietherobot"
  description = "robbietherobot Alert Group"
  project_id = "cluster:project"
  group_interval_seconds = 60
  repeat_interval_seconds = 3600
  recipients {
        notifier_id = "cluster:notifier"
  }
}
# Create a new Rancher2 Project Alert Rule
resource "rancher2_project_alert_rule" "robbietherobot_deployment_down" {
  project_id = rancher2_project_alert_group.robbietherobot.project_id
  group_id = rancher2_project_alert_group.robbietherobot.id
  name = "robbietherobot Deployment Down"
  workload_rule {
        available_percentage = 100
        workload_id = "deployment:younamespace:robbietherobot"
}

}
