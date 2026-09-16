{...}: {
  programs.fish.interactiveShellInit = ''
    # Tokyo Night palette
    set -g fish_color_normal        c0caf5
    set -g fish_color_command       7aa2f7
    set -g fish_color_keyword       bb9af7
    set -g fish_color_quote         e0af68
    set -g fish_color_redirection   f7768e
    set -g fish_color_end           9ece6a
    set -g fish_color_error         f7768e
    set -g fish_color_param         c0caf5
    set -g fish_color_comment       565f89
    set -g fish_color_operator      89ddff
    set -g fish_color_escape        bb9af7
    set -g fish_color_autosuggestion 565f89
    set -g fish_color_cwd           7aa2f7
    set -g fish_color_user          9ece6a
    set -g fish_color_host          c0caf5
    set -g fish_color_cancel        f7768e
    set -g fish_color_selection      --background=283457
    set -g fish_color_search_match   --background=283457

    set -g fish_pager_color_progress    565f89
    set -g fish_pager_color_prefix      7aa2f7
    set -g fish_pager_color_completion  c0caf5
    set -g fish_pager_color_description 565f89
    set -g fish_pager_color_selected_background --background=283457
  '';
}
