module "deployment" {
  source  = "terraform-iaac/deployment/kubernetes"
  version = "1.4.2"

  name      = var.name
  namespace = var.namespace
  image     = var.image
  resources = {
    request_cpu = var.cpu
    limit_cpu = var.cpu
    request_memory = var.memory
    limit_memory = var.memory
  }
  env = var.env
}

module "service" {
  source  = "terraform-iaac/service/kubernetes"
  version = "1.0.4"

  app_name      = var.name
  app_namespace = var.namespace
  type = var.service_type
  port_mapping     = [
    {
      name          = "web-access" // (Required) Port name
      internal_port = var.port         // (Required) Pod port
      external_port = var.port         // (Required) Port for others container's
      node_port     = var.node_port      // (Optional) set Node Port. By default K8S automatically set free Node Port
    }
  ]
}

resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name        = var.name
    namespace   = var.namespace
    annotations = var.ingress_annotation
  }
  spec {
    ingress_class_name = var.ingress_class_name
    rule {
      http {
        path {
          path = "/"
          backend {
            service {
              name = var.name
              port {
                number = var.port
              }
            }
          }
        }
      }
    } 
  }
}

data "kubernetes_service" "service" {
  depends_on = [module.service]
  metadata {
    name = var.name
    namespace = var.namespace
  }
}