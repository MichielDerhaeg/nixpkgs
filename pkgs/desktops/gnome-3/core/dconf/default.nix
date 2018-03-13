{ stdenv, fetchurl, meson, ninja, python3, vala, libxslt, pkgconfig, glib, dbus-glib, gnome3
, libxml2, docbook_xsl, makeWrapper }:

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

  postPatch = ''
    chmod +x meson_post_install.py
    patchShebangs meson_post_install.py
  '';

  outputs = [ "out" "lib" "dev" ];

  nativeBuildInputs = [ meson ninja vala pkgconfig python3 libxslt libxml2 docbook_xsl ];
  buildInputs = [ glib dbus-glib ];

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
