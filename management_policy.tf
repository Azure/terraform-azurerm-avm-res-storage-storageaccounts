# resource "azurerm_storage_management_policy" "this" {
#   storage_account_id = azurerm_storage_account.this.id

#   dynamic "rule" {
#     for_each = var.management_policy.rule
#     content {
#       name = rule.value.name
#       enabled = rule.value.enabled

#       dynamic "filters" {
#         for_each = try(rule.value.filters, {})
#         content {
#           prefix_match = try(filters.value.prefix_match, null)
#           blob_types   = try(filters.value.blob_types, null)
#         }

#       }
#       dynamic "match_blob_index_tags" {
#         for_each = try(rule.value.match_blob_index_tags, {})
#         content {
#           name      = try(match_blob_index_tags.value.name, null)
#           value     = try(match_blob_index_tags.value.value, null)
#           operation = try(match_blob_index_tags.value.operation, null)
#         }
#       }
# actions {
#   dynamic "base_blob" {
#     for_each = try(rule.value.actions.base_blob, {})
#     content {
#       tier_to_cool_after_days_since_modification_greater_than = try(base_blob.value.tier_to_cool_after_days_since_modification_greater_than, null)
#       tier_to_archive_after_days_since_modification_greater_than = try(base_blob.value.tier_to_archive_after_days_since_modification_greater_than, null)
#       delete_after_days_since_modification_greater_than = try(base_blob.value.delete_after_days_since_modification_greater_than, null)
#     }
#   }
#   dynamic "snapshot" {
#     for_each = try(rule.value.actions.snapshot, {})
#     content {
#       delete_after_days_since_creation_greater_than = try(snapshot.value.delete_after_days_since_creation_greater_than, null)
#     }
#   }
#   dynamic "version" {
#     for_each = try(rule.value.actions.version, {})

#     content {
#       change_tier_to_archive_after_days_since_creation = try(version.value.change_tier_to_archive_after_days_since_creation, null)
#       change_tier_to_cool_after_days_since_creation = try(version.value.change_tier_to_cool_after_days_since_creation, null)
#       delete_after_days_since_creation = try(version.value.delete_after_days_since_creation, null)
#     }
#   }
# }
#     }
#   }

# }


resource "azurerm_storage_management_policy" "this" {
  storage_account_id = var.storage_management_policy_storage_account_id

  dynamic "rule" {
    for_each = var.storage_management_policy_rule == null ? [] : var.storage_management_policy_rule
    content {
      enabled = rule.value.enabled
      name    = rule.value.name

      dynamic "actions" {
        for_each = [rule.value.actions]
        content {
          dynamic "base_blob" {
            for_each = actions.value.base_blob == null ? [] : [actions.value.base_blob]
            content {
              auto_tier_to_hot_from_cool_enabled                             = base_blob.value.auto_tier_to_hot_from_cool_enabled
              delete_after_days_since_creation_greater_than                  = base_blob.value.delete_after_days_since_creation_greater_than
              delete_after_days_since_last_access_time_greater_than          = base_blob.value.delete_after_days_since_last_access_time_greater_than
              delete_after_days_since_modification_greater_than              = base_blob.value.delete_after_days_since_modification_greater_than
              tier_to_archive_after_days_since_creation_greater_than         = base_blob.value.tier_to_archive_after_days_since_creation_greater_than
              tier_to_archive_after_days_since_last_access_time_greater_than = base_blob.value.tier_to_archive_after_days_since_last_access_time_greater_than
              tier_to_archive_after_days_since_last_tier_change_greater_than = base_blob.value.tier_to_archive_after_days_since_last_tier_change_greater_than
              tier_to_archive_after_days_since_modification_greater_than     = base_blob.value.tier_to_archive_after_days_since_modification_greater_than
              tier_to_cold_after_days_since_creation_greater_than            = base_blob.value.tier_to_cold_after_days_since_creation_greater_than
              tier_to_cold_after_days_since_last_access_time_greater_than    = base_blob.value.tier_to_cold_after_days_since_last_access_time_greater_than
              tier_to_cold_after_days_since_modification_greater_than        = base_blob.value.tier_to_cold_after_days_since_modification_greater_than
              tier_to_cool_after_days_since_creation_greater_than            = base_blob.value.tier_to_cool_after_days_since_creation_greater_than
              tier_to_cool_after_days_since_last_access_time_greater_than    = base_blob.value.tier_to_cool_after_days_since_last_access_time_greater_than
              tier_to_cool_after_days_since_modification_greater_than        = base_blob.value.tier_to_cool_after_days_since_modification_greater_than
            }
          }
          dynamic "snapshot" {
            for_each = actions.value.snapshot == null ? [] : [actions.value.snapshot]
            content {
              change_tier_to_archive_after_days_since_creation               = snapshot.value.change_tier_to_archive_after_days_since_creation
              change_tier_to_cool_after_days_since_creation                  = snapshot.value.change_tier_to_cool_after_days_since_creation
              delete_after_days_since_creation_greater_than                  = snapshot.value.delete_after_days_since_creation_greater_than
              tier_to_archive_after_days_since_last_tier_change_greater_than = snapshot.value.tier_to_archive_after_days_since_last_tier_change_greater_than
              tier_to_cold_after_days_since_creation_greater_than            = snapshot.value.tier_to_cold_after_days_since_creation_greater_than
            }
          }
          dynamic "version" {
            for_each = actions.value.version == null ? [] : [actions.value.version]
            content {
              change_tier_to_archive_after_days_since_creation               = version.value.change_tier_to_archive_after_days_since_creation
              change_tier_to_cool_after_days_since_creation                  = version.value.change_tier_to_cool_after_days_since_creation
              delete_after_days_since_creation                               = version.value.delete_after_days_since_creation
              tier_to_archive_after_days_since_last_tier_change_greater_than = version.value.tier_to_archive_after_days_since_last_tier_change_greater_than
              tier_to_cold_after_days_since_creation_greater_than            = version.value.tier_to_cold_after_days_since_creation_greater_than
            }
          }
        }
      }
      dynamic "filters" {
        for_each = [rule.value.filters]
        content {
          blob_types   = filters.value.blob_types
          prefix_match = filters.value.prefix_match

          dynamic "match_blob_index_tag" {
            for_each = filters.value.match_blob_index_tag == null ? [] : filters.value.match_blob_index_tag
            content {
              name      = match_blob_index_tag.value.name
              value     = match_blob_index_tag.value.value
              operation = match_blob_index_tag.value.operation
            }
          }
        }
      }
    }
  }
  dynamic "timeouts" {
    for_each = var.storage_management_policy_timeouts == null ? [] : [var.storage_management_policy_timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }
}

