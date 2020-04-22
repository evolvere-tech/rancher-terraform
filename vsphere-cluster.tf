# Create a new rancher2 Node Template from Rancher 2.2.x
resource "rancher2_cloud_credential" "vsphere" {
  name = "vsphere"
  description = "vsphere API credential"
  vsphere_credential_config {
      username = ""
      password = ""
      vcenter = ""
      vcenter_port = "443"
  }
}
resource "rancher2_node_template" "vsphere-ctrl" {
  name = "vsphere-ctrl"
  description = "vsphere control plane node template"
  cloud_credential_id = "${rancher2_cloud_credential.vsphere.id}"
  engine_install_url = ""
  engine_insecure_registry = [""]
  vsphere_config {
      clone_from    = ""
      cloud_config  = ""
      cpu_count     = ""
      datacenter    = ""
      datastore     = ""
      datastore_cluster = ""
      disk_size     = ""
      folder        = ""
      memory_size   = ""
      network       = []
      pool          = ""


  }
} 

resource "rancher2_node_template" "vsphere-wrkr" {
  name = "vsphere-wrkr"
  description = "vsphere control plane node template"
  cloud_credential_id = "${rancher2_cloud_credential.vsphere.id}"
  engine_install_url = ""
  engine_insecure_registry = [""]
  vsphere_config {
      clone_from    = ""
      cloud_config  = ""
      cpu_count     = ""
      datacenter    = ""
      datastore     = ""
      datastore_cluster = ""
      disk_size     = ""
      folder        = ""
      memory_size   = ""
      network       = []
      pool          = ""


  }
} 

# Create a new rancher2 RKE Cluster from template
resource "rancher2_cluster" "vsphere-tftest" {
  name = "vsphere-tf-test"
  cluster_template_id = "${rancher2_cluster_template.vsphere_default.id}"
  cluster_template_revision_id = "${rancher2_cluster_template.vsphere_default.template_revisions.0.id}"
}
resource "rancher2_node_pool" "vsphere-tftest-ctrl" {
  cluster_id =  "${rancher2_cluster.vsphere-tftest.id}"
  name = "vsphere-tftest-ctrl"
  hostname_prefix =  "vsphere-tftest-ctrl-0"
  node_template_id = "${rancher2_node_template.vsphere-ctrl.id}"
  quantity = 3
  control_plane = true
  etcd = true
  worker = false
}

resource "rancher2_node_pool" "vsphere-tftest-wrkr" {
  cluster_id =  "${rancher2_cluster.vsphere-tftest.id}"
  name = "vsphere-tftest-wrkr"
  hostname_prefix =  "vsphere-tftest-wrkr-0"
  node_template_id = "${rancher2_node_template.vsphere-ctrl.id}"
  quantity = 3
  control_plane = false
  etcd = false
  worker = false
}

