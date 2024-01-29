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

#Basic example for namespace
resource "rafay_namespace" "tfdemonamespace" {
  metadata {
    name    = var.to_namespace_name
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

    # resource_quotas {
    #   config_maps = "10"
    #   cpu_limits = "4000m"
    #   memory_limits = "4096Mi"
    #   cpu_requests = "2000m"
    #   memory_requests = "2048Mi"
    #   persistent_volume_claims = "2"
    #   pods = "30"
    #   replication_controllers = "5"
    #   services = "10"
    #   services_load_balancers = "10"
    #   services_node_ports = "10"
    #   storage_requests = "1Gi"
    # }

    # limit_range {
    #   pod {
    #     max {
    #       cpu  = "500m"
    #       memory = "128Mi"
    #     }
    #     min {
    #       cpu  = "250m"
    #       memory = "64Mi"
    #     }
    #     ratio {
    #       cpu    = 1
    #       memory = 1
    #     }
    #   }
    #   container {
    #     default {
    #       cpu  = "250m"
    #       memory = "64Mi"
    #     }
    #     default_request {
    #       cpu  = "250m"
    #       memory = "64Mi"
    #     }

    #     max {
    #       cpu  = "500m"
    #       memory = "128Mi"
    #     }
    #     min {
    #       cpu  = "250m"
    #       memory = "64Mi"
    #     }
    #     ratio {
    #       cpu    = 1
    #       memory = 1
    #     }
    #   }
    # }
  }
}

resource "rafay_namespace" "tfdemonamespace1" {  
  metadata {    
    name    = var.from_namespace_name
    project = var.project_name
    labels = {
      "project-name" = "${var.project_name}"
      "cluster-name" ="${var.cluster_name}"
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
  }
}

resource "rafay_namespace" "tfdemonamespace23" {  
  metadata {    
    name    = "ns5"
    project = var.project_name
    labels = {      
      "cluster-name" ="${var.cluster_name}"
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
  }
}