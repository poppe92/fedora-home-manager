{
  pkgs,
  config,
  ...
}: {
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    timeouts = [
      {
        timeout = 270;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 30 seconds' -t 10000";
      }
      {
        timeout = 280;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 20 seconds' -t 10000";
      }
      {
        timeout = 290;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds' -t 10000";
      }
      {
        timeout = 300;
        command = "${config.programs.swaylock.package}/bin/swaylock -fF";
      }
    ];
  };
}
