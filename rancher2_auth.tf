variable "rancher2_access_key" {
}
variable "rancher2_secret_key" {
}
provider "rancher2" {
  api_url    = "https://rancher.evolvere-tech.com"
  access_key = var.rancher2_access_key
  secret_key = var.rancher2_secret_key
  insecure = true
}
