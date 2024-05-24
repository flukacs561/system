{ lib, haskellPackages }:
haskellPackages.mkDerivation {
  pname = "hxh";
  version = "0.1.0.0";
  src = builtins.fetchGit {
    url = "https://codeberg.org/flukacs/hxh.git";
    # This is the full hash of the commit.
    rev = "44b377d7811646d441c5a64318c8c519359ad015";
  };
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ haskellPackages.base ];
  description = "HeliX Haskell extensions";
  license = lib.licenses.gpl3Plus;
  mainProgram = "hxh";
}
