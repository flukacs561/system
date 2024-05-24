{ lib, pkgs, ... }:
pkgs.haskellPackages.mkDerivation {
  pname = "hxh";
  version = "0.1.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "flukacs561";
    repo = "hxh";
    rev = "f46e7b2e6b86148852af8b7c60cedb60f9c43d06";
    # nix-prefetch-url --unpack https://github.com/flukacs561/hxh/archive/refs/heads/master.zip
    sha256 = "0gylsfdhv6hxwmwqii1zv5dggd4jjpi9qxpikhv3kipbb20csrni";
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ pkgs.haskellPackages.base ];
  description = "HeliX Haskell extensions";
  license = lib.licenses.gpl3Plus;
  mainProgram = "hxh";
}
