{
  inputs = {
    parsec.url = "github:nprindle/nix-parsec";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    herculesCI.ciSystems = [ "x86_64-linux" ];
    packages =
      let
        inherit (inputs.parsec.lib) parsec;
        parser = import ./parser.nix {
          inherit parsec;
          l = nixpkgs.lib;
        };
        result = parser [ ./src ];
        mkPackage = pkgs: pkgs.runCommand "pkg" {} ''
          echo ${builtins.trace result "done"} > $out
        '';
      in {
        aarch64-darwin.default = mkPackage nixpkgs.legacyPackages.aarch64-darwin.pkgs;
        x86_64-linux.default = mkPackage nixpkgs.legacyPackages.x86_64-linux.pkgs;
      };
  };
}
