{
  inputs = {
    parsec.url = "github:nprindle/nix-parsec";
  };
  outputs = { self, nixpkgs, parsec }: {
    herculesCI.ciSystems = [ "x86_64-linux" ];
    packages =
      let
        inherit (parsec.lib) parsec;
        parser = import ./parser.nix {
          inherit parsec;
          l = nixpkgs.lib;
        };
        package = parser [./.];
      in {
        aarch64-darwin.default = package;
        x86_64-linux.default = package;
      };
  };
}
