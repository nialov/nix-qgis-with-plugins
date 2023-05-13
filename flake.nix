{
  description = "Flake utils demo";

  inputs = {

    networkGT = {
      url = "github:BjornNyberg/networkGT";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:

    let localOverlay = import ./overlays.nix inputs;

    in flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ localOverlay ];
        };
      in {
        overlays.localOverlay = localOverlay;
        overlays.default = self.overlays.localOverlay;
        packages = {
          inherit (pkgs) qgisWithPlugins globeBuilderQGIS networkGTQgis;
        };
        packages = { default = self.packages."${system}".qgisWithPlugins; };
        apps = rec {
          qgisWithPlugins = flake-utils.lib.mkApp {
            drv = self.packages.${system}.qgisWithPlugins;
          };
        };
        apps = rec { default = self.apps."${system}".qgisWithPlugins; };
      });
}
