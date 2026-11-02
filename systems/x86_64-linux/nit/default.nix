{pkgs, inputs, ...}: {
  imports = with inputs; [
      ./hardware-configuration.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages;
  system.boot.bios.enable = true;
  system.battery.enable = true; 
  hardware.swap.enable = true;

  
  suites.server.enable = true;

  hardware.cpu.intel.updateMicrocode = true;


  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";
}
