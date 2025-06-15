terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "flask"
  }
}

variable "deployment_enabled" {
  description = "Whether to create/re-create the Flask deployment"
  type        = bool
  default     = true
}

# Flask application deployment using DockerHub image
resource "kubernetes_deployment" "flask" {
  count = var.deployment_enabled ? 1 : 0
  metadata {
    name      = "flask"
    namespace = kubernetes_namespace.namespace.metadata[0].name
    labels = {
      app = "flask"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "flask"
      }
    }
    template {
      metadata {
        labels = {
          app = "flask"
        }
      }
      spec {
        container {
          name  = "flask"
          image = "marktmilligan/flask:latest"
          image_pull_policy = "Always"
          
          volume_mount {
            name       = "flask-storage"
            mount_path = "/app/instance"
          }

          port {
            container_port = 5000
          }
          
          env {
            name  = "FLASK_APP"
            value = "app.py"
          }
          
          env {
            name  = "FLASK_ENV"
            value = "production"
          }
          
          env {
            name  = "FLASK_RUN_HOST"
            value = "0.0.0.0"
          }
        }
        volume {
          name = "flask-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.flask_pvc.metadata[0].name
            read_only = false
          }
        }
      }
    }
  }
}

# Persistent volume claim for Flask database
resource "kubernetes_persistent_volume_claim" "flask_pvc" {
  metadata {
    name      = "flask-pvc"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  wait_until_bound = false
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

# Flask service to expose the application
resource "kubernetes_service" "flask" {
  metadata {
    name      = "flask"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  spec {
    selector = {
      app = "flask"
    }
    port {
      port        = 5000
      target_port = 5000
      node_port   = 30080
    }
    type = "NodePort"
  }
}
