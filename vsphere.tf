  # rancher2_cluster_template.foo will be created
  resource "rancher2_cluster_template" "vsphere_default" {
      description         = "Terraform cluster template vsphere_default"
      name                = "vsphere_default"

      template_revisions {
          default             = true
          enabled             = true
          name                = "V1"

          cluster_config {
              enable_cluster_alerting                  = false
              enable_cluster_monitoring                = false
              enable_network_policy                    = false
              windows_prefered_cluster                 = false

              cluster_auth_endpoint {
                  enabled  = true
              }

              rke_config {
                  cloud_provider {
                      name                  = "vsphere"
                      vsphere_cloud_provider {
                          global {
                              datacenters          = "evodc01"
                              insecure_flag        = true
                              password             = ""
                              user                 = ""
                          }

                          virtual_center {
                              datacenters          = "evodc01"
                              name                 = "10.9.100.50"
                              password             = ""
                              user                 = ""
                          }

                          workspace {
                              datacenter        = "evodc01"
                              default_datastore = "evonas01"
                              folder            = "vm/"
                              server            = "10.9.100.50"
                          }
                        }
                    }

                  network {
                      plugin  = "canal"
                  }

                  services {
                      etcd {
                          backup_config {
                              enabled        = true
                              interval_hours = 12
                              retention      = 6
                            }
                        }

                      kube_api {
                          service_cluster_ip_range = "10.110.0.0/20"
                      }

                      kube_controller {
                          cluster_cidr             = "10.110.16.0/20"
                          service_cluster_ip_range = "10.110.0.0/20"
                        }

                      kubelet {
                          cluster_dns_server           = "10.110.0.10" 
                      }
                  }

                  upgrade_strategy {
                      drain                        = true
                      max_unavailable_controlplane = 1
                      max_unavailable_worker       = "10%"
                  }
              }

              scheduled_cluster_scan {
                  enabled = false

                  scan_config {
                      cis_scan_config {
                          debug_master = true
                          debug_worker = true
                          profile      = "permissive"
                        }
                    }

                  schedule_config {
                      cron_schedule = "30 * * * *"
                      retention     = 5
                    }
              }
          }
      }
  }

