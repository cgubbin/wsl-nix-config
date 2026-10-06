{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.ai-memory
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.backlog-md
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.beads-rust
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.beads-viewer
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codegraph
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.gitnexus
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.mindwalk
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.openresearch
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.openspec
    # inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.oh-my-claudecode
    inputs.starter.inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi
  ];
}
