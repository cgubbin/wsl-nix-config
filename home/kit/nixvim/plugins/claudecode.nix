{
  programs.nixvim = {
    plugins.claudecode = {
      enable = true;
      # autoLoad = false;
      settings = {
        diff_opts = {
          layout = "horizontal";
          open_in_new_tab = true;
        };
        focus_after_send = false;
        log_level = "debug";
        port_range = {
          max = 12100;
          min = 12000;
        };
        terminal = {
          git_repo_cwd = true;
          provider = "external";
          provider_opts.external_terminal_cmd = "zellij run --close-on-exit --direction right -- %s";
          split_side = "right";
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>ac";
        action = "<cmd>ClaudeCode<cr>";
        options.desc = "Toggle Claude";
      }
      {
        mode = "n";
        key = "<leader>af";
        action = "<cmd>ClaudeCodeFocus<cr>";
        options.desc = "Focus Claude";
      }
      {
        mode = "n";
        key = "<leader>ar";
        action = "<cmd>ClaudeCode --resume<cr>";
        options.desc = "Resume Claude";
      }
      {
        mode = "n";
        key = "<leader>aC";
        action = "<cmd>ClaudeCode --continue<cr>";
        options.desc = "Continue Claude";
      }
      {
        mode = "n";
        key = "<leader>am";
        action = "<cmd>ClaudeCodeSelectModel<cr>";
        options.desc = "Select Claude Model";
      }
      {
        mode = "n";
        key = "<leader>ab";
        action = "<cmd>ClaudeCodeAdd %<cr>";
        options.desc = "Add Current Buffer";
      }
      {
        mode = "v";
        key = "<leader>as";
        action = "<cmd>ClaudeCodeSend<cr>";
        options.desc = "Send to Claude";
      }
      {
        mode = "n";
        key = "<leader>aa";
        action = "<cmd>ClaudeCodeDiffAccept<cr>";
        options.desc = "Accept Diff";
      }
      {
        mode = "n";
        key = "<leader>ad";
        action = "<cmd>ClaudeCodeDiffDeny<cr>";
        options.desc = "Deny Diff";
      }
    ];
    autoCmd = [
      {
        event = "FileType";
        pattern = [
          "NvimTree"
          "neo-tree"
          "oil"
          "minifiles"
          "netrw"
          "snacks_picker_list"
        ];
        callback.__raw = ''
          function(args)
            vim.keymap.set("n", "<leader>as", "<cmd>ClaudeCodeTreeAdd<cr>", {
              buffer = args.buf,
              desc = "Add file",
            })
          end
        '';
      }
    ];
  };
}
