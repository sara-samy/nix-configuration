{
  pkgs,
  lib,
  ...
}:
with lib;
with pkgs; {
  tree = "${getExe eza} --tree --icons --tree";
  pdfgrep = "${getExe pdfgrep} -Hin";
  x-dlp = "${getExe yt-dlp} --output '%(title).200B%(title.201B&…|)s.%(ext)s' --cookies-from-browser firefox";
  yt-mp3 = ''
    ${getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';

  # my notes
  man-git = "${getExe bat} $HOME/lab/notes/dev-notes/man/git.md";
  man-vim = "${getExe bat} $HOME/lab/notes/dev-notes/man/nvim.md";

  # macOS
  mdfind = "mdfind -onlyin .";
  icloud = "cd $HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs";
  houdini = "/Applications/Houdini/Houdini19.5.569/Houdini\ Apprentice\ 19.5.569.app/Contents/MacOS/happrentice";

  # pyddg
  pyddg = "cd $HOME/ddg/pyddg";
  make-docs = "make -C docs/ docs";
  clean-docs = "make -C docs/ clean";
}
