{
  description = "t430 minimal from scratch";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";
    
    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-colors,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      t430-fms = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [./nixos/configuration.nix];
      };
      t430-fms-vm = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [./nixos/configuration-vm.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "slm@t430-fms" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs nix-colors;};
        # > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
      };
    };
  };
}
