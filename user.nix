{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    wayland
    firefox
    git
    kitty
    discord
    meson
    wofi
    slurp
    grim
    wl-clipboard
    gcc
    nodejs
    hyprpaper
    jq
    neofetch
    htop
    steamcmd
    cider
    waybar
    pavucontrol
    pamixer
    xwayland
    unzip
    pcmanfm
    p7zip
    nestopia
    catppuccin-gtk
    dunst
    glib
    rofi
    pywal
    fontpreview
    nerdfonts
    cargo
  ];

  nixpkgs.overlays = [
    (self: super: {
     waybar = super.waybar.overrideAttrs (oldAttrs: {
         mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
         });
     })
  ];
  nixpkgs.config.packageOverrides = pkgs: {
    catppuccin-gtk = pkgs.catppuccin-gtk.override {
      accents = [ "green" ]; # You can specify multiple accents here to output multiple themes 
        size = "compact";
      tweaks = [ "rimless" "black" ]; # You can also specify multiple tweaks here
        variant = "mocha";
    };
  };


    services.xserver = {
    enable = true;
    desktopManager = {
      xfce.enable = true;
      };
    };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/.config/nix/flakes/";
      update-flake = "nix flake update";
      vim = "nvim";
    };
    histFile = "~/.zsh/history";
    histSize = 10000;
  };
  environment.localBinInPath = true;

  services.flatpak.enable = true;
  environment.binsh = "${pkgs.zsh}/bin/zsh";
  security.polkit.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
