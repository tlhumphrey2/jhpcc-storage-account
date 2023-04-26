locals {
  all_tags     = merge(module.metadata.tags, {"owner": "Timothy L Humphrey", "owner_email": "timothy.humphrey@lexisnexisrisk.com" })
}
