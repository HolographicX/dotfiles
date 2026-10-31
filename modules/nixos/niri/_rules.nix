{
  window-rules = [
    {
      geometry-corner-radius = {
        top-left = 20.0;
        top-right = 20.0;
        bottom-right = 20.0;
        bottom-left = 20.0;
      };
      clip-to-geometry = true;
      draw-border-with-background = false;
    }
    {
      matches = [{is-floating = true;}];
      shadow.enable = true;
    }
    {
      matches = [{is-window-cast-target = true;}];
      focus-ring = {
        active = {color = "#f38ba8";};
        inactive = {color = "#7d0d2d";};
      };
      border.inactive = {color = "#7d0d2d";};
      shadow.color = "#7d0d2d70";
      tab-indicator = {
        active = {color = "#f38ba8";};
        inactive = {color = "#7d0d2d";};
      };
    }
    {
      matches = [{app-id = "org.telegram.desktop";}];
      block-out-from = "screencast";
    }
    {
      matches = [{app-id = "app.drey.PaperPlane";}];
      block-out-from = "screencast";
    }
    {
      matches = [
        {app-id = "zen";}
        {app-id = "helium";}
        {app-id = "firefox";}
        {app-id = "chromium-browser";}
        {app-id = "xdg-desktop-portal-gtk";}
      ];
      scroll-factor = 0.9;
    }
    {
      matches = [
        {app-id = "zen";}
        {app-id = "helium";}
        {app-id = "firefox";}
        {app-id = "chromium-browser";}
        {app-id = "edge";}
      ];
      open-maximized = true;
    }
    {
      matches = [{title = "^Picture-in-Picture$";}];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "bottom-right";
      };
      default-column-width.fixed = 480;
      default-window-height.fixed = 270;
    }
    {
      matches = [{title = "Discord Popout";}];
      open-floating = true;
      default-floating-position = {
        x = 32;
        y = 32;
        relative-to = "bottom-right";
      };
    }
    {
      matches = [{app-id = "pavucontrol";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "pavucontrol-qt";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "com.saivert.pwvucontrol";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "io.github.fsobolev.Cavalier";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "dialog";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "popup";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "task_dialog";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "gcr-prompter";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "file-roller";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "org.gnome.FileRoller";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "nm-connection-editor";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "blueman-manager";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "xdg-desktop-portal-gtk";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "org.kde.polkit-kde-authentication-agent-1";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "swayimg";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "pinentry";}];
      open-floating = true;
    }
    {
      matches = [{title = "Progress";}];
      open-floating = true;
    }
    {
      matches = [{title = "File Operations";}];
      open-floating = true;
    }
    {
      matches = [{title = "Confirm";}];
      open-floating = true;
    }
    {
      matches = [{title = "Error";}];
      open-floating = true;
    }
    {
      matches = [{app-id = "io.github.didley.CamOverla";}];
      open-floating = true;
      open-on-output = "HDMI-A-1";
      default-window-height.fixed = 370;
      default-column-width.fixed = 280;
      default-floating-position = {
        x = 15;
        y = 402;
        relative-to = "bottom-left";
      };
    }
  ];

  layer-rules = [
    {
      matches = [{namespace = "^noctalia-wallpaper*";}];
      place-within-backdrop = true;
    }
  ];
}
