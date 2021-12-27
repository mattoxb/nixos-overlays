{ appimageTools, fetchurl, lib, gsettings-desktop-schemas, gtk3 }:

let
  pname = "logseq";
  version = "0.5.5";
in appimageTools.wrapType2 rec {
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://github.com/logseq/logseq/releases/download/${version}/Logseq-linux-x64-${version}.AppImage";
    sha256 = "60326fef5919c3c2e9952ccc946479e21f9d2ed208f2b1aa861453fb44b15ddc";
  };


  profile = ''
    export LC_ALL=C.UTF-8
    export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
  '';

  multiPkgs = null; # no 32bit needed
  extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
  extraInstallCommands = "mv $out/bin/{${name},${pname}}";

  meta = with lib; {
    description = "An open source note taking and to-do application with synchronisation capabilities";
    longDescription = ''
      Logseq is a free, open source note taking and to-do application, which can
      handle a large number of notes organised.
    '';
    homepage = https://github.com/logseq/;
    license = licenses.mit;
    # maintainers = with maintainers; [ rafaelgg raquelgb ];
    platforms = [ "x86_64-linux" ];
  };
}
