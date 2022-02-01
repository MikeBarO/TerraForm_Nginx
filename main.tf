#terraform docker integration
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container2" {
  name  = "nodered2"
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = 1882
  }
}

resource "docker_image" "apache_image" {
  name = "httpd:latest"
}

resource "docker_container" "apache_container" {
  name  = "apache"
  image = docker_image.apache_image.latest
  ports {
    internal = 80
    external = 1880
  }
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  #keep_locally = false
}

resource "docker_container" "nginx_container" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
