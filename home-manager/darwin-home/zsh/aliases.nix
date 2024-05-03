{
  pkgs,
  lib,
  ...
}:
with lib;
with pkgs; {
  tree = "${getExe eza} --tree --icons --tree";
  pdfgrep = "${getExe pdfgrep} -Hin";
  yt-mp3 = ''
    ${getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';

  # my notes
  man-git = "${getExe bat} $HOME/lab/notes/dev-notes/man/git.md";
  man-vim = "${getExe bat} $HOME/lab/notes/dev-notes/man/nvim.md";

  # macOS
  mdfind = "mdfind -onlyin .";
  skim = "/Applications/Skim.app/Contents/MacOS/Skim"; # vimtex viewier
  icloud = "cd $HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs";
  houdini = "/Applications/Houdini/Houdini19.5.569/Houdini\ Apprentice\ 19.5.569.app/Contents/MacOS/happrentice";

  # pyddg
  pyddg = "cd $HOME/ddg/pyddg";
  make-docs = "make -C docs/ docs";
  clean-docs = "make -C docs/ clean";
  # poetry - installed using `curl -sSL https://install.python-poetry.org | python3 -`
  poetry = "~/.local/bin/poetry";
}
