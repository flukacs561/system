{ lib, haskellPackages }:
haskellPackages.mkDerivation {
  pname = "lits";
  version = "0.1.0.0";
  src = builtins.fetchGit {
    url = "https://codeberg.org/flukacs/lits.git";
    # This is the full hash of the commit.
    rev = "e37ebbd8965710d73be37958247fd6ac04b7c818";
  };
  isLibrary = false;
  isExecutable = true;
  buildDepends = with haskellPackages; [
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
  executableHaskellDepends = with haskellPackages; [ base ];
  description = "Library Tagging System";
  license = lib.licenses.mit;
  mainProgram = "lits";
}

