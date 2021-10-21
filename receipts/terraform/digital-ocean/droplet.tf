# Create a droplet

variable "domain" {}

resource "digitalocean_droplet" "mail" {
  image     = "debian-11-x64"
  name      = "mail.${var.domain}"
  region    = "lon1"
  size      = "s-1vcpu-1gb-intel"
  user_data = file("userdata.yaml")
  ssh_keys  = ["${digitalocean_ssh_key.mail.fingerprint}"]
}