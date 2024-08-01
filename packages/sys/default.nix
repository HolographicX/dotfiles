{writeShellScriptBin, pkgs,
  ...
}:
writeShellScriptBin "sys" ''

  cmd_rebuild() {
        # A rebuild script that commits on a successful build
        set -e

        # cd to your config dir
        pushd /home/soham/.dots

        # Early return if no changes were detected
        if git diff --quiet '*.nix'; then
            echo "No changes detected, exiting."
            popd
            exit 0
        fi

        # Autoformat your nix files
        alejandra . &>/dev/null \
        || ( alejandra . ; echo "formatting failed!" && exit 1)

        # Shows your changes
        git diff -U0 '*.nix'

        echo "🔨 Building system configuration with $REBUILD_COMMAND"

        # Rebuild, output simplified errors, log trackebacks
        sudo $REBUILD_COMMAND switch --flake .# &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

        # Get current generation metadata
        current=$(nixos-rebuild list-generations | grep current)

        # Commit all changes witih the generation metadata
        git commit -am "$current"

        # Back to where you were
        popd

        # Notify all OK!
        notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
  }

  cmd_test() {
      echo "🏗️ Building ephemeral system configuration with $REBUILD_COMMAND"
      cd /home/soham/.dots
      $REBUILD_COMMAND test --fast --flake .#
  }

  # TODO: Make it update a single input
  cmd_update() {
      echo "🔒Updating flake.lock"
      cd ~/.dots
      nix flake update
  }

  cmd_clean() {
      echo "🗑️ Cleaning and optimizing the Nix store."
      nix store optimise --verbose &&
      nix store gc --verbose
  }

  cmd_usage() {
      cat <<-_EOF
  Usage:
      $PROGRAM rebuild
          Rebuild the system. (You must be in the system flake directory!)
          Must be run as root.
      $PROGRAM test
          Like rebuild but faster and not persistant.
      $PROGRAM update [input]
          Update all inputs or the input specified. (You must be in the system flake directory!)
          Must be run as root.
      $PROGRAM clean
          Garbage collect and optimise the Nix Store.
      $PROGRAM help
          Show this text.
  _EOF
  }


  if [[ "$OSTYPE" == "linux"* ]]; then
    REBUILD_COMMAND=nixos-rebuild
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    REBUILD_COMMAND=darwin-rebuild
  fi

  # Subcommand utils based on pass

  PROGRAM=sys
  COMMAND="$1"
  case "$1" in
      rebuild|r) shift;       cmd_rebuild ;;
      test|t) shift;          cmd_test ;;
      update|u) shift;        cmd_update ;;
      clean|c) shift;         cmd_clean ;;
      help|--help) shift;     cmd_usage "$@" ;;
      *)              echo "Unknown command: $@" ;;
  esac
  exit 0
''