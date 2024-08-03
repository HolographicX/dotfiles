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
    ref = "6.8";
    rev = "6fda5397095438de5bf961f6902083d92ce534b2";
  };
in {
  options.system.g14 = with types; {
    enable = mkBoolOpt false "Whether or not to enable g14 patches.";
  };
  
  config = mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_6_8;
    boot.kernelPatches = map (patch: { inherit patch; }) [
      "${g14_patches}/sys-kernel_arch-sources-g14_files-0004-more-uarches-for-kernel-6.8-rc4+.patch"
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
      "${g14_patches}/0001-HID-asus-fix-more-n-key-report-descriptors-if-n-key-.patch"
      "${g14_patches}/0001-platform-x86-asus-wmi-add-support-for-vivobook-fan-p.patch"
      "${g14_patches}/0002-HID-asus-make-asus_kbd_init-generic-remove-rog_nkey_.patch"
      "${g14_patches}/0003-HID-asus-add-ROG-Ally-N-Key-ID-and-keycodes.patch"
      "${g14_patches}/0004-HID-asus-add-ROG-Z13-lightbar.patch"
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
      "${g14_patches}/0001-hid-asus-use-hid-for-brightness-control-on-keyboard.patch"

      "${g14_patches}/0001-sched-ext.patch"

      "${g14_patches}/sys-kernel_arch-sources-g14_files-0047-asus-nb-wmi-Add-tablet_mode_sw-lid-flip.patch"
      "${g14_patches}/sys-kernel_arch-sources-g14_files-0048-asus-nb-wmi-fix-tablet_mode_sw_int.patch"

    ];

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

    # some suspend wake-up patch
    boot.loader.grub.extraConfig = "GRUB_CMDLINE_LINUX_DEFAULT=\"mem_sleep_default=deep\"";
  };
}
