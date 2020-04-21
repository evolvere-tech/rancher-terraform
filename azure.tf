
  # rancher2_cluster_template.foo will be created
  resource "rancher2_cluster_template" "azure_default" {
      name                = "azure_default"
      description         = "Terraform cluster template azure_default"

      template_revisions {
          default             = true
          enabled             = true
          name                = "V1"

          cluster_config {
              cluster_auth_endpoint {
                  enabled  = true
                }

              rke_config {
                  ignore_docker_version = true

                  cloud_provider {
                      name                  = "azure"

                      azure_cloud_provider {
                          aad_client_id			   = ""
                          aad_client_secret		   = ""
                          location                         = "UKST"
                          resource_group                   = ""
                          subnet_name                      = ""
                          subscription_id                  = ""
                          tenant_id                        = ""
                          vnet_name                        = ""
                          vnet_resource_group              = ""
                        }

                    }

                  network {
                      plugin  = "canal"
                    }

                  services {
                      etcd {
                          retention  = "24h"

                          backup_config {
                              enabled        = true
                              interval_hours = 12
                              retention      = 6
                            }
                        }

                      kube_api {
                          service_cluster_ip_range = "10.110.16.0/20"
                        }

                      kube_controller {
                          cluster_cidr             = "10.110.0.0/20"
                          service_cluster_ip_range = "10.110.16.0/20"
                        }

                      kubelet {
                          cluster_dns_server           = "10.110.16.0.10"
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
