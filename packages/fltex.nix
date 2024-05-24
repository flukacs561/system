{ stdenv, pkgs, ... }:
stdenv.mkDerivation rec {
  pname = "fltex";
  tlType = "run";
  name = "fltex";
  src = pkgs.fetchFromGitHub {
    owner = "flukacs561";
    repo = "fltex";
    rev = "6e02fa74a873061e90244ee0abab797c2b65c841";
    # nix-prefetch-url --unpack https://github.com/flukacs561/fltex/archive/refs/heads/main.zip
    sha256 = "149ckjrr06vxng5fwi7bancd8mhwcyw0ydhxblz04cdqf2ff7lis";
  };
  installPhase = ''
    mkdir -p $out/tex/latex
    cp *.sty $out/tex/latex
  '';
}
