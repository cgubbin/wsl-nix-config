{...}: {
  programs.awscli = {
    settings = {
      default = {
        region = "eu-west-1";
        output = "json";
      };
    };
  };
}
