#!/bin/sh

# make-live - utility to build Debian Live systems
#
# Copyright (C) 2006 Daniel Baumann <daniel@debian.org>
# Copyright (C) 2006 Marco Amadori <marco.amadori@gmail.com>
#
# make-live comes with ABSOLUTELY NO WARRANTY; for details see COPYING.
# This is free software, and you are welcome to redistribute it
# under certain conditions; see COPYING for details.

Defaults ()
{
	# Set root directory
	if [ -z "${LIVE_ROOT}" ]
	then
		LIVE_ROOT="`pwd`/debian-live"
	fi

	# Set image type
	if [ -n "${LIVE_TYPE}" ]
	then
		case "${LIVE_TYPE}" in
			iso)
				LIVE_TYPE="Iso"
				;;

			net)
				LIVE_TYPE="Net"
				;;

			*)
				echo "E: image type wrong or not yet supported."
				;;
		esac
	else
		LIVE_TYPE="Iso"
	fi

	# Set bootstrap architecture
	if [ -z "${LIVE_ARCHITECTURE}" ]
	then
		LIVE_ARCHITECTURE="`dpkg-architecture -qDEB_BUILD_ARCH`"
	fi

	# Set chroot directory
	if [ -z "${LIVE_CHROOT}" ]
	then
		LIVE_CHROOT="${LIVE_ROOT}/chroot"
	fi

	# Set debian distribution
	if [ -z "${LIVE_DISTRIBUTION}" ]
	then
		LIVE_DISTRIBUTION="${CODENAME_UNSTABLE}"
	fi

	# Set bootstrap flavour
	if [ -z "${LIVE_FLAVOUR}" ]
	then
		LIVE_FLAVOUR="standard"
	fi

	# Set filesystem
	if [ -z "${LIVE_FILESYSTEM}" ] && [ "${LIVE_TYPE}" = "Iso" ]
	then
		LIVE_FILESYSTEM="squashfs"
	elif [ -z "${LIVE_FILESYSTEM}" ] && [ "${LIVE_TYPE}" = "Net" ]
	then
		LIVE_FILESYSTEM="plain"
	fi

	# Set kernel flavour
	if [ -z "${LIVE_KERNEL}" ]
	then
		case "${LIVE_ARCHITECTURE}" in
			alpha)
				LIVE_KERNEL="alpha-generic"
				;;

			amd64)
				if [ "${LIVE_DISTRIBUTION}" = "${CODENAME_UNSTABLE}" ]
				then
					LIVE_KERNEL="amd64"
				else
					LIVE_KERNEL="amd64-generic"
				fi
				;;

			arm)
				echo "E: You need to specify the linux kernel flavour manually on arm."
				exit 1
				;;

			hppa)
				LIVE_KERNEL="parisc"
				;;

			i386)
				if [ "${LIVE_DISTRIBUTION}" = "${CODENAME_STABLE}" ] || [ "${LIVE_DISTRIBUTION}" = "${CODENAME_OLDSTABLE}" ]
				then
					LIVE_KERNEL="386"
				else
					LIVE_KERNEL="486"
				fi
				;;

			ia64)
				LIVE_KERNEL="itanium"
				;;

			m68k)
				echo "E: You need to specify the linux kernel flavour manually on m68k."
				exit 1
				;;

			powerpc)
				LIVE_KERNEL="powerpc"
				;;

			s390)
				LIVE_KERNEL="s390"
				;;

			sparc)
				LIVE_KERNEL="sparc32"
				;;

			*)
				echo "FIXME: Architecture not yet supported."
				exit 1
				;;
		esac
	fi

	# Set debian mirror
	if [ -z "${LIVE_MIRROR}" ]
	then
		LIVE_MIRROR="http://ftp.debian.org/debian"
	fi

	# Set debian security mirror
	if [ -z "${LIVE_MIRROR_SECURITY}" ]
	then
		LIVE_MIRROR_SECURITY="http://security.debian.org/debian"
	fi

	# Set debian sections
	if [ -z "${LIVE_SECTION}" ]
	then
		LIVE_SECTION="main"
	fi

	# Set netboot server
	if [ -z "${LIVE_SERVER_ADDRESS}" ]
	then
		LIVE_SERVER_ADDRESS="192.168.1.1"
	fi

	# Set netboot path
	if [ -z "${LIVE_SERVER_PATH}" ]
	then
		LIVE_SERVER_PATH="/srv/debian-live"
	fi

	# Set templates directory
	if [ -z "${LIVE_TEMPLATES}" ]
	then
		LIVE_TEMPLATES="${BASE}/templates"
	fi
}
