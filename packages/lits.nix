{ lib, pkgs }:
pkgs.haskellPackages.mkDerivation {
  pname = "lits";
  version = "0.1.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "flukacs561";
    repo = "lits";
    rev = "b330cde74c73b3d8fadc3e9a153615327774a109";
    # nix-prefetch-url --unpack https://github.com/flukacs561/lits/archive/refs/heads/main.zip
    sha256 = "0jffgj69qim6mafqggi324mzn71fm84k1h5yv2z0d7pa39mnvcvk";
  };
  isLibrary = true;
  isExecutable = true;
  buildDepends = with pkgs.haskellPackages; [
    base
    aeson
    bytestring
    directory
    containers
    filepath
    text
    tasty
    tasty-hunit
  ];
  executableHaskellDepends = with pkgs.haskellPackages; [ base ];
  description = "Library Tagging System";
  license = lib.licenses.mit;
  mainProgram = "lits";
}

