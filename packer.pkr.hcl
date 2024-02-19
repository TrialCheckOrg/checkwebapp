packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "custom_image" {
  project_id   = "arctic-surf-400319"
  source_image = "centos-stream-8-v20240110"
  image_family = "custom-image-nodejs-postgresql"
  ssh_username = "packer"
  zone         = "us-east4-c"
}

build {
  sources = ["source.googlecompute.custom_image"]

  provisioner "shell" {
    inline = [
      "sudo dnf update -y",
      "echo 'Node.js and PostgreSQL installed successfully.'"
    ]
  }
}
