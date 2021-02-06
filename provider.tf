provider "google" {
	region = "us-central1"
	credentials = file("/root/gcptf/keys.json")
	project = "dvproj-302117"
}
