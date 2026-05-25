{pkgs, inputs, ...}: {
  imports = with inputs; [
      ./hardware-configuration.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  system.boot.bios.enable = true;
  system.g14.enable = true;
  system.battery.enable = true; 
  hardware.nvidia.enable = true;
  hardware.swap.enable = true;

  
  suites.common.enable = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";
}
