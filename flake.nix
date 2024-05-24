{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      args = rec {
        userName = "lukacsf";
        homeDirectory = "/home/${userName}";
        nixRepo = "${homeDirectory}/code/system";
        configHome = "${homeDirectory}/.config";
        dataHome = "${homeDirectory}/.local/share";
        editor = "emacsclient";
      };
    in {
      nixosConfigurations.thomas = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          args = args // { hostName = "thomas"; };
        };
        modules = [
          ./configuration.nix
          ./thomas/hardware-configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t490

          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              args = args // { hostName = "thomas"; };
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lukacsf = import ./home.nix;
          }
        ];
      };
      nixosConfigurations.anselm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          args = args // { hostName = "anselm"; };
        };
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-x250

          home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              args = args // { hostName = "anselm"; };
            };            
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lukacsf = import ./home.nix;
          }
        ];
      };
    };

  nixConfig.experimental-features = "nix-command flakes";
}
