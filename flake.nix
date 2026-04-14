{
  description = "Backblaze B2 Config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.flake-root.flakeModule
        inputs.git-hooks.flakeModule
        inputs.treefmt-nix.flakeModule
      ];
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      perSystem =
        { config, pkgs, ... }:
        {
          pre-commit = {
            check.enable = true;
            settings.package = pkgs.prek;
            settings.hooks =
              let
                tfstate = [
                  ".*\\.tfstate"
                  ".*\\.tfstate\\.backup"
                ];
              in
              {
                end-of-file-fixer = {
                  enable = true;
                  excludes = tfstate;
                };
                ripsecrets = {
                  enable = true;
                  excludes = tfstate;
                };
                statix.enable = true;
                treefmt.enable = true;
                trim-trailing-whitespace = {
                  enable = true;
                  excludes = tfstate;
                };
                typos = {
                  enable = true;
                  excludes = tfstate;
                };
              };
          };

          treefmt.config = {
            projectRootFile = ".git/config";
            package = pkgs.treefmt;
            flakeCheck = false; # use pre-commit's check instead
            programs = {
              nixfmt.enable = true;
              terraform = {
                enable = true;
                package = pkgs.opentofu;
              };
            };
          };

          devShells.default = pkgs.mkShell {
            # Inherit all of the pre-commit hooks.
            inputsFrom = [
              config.pre-commit.devShell
              config.treefmt.build.devShell
            ];
            packages =
              config.pre-commit.settings.enabledPackages
              ++ (with pkgs; [
                opentofu
                pass
                backblaze-b2
              ]);
          };
        };
    };
}
