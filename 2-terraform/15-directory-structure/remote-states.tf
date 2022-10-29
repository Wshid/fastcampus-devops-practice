locals {
  remote_states = {
    "domain-zone" = data.terraform_remote_state.this["domain-zone"].outputs
  }
  domain_zones = local.remote_states["domain-zone"]
}


###################################################
# Terraform Remote States (External Dependencies)
###################################################

data "terraform_remote_state" "this" {
  # remote_states를 리스트로 가져와 활용
  for_each = local.config.remote_states

  backend = "remote"

  config = {
    organization = each.value.organization
    workspaces = {
      name = each.value.workspace
    }
  }
}
