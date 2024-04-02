{
  pkgs,
  lib,
  ...
}:
with lib;
with pkgs; {
  cat = "${getExe bat}";
  tree = "${getExe eza} --tree --icons --tree";
  pdfgrep = "${getExe pdfgrep} -Hin";
  yt-mp3 = ''
    ${getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"'';

  # my notes
  man-git = "${getExe bat} $HOME/Downloads/lab/notes/dev-notes/man/git.md";
  man-vim = "${getExe bat} $HOME/Downloads/lab/notes/dev-notes/man/nvim.md";

  # ddg
  pyddg = "cd $HOME/Downloads/ddg/pyddg";
  make-docs = "make -C docs/ docs";
  clean-docs = "make -C docs/ clean";
}
