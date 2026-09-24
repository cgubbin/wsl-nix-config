{
  self,
  inputs,
  config,
  ...
}: let
  sops = inputs.starter.lib.mkSopsHost {
    secretsPath = toString inputs.nix-secrets;
    hostFile = "wsl-system.yaml";
    userFile = "wsl-user.yaml";
  };
in {
  flake-file.inputs = {
    nix-secrets = {
      url = "git+ssh://git@github.com/cgubbin/nix-secrets.git";
      flake = false;
    };
  };

  flake.modules.nixos."work" = {pkgs, ...}: {
    imports = [
      sops.nixos
      (inputs.starter.lib.mkSopsPasswordUser {username = "kit";})
      self.modules.nixos.kit
    ];
    system.stateVersion = "26.05"; # set once, at first install — never bump this later
    home-manager.users.kit.home.stateVersion = "26.05";
    networking.hostName = "work";

    services.openssh = {
      enable = true;
    };

    programs.fuse = {
      enable = true;
      userAllowOther = true;
    };

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib # common baseline most dynamically-linked binaries need (libstdc++, etc.)
        zlib
        openssl
      ];
    };

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (inputs.nixpkgs.lib.getName pkg) [
        "obsidian"
        "terraform"
        "jupytext.nvim"
        "wezterm.nvim"
      ];
    home-manager.useGlobalPkgs = true; # makes home-manager use the system's pkgs, config included

    home-manager.sharedModules = [
      sops.homeManager
      (
        {config, ...}: {
          sops.secrets."netrc".path = "${config.home.homeDirectory}/.netrc";
          sops.secrets."do-spaces-credentials".path = "${config.home.homeDirectory}/.aws/credentials";
          sops.secrets."github-token".path = "${config.home.homeDirectory}/.config/github-token";

          sops.secrets."do-spaces-access-key" = {};
          sops.secrets."do-spaces-secret-key" = {};

          sops.templates."do-spaces-env".content = ''
            set -gx SPACES_KEY ${config.sops.placeholder."do-spaces-access-key"}
            set -gx SPACES_SECRET ${config.sops.placeholder."do-spaces-secret-key"}
          '';

          sops.secrets."k8s-oidc-client-secret" = {};
          sops.templates."kubeconfig".path = "${config.home.homeDirectory}/.kube/config";
          sops.templates."kubeconfig".content = ''
            apiVersion: v1
            kind: Config
            preferences: {}
            clusters:
              - name: erebus
                cluster:
                  server: https://192.168.5.21:6443/
                  certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJkekNDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdGMyVnkKZG1WeUxXTmhRREUzTkRReE1UQTBOakF3SGhjTk1qVXdOREE0TVRFd056UXdXaGNOTXpVd05EQTJNVEV3TnpRdwpXakFqTVNFd0h3WURWUVFEREJock0zTXRjMlZ5ZG1WeUxXTmhRREUzTkRReE1UQTBOakF3V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFSTnBNQVVBWmhzMVNXeDNhaGhjYkppY0UrMnRCTTgrd1RvWklGZWI4MTcKQWlNb21hOVFURytkUU0xbDJyYlhnN1pJaisyMm9XRlpDc1J3MVZ2NzdpQUpvMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVWNnZkYvUlE0TWdnelQyMlhzdjIrClNCdjh5ZTB3Q2dZSUtvWkl6ajBFQXdJRFNBQXdSUUlnUll4bUczbEtjL2szRGJxTk1Ndm54bDNY
            contexts:
              - name: erebus
                context:
                  cluster: erebus
                  user: oidc
            current-context: erebus
            users:
              - name: oidc
                user:
                  exec:
                    apiVersion: client.authentication.k8s.io/v1
                    interactiveMode: Never
                    command: kubectl
                    env: null
                    provideClusterInfo: false
                    args:
                      - oidc-login
                      - get-token
                      - --oidc-issuer-url=https://sts.windows.net/d2c7365c-6bb2-4c6d-b977-c428d1fc55d9/
                      - --oidc-client-id=9efea7dd-7971-47c4-b064-7197ab6aab8d
                      - --oidc-client-secret=${config.sops.placeholder."k8s-oidc-client-secret"}
                      - --oidc-extra-scope=groups
                      - --oidc-extra-scope=email
          '';
        }
      )
    ];

    wsl = {
      wslConf = {
        network.hostname = "work";
      };
    };

    programs.fish.enable = true;
  };

  flake.nixosConfigurations."work" = inputs.starter.lib.mkNixos {
    inherit self inputs;
    hostname = "work";
    platform = "wsl"; # or native
  };
}
