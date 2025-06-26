{
  plugins.web-devicons = {
    enable = true;
  };
  extraConfigLuaPre = ''
        local devicons = require("nvim-web-devicons")
        local vsh_icon = devicons.get_icons().vsh
        devicons.setup({
          override_by_extension = {
            v = vsh_icon,
          },
    override_by_filename = {
        ["v.mod"] = {
          icon = "",
          color = "#FF8700",
          name = "VMod"
        }
      }
    })
  '';
}
