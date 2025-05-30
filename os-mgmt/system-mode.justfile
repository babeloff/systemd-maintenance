
check-ostree-upgrade-status:
   /usr/bin/rpm-ostree status --json | /usr/bin/jq -e \".deployments[0].booted == false\" > /dev/null

   