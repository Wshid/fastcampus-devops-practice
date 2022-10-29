# config_file 만 지정
# 보통 해당 yaml내에 내용 지정
variable "config_file" {
  description = "The path of configuration YAML file."
  type        = string
  default     = "./config.yaml"
}
