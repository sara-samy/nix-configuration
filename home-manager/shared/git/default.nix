{
  lib,
  username,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "sara-samy";
    userEmail = "intermsofart@hotmail.com";

    includes = [
      # use diffrent email/username for work
      {
        path = "/Users/${username}/nix-configuration/home-manager/shared/git/work-gitconfig";
        condition = "gitdir:/Users/${username}/Downloads/ddg/pyddg/";
      }
      {
        path = "/Users/${username}/nix-configuration/home-manager/shared/git/work-gitconfig";
        condition = "gitdir:/Users/${username}/Downloads/ddg/geometry-book/";
      }
    ];

    extraConfig = {
      init.defaultBranch = "main";
      push.default = "current";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    ignores = [
      ".cache/"
      ".DS_Store"
      "Icon?"
      ".idea/"
      ".vscode"
      ".direnv/"
      "node_modules"
      ".ipynb_checkpoints"
      "__pycache__"
      "*.blend1"
      ".gitconfig"
    ];

    aliases = {
      uncommit = "reset --soft HEAD~1";
      checkout-remote = "checkout --track";

      delete-remote-branch = "push origin --delete";
      delete-local-branch = "branch -d";

      unpushed = "!GIT_CURRENT_BRANCH=$(git name-rev --name-only HEAD) && git log origin/$GIT_CURRENT_BRANCH..$GIT_CURRENT_BRANCH --oneline";

      logr = "log --abbrev-commit --raw";
      logline = "log --graph --pretty=tformat:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --decorate=full";
    };
  };
}
