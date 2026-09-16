{...}: {
  programs.obsidian = {
    enable = true;
    vaults.notes.target = "Obsidian";

    defaultSettings.app = {
      alwaysUpdateLinks = true;
      spellCheck = true;
    };
  };
}
