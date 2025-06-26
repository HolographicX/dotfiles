{pkgs, inputs, ...}: {
  imports = with inputs; [
      ./hardware-configuration.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  system.boot.bios.enable = true; # Enable Bootloader
  system.g14.enable = true; # Asus laptop controls
  system.battery.enable = true; # Only for laptops, they will still work without it, just improves battery life
  hardware.nvidia.enable = true; # NVIDIA GPU
  hardware.swap.enable = true;
  environment.systemPackages = with pkgs; [
    # Any particular packages only for this host
  ];
  
  suites.common.enable = true; # Enables the basics, like audio, networking, ssh, etc.

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";
}
