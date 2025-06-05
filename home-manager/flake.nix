{
  description =
    "My portable userspace for any distro, powered by home-manager.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty.url = "github:ghostty-org/ghostty";
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = inputs@{ nixgl, ... }:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      secrets.username = builtins.getEnv "USER";
      secrets.homeDirectory = builtins.getEnv "HOME";
      secrets.hostName = builtins.getEnv "HOSTNAME";
    in
    {
      homeConfigurations = {
        "${secrets.username}@${secrets.hostName}" =
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [ ./home.nix ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
            extraSpecialArgs = {
              inherit nixgl;
              inherit secrets;
            };
          };
      };
    };
}
