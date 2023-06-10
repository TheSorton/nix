{
  description = "meow meow meow meow";
  inputs = {
    # the most important flake in nixos
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    penni-flake.url = "github:phossil/nixflake-misc";
  };
  outputs =
    { self, nixpkgs, penni-flake }:
    {
      nixosConfigurations = {
        navi = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
          ];
        };
      };
    };
}
