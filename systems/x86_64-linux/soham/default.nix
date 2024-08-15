{pkgs, inputs, ...}: {
  imports = with inputs; [
      ./hardware-configuration.nix
    ];

  # Enable Bootloader
  system.boot.bios.enable = true;
  system.g14.enable = true;
  
  system.battery.enable = true; # Only for laptops, they will still work without it, just improves battery life

  environment.systemPackages = with pkgs; [
    # Any particular packages only for this host
  ];
  
  suites.common.enable = true; # Enables the basics, like audio, networking, ssh, etc.

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";
}
