resource "rancher2_notifier" "foo" {
  name = "foo"
  cluster_id = "<cluster_id>"
  description = "Terraform notifier acceptance test"
  send_resolved = "true"
  smtp_config {
    default_recipient = "XXXXXXXX@yyy.com"
    host = "smtpserver"
    port = 25
    sender = "rancher@example.com"
    username = "uname"
    password = "pword"
    tls = "false"
  }
}
