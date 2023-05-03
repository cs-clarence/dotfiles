#!/usr/bin/env python

from lib import *

pkgs = [
    Pkg("nvim", package="neovim"),
    Pkg("git"),
    Pkg("clang"),
    Pkg("cmake"),
    Pkg("shfmt"),
    Pkg("alacritty"),
    Pkg("firefox"),
    Pkg("qbittorrent"),
    Pkg("vlc"),
    Pkg("flutter", install_type="snap-classic"),
]


def main():
    for pkg in pkgs:
        pkg.create_install_job().exec()


if __name__ == "__main__":
    main()
