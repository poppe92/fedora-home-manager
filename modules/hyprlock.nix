{
  pkgs,
  ...
}: 
{
  programs.hyprlock = {
#    enable = true;
    package = pkgs.hyprlock;

    settings = {
      background = {
        monitor = "";
        path = "/home/jesper/git/fedora-home-manager/images/neon-astronaut.jpg";
        blur_passes = 1; # 0 disables blurring
        blur_size = 7;
        noise = 1.17e-2;
      };

      label = {
#        text = "$TIME";
#        color = "rgba(242, 243, 244, 0.75)";
#        position = "0, 150";
#        halign = "center";
#        valign = "center";
      };

      image = {
#        monitor = "DP-3";
#        path = "/home/jesper/git/.dotfiles/jesperProfilePicture.png";
#        size = "150";
#        position = "0, 200";
#        halign = "center";
#        valign = "center";
      };

      input-field = {
#        monitor = "DP-3";
#        outline_thickness = 2;
#        dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
#        dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
#        dots_fade_time = 200;
#        dots_center = true;
#        outer_color = "rgba(0, 0, 0, 0)";
#        inner_color = "rgba(0, 0, 0, 0.2)";
#        font_color = "rgb(111, 45, 104)";
#        fade_on_empty = false;
#        rounding = -1;
#        check_color = "rgb(30, 107, 204)";
#        placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
#        hide_input = false;
#        position = "0, -20";
#        halign = "center";
#        valign = "center";
      };
    };
  };
}

