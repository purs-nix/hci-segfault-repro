{
  outputs = inputs@{ self, nixpkgs, ... }: {
    herculesCI.ciSystems = [ "x86_64-linux" ];
    packages =
      let
        v = builtins.match ".*" (toString (builtins.genList (x: x) 100000));
        mkPackage = pkgs: pkgs.runCommand "pkg" {} ''
          echo ${builtins.trace v "done"} > $out
        '';
      in {
        aarch64-darwin.default = mkPackage nixpkgs.legacyPackages.aarch64-darwin.pkgs;
        x86_64-linux.default = mkPackage nixpkgs.legacyPackages.x86_64-linux.pkgs;
      };
  };
}
