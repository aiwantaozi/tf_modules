variable "name" {
  type        = string
  description = "(Required) App instance name"
}
variable "image" {
  type        = string
  description = "(Required) Docker image name"
}
variable "namespace" {
  type        = string
  description = "(Optional) namespace"
  default = "default"
}

# @group "Access"
# @options ["ClusterIP","NodePort","LoadBalancer","ExternalName"]
variable "service_type" {
  type        = string
  description = "(Optional) Service type determines how service is exposed"
  default = "ClusterIP"
}

# @group "Access"
variable "port" {
  type        = number
  description = "(Optional) Port the service is exposed"
  default = 80
}

# @group "Access"
variable "node_port" {
  type        = number
  description = "(Optional) Node Port. By default K8S automatically set free Node Port"
  default = 30000
}

# @group "Access"
variable "ingress_class_name" {
  type        = string
  description = "(Optional) Ingress Class name"
  default = "nginx"
}

# @group "Access"
variable "ingress_annotation" {
  type        = map(string)
  description = "(Optional) Custom annotations"
  default = {}
}

# @group "Resources"
# @label "CPU"
# @options ["0.5","1","2"]
variable "cpu" {
  type        = string
  description = "(Optional) CPU"
  default = "0.5"
}

# @group "Resources"
# @label "Memory"
# @options ["1Gi","2Gi","4Gi"]
variable "memory" {
  type        = string
  description = "(Optional) Memory"
  default = "512Mi"
}

variable "env" {
  type        = map(string)
  description = "(Optional) Name and value pairs to set as the environment variables"
  default     = {}
}
