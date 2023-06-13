{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    busybox
    cargo
    catppuccin-gtk
    cider
    discord-canary
    dunst
    firefox
    fontpreview
    gcc
    git
    glib
    grim
    htop
    hyprpaper
    jq
    kitty
    meson
    neofetch
    neovim
    nerdfonts
    nestopia
    nim
    nitch
    nixpkgs-fmt
    nodejs
    p7zip
    pamixer
    pavucontrol
    pcmanfm
    pywal
    revolt-desktop
    rofi
    slurp
    steamcmd
    unzip
    waybar
    wayland
    wget
    wl-clipboard
    wofi
    xwayland
    zip
  ];

  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = true;
    #permitRootLogin = "yes";
  };
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


  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/git/nix --impure";
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
