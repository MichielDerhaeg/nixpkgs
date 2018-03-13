{ stdenv, fetchurl, vala, libxslt, pkgconfig, glib, dbus-glib, gnome3
, libxml2, intltool, docbook_xsl_ns, docbook_xsl, makeWrapper }:

let
  pname = "dconf";
in
stdenv.mkDerivation rec {
  name = "${pname}-${version}";
  version = "0.27.1";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${gnome3.versionBranch version}/${name}.tar.xz";
    sha256 = "1kp9lz7vay1vd03f6yj5fh80jkn6r9xdzq62s2va0g6hd0pgbnip";
  };

  outputs = [ "out" "lib" "dev" ];

  nativeBuildInputs = [ vala pkgconfig intltool libxslt libxml2 docbook_xsl docbook_xsl_ns makeWrapper ];
  buildInputs = [ glib dbus-glib ];

  postConfigure = stdenv.lib.optionalString stdenv.isDarwin ''
    substituteInPlace client/Makefile \
      --replace "-soname=libdconf.so.1" "-install_name,libdconf.so.1"
  '';

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = pname;
      attrPath = "gnome3.${pname}";
    };
  };

  meta = with stdenv.lib; {
    homepage = https://wiki.gnome.org/Projects/dconf;
    license = licenses.lgpl21Plus;
    platforms = platforms.linux ++ platforms.darwin;
    maintainers = gnome3.maintainers;
  };
}
