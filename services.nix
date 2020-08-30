let
  pkgs = import <nixpkgs> { };
  runpath = "/run/current-system/sw";
in {
  systemd.user.services.mcron = {
    Unit = {
      Description = "mcron daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = { ExecStart = "${pkgs.mcron}/bin/mcron"; };
  };

  home.file.".cron/job.guile".text = "";
}
