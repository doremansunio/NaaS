variable "project_name" {
  type = string
  default = "team-e"
}

variable "workspace_admins" {
  type    = list
  default = ["phani.kg@gmail.com"]
}

variable "cluster_name" {
  type = string
  default = "multi-eks1"
}

variable "main_cluster_project_name" {
  type = string
  default = "team-a"
}

variable "to_namespace_name" {
  type = string
  default = "ns1"
}

variable "from_namespace_name" {
  type = string
  default = "ns2"
}