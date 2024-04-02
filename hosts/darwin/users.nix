{
  username,
  hostnameDarwin,
  ...
}: {
  networking.hostName = hostnameDarwin;
  networking.computerName = hostnameDarwin;
  system.defaults.smb.NetBIOSName = hostnameDarwin;

  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };

  nix.settings.trusted-users = [username];
}
