{ stdenv, ... }:
stdenv.mkDerivation rec {
  pname = "fltex";
  tlType = "run";
  name = "fltex";
  src = builtins.fetchGit {
    url = "https://codeberg.org/flukacs/fltex.git";
    # This is the full hash of the commit.
    rev = "5c4f9dd0e88e5df676eef7b40ef72738570a5c49";
  };
  installPhase = ''
    mkdir -p $out/tex/latex
    cp *.sty $out/tex/latex
  '';
}
