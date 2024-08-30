{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.audio;
in {
  options.hardware.audio = with types; {
    enable = mkBoolOpt false "Enable pipewire";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      orca
    ];
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
      jack.enable = true;
      pulse.enable = true;
      extraConfig.pipewire = {
        "60-echo-cancel.conf" = {
          name = "libpipewire-module-echo-cancel";
         args = {
             monitor.mode = true;
             aec.args = {
                 # Settings for the WebRTC echo cancellation engine
                 webrtc.gain_control = true;
                 webrtc.extended_filter = false;
             };
         };
        };
      };
    };
  };
}