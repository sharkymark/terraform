terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "unix:///Users/${var.user_name}/.colima/default/docker.sock"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name
  ports {
    internal = 80
    external = 8000
  }
}

output "container_id" {
  description = "The ID of the Docker container"
  value       = docker_container.nginx.id
}

output "container_name" {
  description = "The name of the Docker container"
  value       = docker_container.nginx.name
}
output "container_image" {
  description = "The image used by the Docker container"
  value       = docker_container.nginx.image
}
output "container_ports" {
  description = "The ports exposed by the Docker container"
  value       = docker_container.nginx.ports
}
