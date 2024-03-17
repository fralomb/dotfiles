#!/bin/bash

JDTLS_ROOT="$NVIM_MAINDIR/jdtls"
JDTLS_CORE=$(find "$JDTLS_ROOT/plugins" -type f -name 'org.eclipse.jdt.ls.core_*' 2> /dev/null)
JDTLS_EQUINOX_LAUNCHER=$(find "$JDTLS_ROOT/plugins" -type f -name 'org.eclipse.equinox.launcher_*' 2> /dev/null)
JDTLS_BACKUP_ROOT="$SCRIPT_ROOT/jdtls_backup"

function get_jar_version {
    echo $(basename "$1" | awk '{ gsub(/^[^-_]*[-_]?|\.jar$/, ""); print }' | awk '{ gsub(/^$/, "custom"); print }')
}

function print_jdtls_equinox_launcher {
    [[ -z "$JDTLS_EQUINOX_LAUNCHER" ]] && echo "JDTLS not installed yet" && return 1
    echo "$(get_jar_version "$JDTLS_EQUINOX_LAUNCHER")"
    return 0
}

function print_jdtls_root {
    echo "$JDTLS_ROOT"
}

function check_version {
    [[ -z "$JDTLS_EQUINOX_LAUNCHER" || -z "$JDTLS_CORE" ]] && echo "JDTLS not installed yet" && return 1

    echo "equinox-launcher $(get_jar_version "$JDTLS_EQUINOX_LAUNCHER")"
    echo "jdtls-core $(get_jar_version "$JDTLS_CORE")"
    java --version
    return 0
}

function print_help {
    echo 'jdtls-installer: manage jdtls installation with a single command'
    echo 'available options:'
    echo '  -v | --version            prints version of all components'
    echo '  -h | --help               prints this menu'
    echo '  -i | --install [version]  install jdtls if not installed. optionally specify a version like 1.15.0'
    echo '  -r | --root               show current JDTLS installation directory'
    echo '  -l | --launcher           show current JDTLS equinox launcher version'
    echo '  --uninstall               uninstall jdtls if installed'
    # echo '  --update                  uninstall and install jdtls creating a backup and restoring in case of failure'
    # echo '  --backup                  creates a backup of the current jdtls installation'
    # echo '  --restore                 restores the jdtls backup'
}

function jdtls_create_backup {
    echo 'Creating jdtls backup...'
    if [ ! -d "$JDTLS_ROOT" ]; then
        echo 'Cannot create backup, jdtls installation does not exist' >> /dev/stderr
        return 1
    fi
    rm -rf "$JDTLS_BACKUP_ROOT"
    cp -r "$JDTLS_ROOT" "$JDTLS_BACKUP_ROOT"
    echo 'Backup created'
    return 0
}

function jdtls_restore_backup {
    echo 'Restoring jdtls backup...'
    if [ ! -d "$JDTLS_BACKUP_ROOT" ]; then
        echo 'Cannot restore backup, backup does not exist' >> /dev/stderr
        return 1
    fi
    rm -rf "$JDTLS_ROOT"
    mv "$JDTLS_BACKUP_ROOT" "$JDTLS_ROOT"
    echo 'Backup restored'
    return 0
}

function jdtls_install {
    # TODO: install specific version
    echo 'Installing latest jdtls...'
    if [ -d "$JDTLS_ROOT" ]; then
        echo "Jdtls installation found at $JDTLS_ROOT, aborting installation" >> /dev/stderr
        return 1
    fi

    LATEST=`curl -Ls 'http://download.eclipse.org/jdtls/snapshots/latest.txt'`
    echo "${LATEST%.tar.gz} is going to be installed"

    mkdir -p "$JDTLS_ROOT"
    cd "$JDTLS_ROOT"

    curl -L "http://download.eclipse.org/jdtls/snapshots/$LATEST" --output "$LATEST" --progress-bar
    tar -xf "$LATEST"
    rm "$LATEST"
    chmod -R 755 "$JDTLS_ROOT"
    chmod -R 777 "$JDTLS_ROOT"/config_*

    EQUINOX_LAUNCHER=`find "$JDTLS_ROOT/plugins" -type f -name 'org.eclipse.equinox.launcher_*' 2> /dev/null`
    if ! [[ -f "$EQUINOX_LAUNCHER" ]]; then
        echo 'JDTLS installation failure' >> /dev/stderr
        return 1
    fi

    echo 'JDTLS installation succesfull'
    return 0
}

function jdtls_uninstall {
    echo 'Uninstalling jdtls...'

    rm -rf "$JDTLS_ROOT"
    echo 'JDTLS uninstalled'
    return 0
}

### PARAM PARSING ###
case "$1" in
    -v|--version)
        check_version
        exit 0
        ;;
    -h|--help)
        print_help
        exit 0
        ;;
    -r|--root)
        print_jdtls_root
        exit 0
        ;;
    -l|--launcher)
        print_jdtls_equinox_launcher
        exit 0
        ;;
    # --backup)
    #     jdtls_create_backup
    #     exit
    #     ;;
    # --restore)
    #     jdtls_restore_backup
    #     exit
    #     ;;
    -i|--install)
        [[ check_version -eq 0 ]] && jdtls_install || echo "JDTLS already installed!"

        exit
        ;;
    --uninstall)
        jdtls_uninstall
        exit
        ;;
    # --update)
    #     jdtls_reinstall
    #     exit
    #     ;;
    *)
        echo "unknown option $1"
        print_help
        exit 1
        ;;
esac
