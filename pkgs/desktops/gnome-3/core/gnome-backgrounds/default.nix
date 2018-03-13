{ stdenv, fetchurl, pkgconfig, gnome3, intltool }:

stdenv.mkDerivation rec {
  name = "gnome-backgrounds-${version}";
  version = "3.27.90";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-backgrounds/${gnome3.versionBranch version}/${name}.tar.xz";
    sha256 = "08s7n23k6mjbli3xravipvnr0wmdzmskym4d1iny3yilglhjnap5";
  };

  passthru = {
    updateScript = gnome3.updateScript { packageName = "gnome-backgrounds"; attrPath = "gnome3.gnome-backgrounds"; };
  };

  nativeBuildInputs = [ pkgconfig intltool ];

  meta = with stdenv.lib; {
    platforms = platforms.unix;
    maintainers = gnome3.maintainers;
  };
}
