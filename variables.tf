variable "image" {
	type = string
	default = "centos-cloud/centos-7"
}

variable "zone" {
	type = string
	default = "us-central1-b"
}

variable "machine_type" {
	description = "Enter your machine type"
	type = string
}
variable "ports" {
	type = list
	default = ["22","80","8080","1000-2000"]
}
variable "metadata" {
	type = map
	default = {
	env = "dev"
	app = "web"
}
}
variable "mcount" {
	type = string
}
