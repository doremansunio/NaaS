terraform {
  required_providers {
    rafay = {
      source = "RafaySystems/rafay"
      version = "1.1.22"
    }
  }
}

provider "rafay" {
  # provider_config_file = "./rafay_config.json"
}

resource "rafay_namespace" "tfdemonamespace01" {
  metadata {
    name    = var.namespace_name
    project = var.project_name
    labels = {
      "project-name" = "${var.project_name}"
      "cluster-name" = "${var.cluster_name}"
    }
  }
  spec {
    drift {
      enabled = false
    }
    placement {    
      labels {
        key   = "rafay.dev/clusterName"
        value = var.cluster_name
      }
    }

    resource_quotas {
      cpu_requests = "1000m"
      memory_requests = "1024Mi"
      cpu_limits = "2000m"
      memory_limits = "2048Mi"
      config_maps = "5"
      persistent_volume_claims = "2"
      services = "10"
      pods = "20"
      replication_controllers = "4"
      services_load_balancers = "4"
      services_node_ports = "4"
      storage_requests = "10Gi"      
    }

    limit_range {
      pod {
        max {
          cpu  = "500m"
          memory = "128Mi"
        }
        min {
          cpu  = "250m"
          memory = "64Mi"
        }
        ratio {
          cpu    = 1
          memory = 1
        }
      }
      container {
        default {
          cpu  = "250m"
          memory = "64Mi"
        }
        default_request {
          cpu  = "250m"
          memory = "64Mi"
        }

        max {
          cpu  = "500m"
          memory = "128Mi"
        }
        min {
          cpu  = "250m"
          memory = "64Mi"
        }
        ratio {
          cpu    = 1
          memory = 1
        }
      }
    }

  network_policy_params {
    network_policy_enabled = true
    policies {
        name    = var.ns-within-ws-policy
        version = var.ns-within-ws-policy-version
      }
    }
  }
}

resource "rafay_group" "group" {
  depends_on = [rafay_namespace.tfdemonamespace01]
  name        = "NsAdmin-grp-${var.project_name}-${var.namespace_name}"
}

resource "rafay_groupassociation" "nsgroupassociation" {
  depends_on = [rafay_group.group]
  project = "${var.project_name}"
  group = rafay_group.group.name
  namespaces = ["${var.namespace_name}"]
  roles = ["NAMESPACE_ADMIN"]
  #add_users = ["${var.namespace_admins}"]  
  add_users = var.namespace_admins
}