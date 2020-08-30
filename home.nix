{ config, pkgs, ... }:

let
  war = builtins.fetchurl {
    url = "http://mirrors.jenkins.io/war-stable/2.235.3/jenkins.war";
    sha256 = "109rycgy8bg3na173vz5f3bq7w33a6kap8158kx6zhignni451p8";
  };

  winbox = builtins.fetchurl {
    url = "https://download.mikrotik.com/winbox/3.24/winbox.exe";
    sha256 = "90c59b23c3dd4039a38f9217c41b9b89acc0098b59ded577c9137fe1a52c3d8a";
  };

  jenkins-script = pkgs.writeShellScriptBin "jenkins" ''
    ${pkgs.jdk11}/bin/java -jar ${war}
  '';

  winbox-run = pkgs.writeShellScriptBin "winbox" ''
    ${pkgs.wine}/bin/wine ${winbox}
  '';
in

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "james";
  home.homeDirectory = "/home/james";

  imports =
    [ ./bash.nix
      ./emacs.nix
      ./i3.nix
      ./git.nix
      ./go.nix
      ./services.nix
      ./ssh.nix 
      ./xmodmap.nix
      ./zsh.nix ];
  
  home.packages = (with pkgs; [
    acpi       aria       adapta-gtk-theme  ansible  aws
    chromium   clojure
    dhall-bash dhall-json dhall-nix         direnv   dmenu
    elixir
    feh        fish       flat-remix-icon-theme
    gimp       guvcview
    hack-font  htop
    jdk11      jenkins-script               jp2a
    leiningen
    mc         mcron
    nixops     nmap-graphical
    plano-theme
    sakura     scummvm    stilo-themes
    terraform  tree
    unzip
    vlc
    w3m        wine       winbox-run
    xorg.xcursorthemes    xorg.xbacklight   xscreensaver
  ]);

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
