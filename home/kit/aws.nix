{...}: {
  programs.awscli = {
    settings = {
      default = {
        region = "lon1";
        output = "json";
      };
    };
  };
}
