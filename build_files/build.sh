#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

dnf5 -y copr enable starfish/howdy-beta # TODO switch back to principis' copr when dlib builds
dnf5 -y in howdy howdy-gtk
dnf5 -y copr disable starfish/howdy-beta

# waydroid setup
dnf5 -y in waydroid cage
sed -i~ -E 's/=.\$\(command -v (nft|ip6?tables-legacy).*/=/g' /usr/lib/waydroid/data/scripts/waydroid-net.sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/bazzite-org/waydroid-scripts/refs/heads/main/way-firewalld.sh)"
