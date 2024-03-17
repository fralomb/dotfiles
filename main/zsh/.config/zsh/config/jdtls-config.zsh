#!/bin/sh

INSTALLER="$(dirname "$0")/scripts/jdtls-installer.sh"

function jdtls() {
	if [[ -x "$INSTALLER" ]]; then
		jdtls_equinox_launcher=$(bash $INSTALLER --launcher)
		[[ "$?" -ne 0 ]] && echo "JDTLS not installed" && return
		jdtls_root_dir=$(bash $INSTALLER --root)

		SYSTEM=$(uname -s)
		case "$SYSTEM" in
			[Ll]inux) # Linux and WSL
				jdtls_config="$jdtls_root_dir/config_linux"
				;;
			[Dd]arwin) # MacOS
				jdtls_config="$jdtls_root_dir/config_mac"
				;;
			*)
				echo "ERROR: Unknown or unsupported system $SYSTEM" >> /dev/stderr
				return
				;;
		esac


		export JDTLS_CONFIGURATION="$jdtls_config"
		export JDTLS_EQUINOX_LAUNCHER="$jdtls_equinox_launcher"
		export JDTLS_ROOT="$jdtls_root_dir"
	fi
}

jdtls
