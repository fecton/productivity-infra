resource "kubernetes_namespace" "productivity_infra" {
  metadata {
    name = var.namespace
  }
}
