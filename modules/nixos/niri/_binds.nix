{pkgs, ...}: {
  "XF86AudioPlay" = {
    allow-when-locked = true;
    action.spawn = ["noctalia" "msg" "media-play-pause"];
  };
  "XF86AudioStop" = {
    allow-when-locked = true;
    action.spawn = ["noctalia" "msg" "media-stop"];
  };
  "XF86AudioNext" = {
    allow-when-locked = true;
    action.spawn = ["noctalia" "msg" "media-next"];
  };
  "XF86AudioPrev" = {
    allow-when-locked = true;
    action.spawn = ["noctalia" "msg" "media-previous"];
  };
  "XF86AudioMute" = {
    allow-when-locked = true;
    action.spawn = ["noctalia" "msg" "volume-mute"];
  };
  "XF86AudioMicMute" = {
    allow-when-locked = true;
    action.spawn = ["noctalia" "msg" "mic-mute"];
  };
  "XF86AudioRaiseVolume" = {
    allow-when-locked = true;
    action.spawn = ["noctalia" "msg" "volume-up"];
  };
  "XF86AudioLowerVolume" = {
    allow-when-locked = true;
    action.spawn = ["noctalia" "msg" "volume-down"];
  };

  "XF86MonBrightnessUp" = {
    allow-when-locked = true;
    action.spawn = ["noctalia" "msg" "brightness-up"];
  };
  "XF86MonBrightnessDown" = {
    allow-when-locked = true;
    action.spawn = ["noctalia" "msg" "brightness-down"];
  };

  "Ctrl+Alt+L".action.spawn = ["noctalia" "msg" "session" "lock"];
  "Mod+V".action.spawn = ["noctalia" "msg" "panel-toggle" "clipboard"];
  "Mod+E".action.spawn = ["noctalia" "msg" "panel-toggle" "emoji"];
  "Mod+U".action.spawn = ["noctalia" "msg" "settings-toggle"];
  "Mod+Space".action.spawn = ["noctalia" "msg" "panel-toggle" "launcher"];

  "Print".action.screenshot-screen = [];
  "Mod+Shift+Alt+S".action.screenshot-window = [];
  "Mod+Shift+S".action.screenshot = [];
  "Mod+Return".action.spawn = ["alacritty"];
  "Mod+Q".action.close-window = [];
  "Mod+X".action.spawn = ["fish" "-c" "niri msg pick-color | grep -oP '#[0-9a-fA-F]+' | wl-copy"];
  "Mod+S".action.switch-preset-column-width = [];
  "Mod+F".action.maximize-column = [];
  "Mod+Alt+F".action.spawn = ["fish" "-c" "niri msg action toggle-windowed-fullscreen --id $(niri msg --json pick-window | jq '.id')"];
  "Mod+1".action.set-column-width = "25%";
  "Mod+2".action.set-column-width = "50%";
  "Mod+3".action.set-column-width = "75%";
  "Mod+4".action.set-column-width = "100%";
  "Mod+Shift+F".action.expand-column-to-available-width = [];
  "Mod+W".action.spawn = ["zen-beta"];
  "Mod+Comma".action.consume-window-into-column = [];
  "Mod+Period".action.expel-window-from-column = [];
  "Mod+C".action.center-visible-columns = [];
  "Mod+Tab".action.switch-focus-between-floating-and-tiling = [];
  "Mod+Minus".action.set-column-width = "-10%";
  "Mod+Plus".action.set-column-width = "+10%";
  "Mod+Shift+Minus".action.set-window-height = "-10%";
  "Mod+Shift+Plus".action.set-window-height = "+10%";
  "Mod+H".action.focus-column-left = [];
  "Mod+L".action.focus-column-right = [];
  "Mod+J".action.focus-window-or-workspace-down = [];
  "Mod+K".action.focus-window-or-workspace-up = [];
  "Mod+Left".action.focus-column-left = [];
  "Mod+Right".action.focus-column-right = [];
  "Mod+Down".action.focus-workspace-down = [];
  "Mod+Up".action.focus-workspace-up = [];
  "Mod+Shift+H".action.move-column-left = [];
  "Mod+Shift+L".action.move-column-right = [];
  "Mod+Shift+K".action.move-column-to-workspace-up = [];
  "Mod+Shift+J".action.move-column-to-workspace-down = [];
  "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [];
  "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [];
  "Mod+Ctrl+K".action.focus-window-or-monitor-up = [];
  "Mod+Ctrl+J".action.focus-window-or-monitor-down = [];
}
