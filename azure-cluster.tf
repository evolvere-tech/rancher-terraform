# Create a new rancher2 Node Template from Rancher 2.2.x
resource "rancher2_cloud_credential" "azure" {
  name = "azure"
  description = "azure API credential"
  azure_credential_config {
    client_id = ""
    client_secret = ""
    subscription_id = ""
  }
}
resource "rancher2_node_template" "azure-ctrl" {
  name = "azure-ctrl"
  description = "azure control plane node template"
  cloud_credential_id = "${rancher2_cloud_credential.azure.id}"
  engine_install_url = ""
  engine_insecure_registry = [""]
  azure_config {
      disk_size     = ""
      memory_size   = ""
      image         = "canonical:UbuntuServer:18.04-LTS:latest"
      location      = "uksouth"
      no_public_ip  = true
      resource_group = ""
      size          = ""
      subnet        = ""
      vnet          = ""

  }
} 

resource "rancher2_node_template" "azure-wrkr" {
  name = "azure-wrkr"
  description = "azure worker node template"
  cloud_credential_id = "${rancher2_cloud_credential.azure.id}"
  engine_install_url = ""
  engine_insecure_registry = [""]
  azure_config {
      disk_size     = ""
      memory_size   = ""
      image         = "canonical:UbuntuServer:18.04-LTS:latest"
      location      = "uksouth"
      no_public_ip  = true
      resource_group = ""
      size          = ""
      subnet        = ""
      vnet          = ""

  }
}

# Create a new rancher2 RKE Cluster from template
resource "rancher2_cluster" "azure-tftest" {
  name = "azure-tf-test"
  cluster_template_id = "${rancher2_cluster_template.azure_default.id}"
  cluster_template_revision_id = "${rancher2_cluster_template.azure_default.template_revisions.0.id}"
}
resource "rancher2_node_pool" "azure-tftest-ctrl" {
  cluster_id =  "${rancher2_cluster.azure-tftest.id}"
  name = "azure-tftest-ctrl"
  hostname_prefix =  "azure-tftest-ctrl-0"
  node_template_id = "${rancher2_node_template.azure-ctrl-ctrl.id}"
  quantity = 3
  control_plane = true
  etcd = true
  worker = false
}

resource "rancher2_node_pool" "azure-tftest-wrkr" {
  cluster_id =  "${rancher2_cluster.azure-tftest.id}"
  name = "azure-tftest-wrkr"
  hostname_prefix =  "azure-tftest-wrkr-0"
  node_template_id = "${rancher2_node_template.azure-wrkr-ctrl.id}"
  quantity = 3
  control_plane = false
  etcd = false
  worker = false
}

