{...}: {
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;

    defaultOptions = [
      "--height=40%"
      "--layout=reverse"
      "--border"
    ];

    fileWidget.command = "fd --type f";
    fileWidget.options = [
      "--preview='bat --style=numbers --color=always {}'"
      "--preview-window=right,60%,border-left"
      "--bind=ctrl-/:toggle-preview"
      "--bind=alt-k:preview-page-up"
      "--bind=alt-j:preview-page-down"
    ];

    changeDirWidget.command = "fd --type d";
    changeDirWidget.options = [
      "--preview='eza --tree --level=2 --color=always {} | head -200'"
      "--preview-window=right,50%,border-left"
      "--bind=ctrl-/:toggle-preview"
      "--bind=alt-k:preview-page-up"
      "--bind=alt-j:preview-page-down"
    ];

    historyWidget.options = [
      "--layout=reverse"
      "--border"
    ];
  };
}
