#!/bin/sh

# This is a hook for live-helper(7) to install squashfs drivers
# To enable it, copy this hook into your config/chroot_local-hooks directory.
#
# Note: You only want to use this hook if there is no prebuild
# squashfs-modules-* package available for your kernel flavour.

# Building kernel module
which module-assistant || apt-get install --yes module-assistant
module-assistant update
module-assistant --non-inter --quiet auto-install squashfs
module-assistant clean squashfs
