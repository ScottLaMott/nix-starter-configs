# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  nix-colors,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./alacritty.nix
    ./fzf.nix
    ./git.nix
    ./picom.nix
    ./rofi.nix
    ./tmux.nix
    ./vim.nix
    ./xdg.nix
    # ./xsession.nix
    ./zsh.nix
    nix-colors.homeManagerModules.default
  ];

  #--- colorScheme
  # colorScheme = nix-colors.colorSchemes.dracula;
  colorScheme = nix-colors.colorSchemes.pasque;
  # colorScheme = nix-colors.colorSchemes.atlas;
  # colorScheme = nix-colors.colorSchemes.gruvbox-dark-hard;
  # colorScheme = nix-colors.colorSchemes.brogrammer;
  # colorScheme = nix-colors.colorSchemes.ocean;
  # colorScheme = nix-colors.colorSchemes.icy;
  # colorScheme = nix-colors.colorSchemes.brogrammer;
  # colorScheme = nix-colors.colorSchemes.ocean;
  # colorScheme = nix-colors.colorSchemes.nord;
  # colorScheme = nix-colors.colorSchemes.icy;
  # colorScheme = nix-colors.colorSchemes.papercolor-dark;
  # colorScheme = nix-colors.colorSchemes.onedark;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "slm";
    homeDirectory = "/home/slm";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    cmatrix
    cava
    figlet
    lolcat
    mixxx
    nitch
    sl
    soco-cli
    spotify-tui
    termshark
    toilet
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";

}
