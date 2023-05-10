# final is the final product, prev is before applying this overlay
# final: prev: {
inputs: final: prev: {

  networkGTQgis = prev.runCommand "mkNetworkGTPlugin" { } ''
    mkdir -p $out/share/qgis/python/plugins/
    cp -r ${inputs.networkGT}/QGIS/network_gt/ $out/share/qgis/python/plugins/
  '';

  qgisWithPlugins = final.callPackage ./qgis-with-plugins { };

}
