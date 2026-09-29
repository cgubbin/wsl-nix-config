{...}: {
  programs.nixvim.extraConfigLuaPre = ''
    _G.python_env = _G.python_env or {}

    function _G.python_env.project_root(markers)
      local path = vim.fn.expand("%:p:h")
      if path == "" then
        path = vim.loop.cwd()
      end
      local found = vim.fs.find(markers, { upward = true, path = path })[1]
      if found then
        return vim.fs.dirname(found)
      end
      return vim.loop.cwd()
    end

    function _G.python_env.python_root()
      return _G.python_env.project_root({ "pyproject.toml", ".git", "flake.nix" })
    end

    function _G.python_env.rust_root()
      return _G.python_env.project_root({ "Cargo.toml", ".git", "flake.nix" })
    end

    local direnv_loaded = {}

    function _G.python_env.load_direnv(root)
      if not root or root == "" then
        return
      end
      if direnv_loaded[root] then
        return
      end
      if vim.fn.executable("direnv") ~= 1 then
        return
      end

      direnv_loaded[root] = true

      vim.system(
        { "direnv", "export", "json" },
        { text = true, cwd = root },
        function(result)
          if result.code ~= 0 or not result.stdout or result.stdout == "" then
            return
          end
          local ok, env = pcall(vim.json.decode, result.stdout)
          if not ok or type(env) ~= "table" then
            return
          end
          vim.schedule(function()
            for k, v in pairs(env) do
              if type(v) == "string" then
                vim.env[k] = v
              end
            end
          end)
        end
      )
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "rust" },
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if ft == "python" then
          _G.python_env.load_direnv(_G.python_env.python_root())
        elseif ft == "rust" then
          _G.python_env.load_direnv(_G.python_env.rust_root())
        end
      end,
    })

    local python_path_cache = {}
    local python_resolving = {}

    function _G.python_env.resolve_python()
      local root = _G.python_env.python_root()
      local logf = io.open("/tmp/neotest_resolve.log", "a")

      local function log_and_return(path, source)
        if logf then
          logf:write(os.date() .. " root=" .. tostring(root) .. " source=" .. source .. " path=" .. tostring(path) .. "\n")
          logf:close()
        end
        return path
      end

      if python_path_cache[root] then
        return log_and_return(python_path_cache[root], "cache")
      end

      if python_resolving[root] then
        vim.wait(10000, function() return python_path_cache[root] ~= nil end, 50)
        return log_and_return(python_path_cache[root] or vim.fn.exepath("python3"), "waited")
      end

      python_resolving[root] = true

      local manifest_root, manifest_file = nil, nil
      local pixi_toml_root = _G.python_env.project_root({ "pixi.toml" })
      if pixi_toml_root and vim.fn.filereadable(pixi_toml_root .. "/pixi.toml") == 1 then
        manifest_root, manifest_file = pixi_toml_root, "pixi.toml"
      else
        local pyproject_root = _G.python_env.project_root({ "pyproject.toml" })
        if pyproject_root and vim.fn.filereadable(pyproject_root .. "/pyproject.toml") == 1 then
          manifest_root, manifest_file = pyproject_root, "pyproject.toml"
        end
      end

      if manifest_root then
        local result = vim.system(
          { "pixi", "run", "--manifest-path", manifest_root .. "/" .. manifest_file, "which", "python" },
          { text = true }
        ):wait()
        local path = result.stdout and vim.trim(result.stdout) or ""
        if result.code == 0 and path ~= "" then
          python_path_cache[root] = path
          python_resolving[root] = false
          return log_and_return(path, "pixi")
        end
      end

      local venv_python = root .. "/.venv/bin/python"
      if vim.fn.executable(venv_python) == 1 then
        python_path_cache[root] = venv_python
        python_resolving[root] = false
        return log_and_return(venv_python, "venv")
      end

      local fallback = vim.fn.exepath("python3")
      python_path_cache[root] = fallback
      python_resolving[root] = false
      return log_and_return(fallback, "fallback")
    end

    vim.api.nvim_create_user_command("NeotestPythonCacheClear", function()
      python_path_cache = {}
      python_resolving = {}
      print("neotest python path cache cleared")
    end, {})

    vim.api.nvim_create_user_command("NeotestDirenvCacheClear", function()
      direnv_loaded = {}
      print("direnv cache cleared")
    end, {})
  '';
}
