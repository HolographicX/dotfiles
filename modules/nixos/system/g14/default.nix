{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.g14;
  g14_patches = fetchGit {
    url = "https://gitlab.com/dragonn/linux-g14";
    ref = "6.9";
    rev = "52ac92f9b6085f3b2c7edac93dec412dbe9c01b4";
  };
  g14_uarches = pkgs.fetchurl { 
    url = "https://raw.githubusercontent.com/graysky2/kernel_compiler_patch/master/more-uarches-for-kernel-6.8-rc4%2B.patch";
    hash = "sha256-9Of80BHyaRhA0sjCNh3KhQp46jPMXCTS4nw+ApT9HcU=";
  };
  g14_schedext = pkgs.fetchurl { 
    url = "https://raw.githubusercontent.com/cachyos/kernel-patches/master/6.9/sched/0001-sched-ext.patch";
    hash = "sha256-RZajVZ+pEHIWRnB8ihInbaEH0IYAgF14FB4WRhow9Gc=";
  };
in {
  options.system.g14 = with types; {
    enable = mkBoolOpt false "Whether or not to enable g14 patches.";
  };
  
  config = mkIf cfg.enable {
    boot.kernelPackages = let
      linux_custom_pkg = { fetchurl, buildLinux, ... } @ args:

        buildLinux (args // rec {
          version = "6.9.3";
          modDirVersion = version;

          src = fetchurl {
            url = "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.9.3.tar.xz";
            # Replace this with the correct SHA-256 hash after the first build.
            hash = "sha256-wyHEZAE2h3T8I29XCVsgWl2ldBX5pgCAGJAvn9Xt364=";
          };
          kernelPatches = map (patch: { inherit patch; }) [
            g14_uarches
            "${g14_patches}/0001-acpi-proc-idle-skip-dummy-wait.patch"
            "${g14_patches}/v4-0001-platform-x86-asus-wmi-add-support-for-2024-ROG-Mi.patch"
            "${g14_patches}/v4-0002-platform-x86-asus-wmi-add-support-for-Vivobook-GP.patch"
            "${g14_patches}/v4-0003-platform-x86-asus-wmi-add-support-variant-of-TUF-.patch"
            "${g14_patches}/v4-0004-platform-x86-asus-wmi-support-toggling-POST-sound.patch"
            "${g14_patches}/v4-0005-platform-x86-asus-wmi-store-a-min-default-for-ppt.patch"
            "${g14_patches}/v4-0006-platform-x86-asus-wmi-adjust-formatting-of-ppt-na.patch"
            "${g14_patches}/v4-0007-platform-x86-asus-wmi-ROG-Ally-increase-wait-time.patch"
            "${g14_patches}/v4-0008-platform-x86-asus-wmi-Add-support-for-MCU-powersa.patch"
            "${g14_patches}/v4-0009-platform-x86-asus-wmi-cleanup-main-struct-to-avoi.patch"
            "${g14_patches}/0001-platform-x86-asus-wmi-add-support-for-vivobook-fan-p.patch"
            "${g14_patches}/0001-HID-asus-fix-more-n-key-report-descriptors-if-n-key-.patch"
            "${g14_patches}/0002-HID-asus-make-asus_kbd_init-generic-remove-rog_nkey_.patch"
            "${g14_patches}/0003-HID-asus-add-ROG-Ally-N-Key-ID-and-keycodes.patch"
            "${g14_patches}/0004-HID-asus-add-ROG-Z13-lightbar.patch"
            "${g14_patches}/0001-ALSA-hda-realtek-Adjust-G814JZR-to-use-SPI-init-for-.patch"
            "${g14_patches}/0001-platform-x86-asus-wmi-add-debug-print-in-more-key-pl.patch"
            "${g14_patches}/0002-platform-x86-asus-wmi-don-t-fail-if-platform_profile.patch"
            "${g14_patches}/0003-asus-bios-refactor-existing-tunings-in-to-asus-bios-.patch"
            "${g14_patches}/0004-asus-bios-add-panel-hd-control.patch"
            "${g14_patches}/0005-asus-bios-add-dgpu-tgp-control.patch"
            "${g14_patches}/0006-asus-bios-add-apu-mem.patch"
            "${g14_patches}/0007-asus-bios-add-core-count-control.patch"
            "${g14_patches}/v2-0001-hid-asus-use-hid-for-brightness-control-on-keyboa.patch"
            # "${g14_patches}/0003-platform-x86-asus-wmi-add-macros-and-expose-min-max-.patch"
            "${g14_patches}/0027-mt76_-mt7921_-Disable-powersave-features-by-default.patch"
            "${g14_patches}/0032-Bluetooth-btusb-Add-a-new-PID-VID-0489-e0f6-for-MT7922.patch"
            "${g14_patches}/0035-Add_quirk_for_polling_the_KBD_port.patch"
            "${g14_patches}/0001-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch"
            "${g14_patches}/0002-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch"
            "${g14_patches}/v2-0005-platform-x86-asus-wmi-don-t-allow-eGPU-switching-.patch"
            "${g14_patches}/0038-mediatek-pci-reset.patch"
            "${g14_patches}/0040-workaround_hardware_decoding_amdgpu.patch"
            "${g14_patches}/0001-platform-x86-asus-wmi-Support-2023-ROG-X16-tablet-mo.patch"
            "${g14_patches}/amd-tablet-sfh.patch"
            g14_schedext
            "${g14_patches}/0003-hid-asus-add-USB_DEVICE_ID_ASUSTEK_DUO_KEYBOARD.patch"
            # "${g14_patches}/0005-asus-wmi-don-t-error-out-if-platform_profile-already.patch"
            "${g14_patches}/sys-kernel_arch-sources-g14_files-0047-asus-nb-wmi-Add-tablet_mode_sw-lid-flip.patch"
            "${g14_patches}/sys-kernel_arch-sources-g14_files-0048-asus-nb-wmi-fix-tablet_mode_sw_int.patch"
          ];

          # extraConfig = ''
          #   # Add any custom kernel configuration options here
          #   # For example, enabling a specific feature:
          #   # CONFIG_EXAMPLE_FEATURE=y
          # '';

          extraMeta.branch = "6.9";
        } // (args.argsOverride or {}));
      linux_custom = pkgs.callPackage linux_custom_pkg{};
    in 
      pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_custom);

    environment.systemPackages = with pkgs; [
      supergfxctl
      asusctl
    ];

    services.supergfxd.enable = true;
    services = {
        asusd = {
          enable = true;
          enableUserService = true;
        };
    };
  };
}