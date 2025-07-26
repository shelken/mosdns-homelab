target "docker-metadata-action" {}

variable "APP" {
  default = "mosdns"
}

variable "VERSION" {
  default = "test"
}

variable "SOURCE" {
  default = "https://github.com/shelken/mosdns-homelab"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}"
  }
  dockerfile = config_v5/Dockerfile
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
}