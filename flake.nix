{
  description = "Backblaze B2 Config";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
  };
  outputs = { self, nixpkgs, flake-utils }:
    with flake-utils.lib; eachSystem allSystems (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        buildInputs = [
          pkgs.terraform
          pkgs.terragrunt
        ];
      in
      rec {
        devShell = pkgs.mkShell {
          buildInputs = buildInputs ++ [ pkgs.nixpkgs-fmt ];
        };
      });
}
