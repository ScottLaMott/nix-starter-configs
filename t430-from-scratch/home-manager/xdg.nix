#----------------------------------------------------------
#---
#--- xdg configuration / home-manager
#---

{ config, lib, pkgs, modulesPath, ... }: {

  xdg = {
    enable = true;
    configFile."awesome/rc.lua".source   = lib.mkForce ../dots/awesome/rc.lua;
    configFile."vim/settings.vim".source = lib.mkForce ../dots/vim/settings.vim;
    configFile."vim/maps.vim".source     = lib.mkForce ../dots/vim/maps.vim;
  };

}
