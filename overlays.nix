# final is the final product, prev is before applying this overlay
# final: prev: {
inputs: final: prev:
let

  mkPluginStructure = pluginDirectory:

    prev.runCommand "mkPluginStructure" { } ''
      mkdir -p $out/share/qgis/python/plugins/
      cp -r ${pluginDirectory} $out/share/qgis/python/plugins/
    '';
  globeBuilder = prev.stdenv.mkDerivation {
    name = "GlobeBuilder";
    src = prev.fetchzip {
      url =
        "https://github.com/GispoCoding/GlobeBuilder/releases/download/dev-pr/GlobeBuilder.dev-pr.zip";
      sha256 = "sha256-NfwDXLp4XxAUEhySNrBw1SIsE6ZU+QOjjF7uYsSIrtE=";
    };
    buildPhase = ''
      mkdir -p $out
      cp -r . $out/GlobeBuilder
    '';
  };
in {

  globeBuilderQGIS = mkPluginStructure "${globeBuilder}/GlobeBuilder";
  networkGTQgis = mkPluginStructure "${inputs.networkGT}/QGIS/network_gt/";
  qgisWithPlugins = final.callPackage ./qgis-with-plugins { };

}
