with import <nixpkgs> { }; {
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    enableAutosuggestions = true;
    enableCompletion = true;
    plugins = [{
      name = "zsh-nix-shell";
      src = pkgs.fetchFromGitHub {
        owner = "chisui";
        repo = "zsh-nix-shell";
        rev = "v0.1.0";
        sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
      };
    }];
    history = {
      expireDuplicatesFirst = true;
      size = 1000;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "aws"
        "common-aliases"
        "copybuffer"
        "docker"
        "extract"
        "git"
        "sudo"
        "systemadmin"
        "wd"
      ];
    };
    shellAliases = {
      "cdl" = "cd && clear";
      "em" = "emacsclient -c";
      "la" = "ls -lah";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    localVariables = {
      PROMPT = "%~ %# ";
      ZSH_THEME = "minimal";
    };
    initExtra = ''
      eval "$(direnv hook zsh)"
    '';
  };
}
