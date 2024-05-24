{ pkgs, args, ... }:
let
  emailAddress = "john.doe@provider.com";
in {
  programs.git = {
    enable = true;
    userName = "John Doe";
    userEmail = emailAddress;
    ignores = [ "*.o" "*.hi" ];
    extraConfig = {
      core.editor = "${args.editor}";
      core.commitGraph = true;
      init.defaultBranch = "main";
    };
    signing = {
      signByDefault = true;
      key = emailAddress;
    };
  };
}
