{
  config,
  pkgs,
  ...
}: {
  systemd.user.services.goofys-wavephotonics2 = {
    Unit = {
      Description = "Mount DigitalOcean Spaces bucket wavephotonics2 with Goofys";
      After = ["network.target"];
    };

    Service = {
      Type = "simple";
      Environment = "PATH=/run/wrappers/bin:/run/current-system/sw/bin";
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${config.home.homeDirectory}/s3/wavephotonics2";
      ExecStart = ''
        ${pkgs.goofys}/bin/goofys \
          -f \
          -o ro \
          --dir-mode 0555 \
          --file-mode 0444 \
          --region lon1 \
          --endpoint https://lon1.digitaloceanspaces.com \
          wavephotonics2 \
          ${config.home.homeDirectory}/s3/wavephotonics2
      '';
      ExecStop = "${pkgs.fuse}/bin/fusermount -u ${config.home.homeDirectory}/s3/wavephotonics2";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
}
