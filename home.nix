{ pkgs, args, ... }:
{
  imports = [ modules/git.nix ];
  
  home = {
    username = "${args.userName}";
    homeDirectory = "${args.homeDirectory}";
    sessionVariables = {
      BROWSER = "brave";
      CABAL_DIR = "${args.dataHome}/cabal";
      PYTHONHISTORY = "${args.dataHome}/python/python-history";
      PYTHON_HISTORY = "${args.dataHome}/python/python-history";
    };
    shellAliases = {
      nixr = "sudo nixos-rebuild switch --flake '${args.nixRepo}#${args.hostName}'";
      nixc = "sudo nix-collect-garbage --delete-older-than 14d";
      nixu =
        "nix flake update ${args.nixRepo} && sudo nixos-rebuild switch --flake '${args.nixRepo}#${args.hostName}'";

      off = "sudo shutdown 0";
      tp = "xinput --set-prop 12 181";
      gitl = "git log --pretty --oneline --graph";
      gs = "git status";
      gd = "git diff";

      ll =
        "ls -AGFhlv --group-directories-first --time-style=long-iso --color=always";
      l =
        "ls -GFhlv --group-directories-first --time-style=long-iso --color=always";

      hakyllr = "ghc --make site.hs && ./site clean && ./site watch";
      hakylld =
        "ghc --make site.hs && ./site clean && ./site build && ./site deploy";

      use-unfree = "NIXPKGS_ALLOW_UNFREE=1 nix-shell -p";

      z = "zathura";
    };
    packages = with pkgs; [ xdotool ];
    file."${args.configHome}/latexmk/latexmkrc".text = ''
      $pdflatex = "lualatex %O %S --interaction=nonstopmode"
      $pdf_mode = 1;
      $postscript_mode = $dvi_mode = 0;
      $preview_continuous_mode = 1;
      
      $view = 'none';
      $recorder = 1;
    '';

    file."${args.homeDirectory}/.agda/defaults".text = ''
      standard-library
    '';

    file."${args.homeDirectory}/.agda/libraries".text = ''
      ${pkgs.agdaPackages.standard-library}/standard-library.agda-lib
    '';
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };
  services.emacs = {
    enable = true;
    defaultEditor = true;
    startWithUserSession = true;
    client.enable = true;
    client.arguments = [ ''-c "emacs"'' ];
  };

  programs.zathura.enable = true;

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableScDaemon = true;
    pinentryFlavor = "qt";
    # 84600 seconds is 24 hours
    defaultCacheTtl = 84600;
    maxCacheTtl = 84600;
    maxCacheTtlSsh = 84600;
    defaultCacheTtlSsh = 84600;
    grabKeyboardAndMouse = true;
  };

  programs.ssh = {
    enable = true;
    matchBlocks."GitHub" = {
      host = "github.com";
      identityFile = "${args.homeDirectory}/.ssh/id_ed25519";
      extraOptions.PreferredAuthentications = "publickey";
    };
  };

  programs.zsh = rec {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    initExtra = ''
        autoload -U colors && colors
        PS1="[%F{green}f%f%F{brown}@%f%F{green}💻%f %~] %F{green}>%f "
    '';
    defaultKeymap = "emacs";
    dotDir = "/.config/zsh";
    history = {
      path = "${args.homeDirectory}/${dotDir}/zsh_history";
      size = 10000;
      save = 10000;
    };
  };

  xdg = {
    enable = true;
    cacheHome = "${args.homeDirectory}/.cache";
    configHome = "${args.homeDirectory}/.config";
    dataHome = "${args.homeDirectory}/.local/share";
    stateHome = "${args.homeDirectory}/.local/state";
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${args.homeDirectory}";
      documents = "${args.homeDirectory}/dox";
      download = "${args.homeDirectory}/let";
      music = "${args.homeDirectory}/aud";
      pictures = "${args.homeDirectory}/pix";
      templates = "${args.homeDirectory}/code";
      videos = "${args.homeDirectory}/vid";
      publicShare = "${args.homeDirectory}/dox/books";
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # document types
      "application/epub+zip" = [ "org.pwmt.zathura.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "text/plain" = [ "emacsclient.desktop" ];
      "text/tex" = [ "emacsclient.desktop" ];

      # audio types
      "auido/mpeg" = [ "mpv.desktop" ];
      "audio/ogg" = [ "mpv.desktop" ];
      "audio/opus" = [ "mpv.desktop" ];
      "audio/wav" = [ "mpv.desktop" ];
      "audio/wbm" = [ "mpv.desktop" ];

      # image types
      "image/jpeg" = [ "brave.desktop" ];
      "image/gif" = [ "brave.desktop" ];
      "image/png" = [ "brave.desktop" ];
      "image/svg+xml" = [ "brave.desktop" ];
      "image/vnd.microsoft.icon" = [ "brave.desktop" ];

      # video types
      "video/x-msvideo" = [ "mpv.desktop" ];
      "video/mp4" = [ "mpv.desktop" ];
      "video/mpeg" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];

      # web types
      "text/html" = [ "brave.desktop" ];
      "x-scheme-handler/http" = [ "brave.desktop" ];
      "x-scheme-handler/https" = [ "brave.desktop" ];
      "x-scheme-handler/about" = [ "brave.desktop" ];
      "x-scheme-handler/unknown" = [ "brave.desktop" ];
    };
  };

  home.stateVersion = "23.11";
}

