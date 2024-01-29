resource "rafay_namespace" "tfdemonamespace3" {  
  metadata {    
    name    = "ns4"
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