# Export our SSH key

resource "digitalocean_ssh_key" "mail" {
  name       = "mail"
  public_key = "${file("id_rsa.pub")}"
}