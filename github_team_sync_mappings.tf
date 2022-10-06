#  vim:ts=2:sts=2:sw=2:et
#
#  Author: Hari Sekhon
#  Date: 2022-10-06 16:56:47 +0100 (Thu, 06 Oct 2022)
#
#  https://github.com/HariSekhon/Terraform
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

# ============================================================================ #
#               G i t H u b   T e a m   -   I D P   m a p p i n g
# ============================================================================ #

# Maps groups from an SSO IDP such as Azure Active Directory to GitHub teams to populate their members from the IDP groups

# XXX: data.github_organization_team_sync_groups takes a very long time to run so split this to it's own backend to not
# 		 run along with all the other github actions as it'll kill CI/CD minutes and waste engineer time waiting for every
#			 pull request's plan posting

locals {
  team_group_mapping = {
    my-github-team1 = "my-azure-ad-group1",
    my-github-team2 = "my-azure-ad-group2",
    #...
  }

  # XXX: takes ages (26 minutes) to enumerate team sync groups, so pre-materialize and don't call it for every for_each loop iteration!
  sync_groups = data.github_organization_team_sync_groups.this.groups
}

data "github_organization_team_sync_groups" "this" {}

resource "github_team_sync_group_mapping" "this" {
  for_each  = local.team_group_mapping
  team_slug = each.key

  dynamic "group" {
    for_each = [for g in local.sync_groups : g if g.group_name == each.value]
    content {
      group_id          = group.value.group_id
      group_name        = group.value.group_name
      group_description = "IDP Group ${group.value.group_name}"
      # match existing description if importing to prevent replacement
      #group_description = group.value.group_description
    }
  }
}
