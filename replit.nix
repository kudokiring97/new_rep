{ pkgs }: {
  deps = [
    pkgs.root5
    pkgs.ed
    pkgs.open-watcom-v2
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
  ];
}