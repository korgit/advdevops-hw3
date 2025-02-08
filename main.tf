terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}
provider "docker" {}

resource "docker_image" "hw_build" {
  name = "hw_build:latest"
  build {
    context = "."
    dockerfile = "Dockerfile"
  }
}
resource "docker_container" "hw_container" {
  name  = "hw_container"
  image = docker_image.hw_build.image_id
  ports {
    internal = 8082
    external = 8082
  }
}
