{
  inputs = {
    parsec.url = "github:nprindle/nix-parsec";
  };
  outputs = { self, nixpkgs, parsec }: {
    herculesCI.ciSystems = [ "x86_64-linux" ];

    packages.aarch64-darwin.default =
      let
        inherit (parsec.lib) parsec;
        parser = import ./parser.nix {
          inherit parsec;
          l = nixpkgs.lib;
        };
      in
        parser [./.];

  };
}
