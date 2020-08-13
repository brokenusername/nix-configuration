{
  programs.bash = {
    enable = true;
    historyFileSize = 1000;
    historyControl = [ "erasedups" ];
    historyIgnore  = [ "ls" "cd" "exit" "pwd" ];
    shellAliases = {
      "cdl" = "cd && clear";
      "em" = "emacsclient -c";
      "la" = "ls -lah";
      ".." = "cd ..";
      "..." = "cd ../..";
    };
  };
}
