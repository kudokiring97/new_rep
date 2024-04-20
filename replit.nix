{ pkgs }: {
  deps = [
    pkgs.open-watcom-v2
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
  ];
}