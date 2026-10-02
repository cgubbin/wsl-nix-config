{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.ai-memory
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.backlog-md
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.beads-rust
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.beads-viewer
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codegraph
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.gitnexus
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.mindwalk
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.openresearch
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.openspec
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.oh-my-claudecode
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi
  ];
}
