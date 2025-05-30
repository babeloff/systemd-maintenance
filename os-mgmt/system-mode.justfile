
check-ostree-upgrade-state:
   /usr/bin/rpm-ostree status --json | /usr/sbin/jq -e ".deployments[0].booted"

