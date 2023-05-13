{ qgis, symlinkJoin, networkGTQgis, globeBuilderQGIS, makeWrapper, ... }:
let

  inherit (qgis) version;
  qgisWithPackages = qgis.override {
    extraPythonPackages = ps:
      with ps; [
        scipy
        sympy
        pandas
        meshio
        # chart_studio
        plotly
        networkx
      ];
  };
in symlinkJoin {
  inherit version;
  name = "qgisWithPlugins-${version}";
  paths = [ qgisWithPackages networkGTQgis globeBuilderQGIS ];
  pname = "qgis";
  nativeBuildInputs = [ makeWrapper ];
}
