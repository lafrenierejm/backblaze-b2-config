{
  description = "Backblaze B2 Config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
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
            settings.hooks = {
              ripsecrets = {
                enable = true;
                excludes = [ ".*\\.crypt" ];
              };
              treefmt.enable = true;
              typos = {
                enable = true;
                excludes = [ ".*\\.crypt" ];
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
            packages = config.pre-commit.settings.enabledPackages ++ (with pkgs; [ pass ]);
          };
        };
    };
}
