variable "user_name" {
  type    = string
  default = "markmilligan"
}

variable "container_name" {

  description = "Name of the Docker container"
  type        = string
  default     = "nginx-container"
}