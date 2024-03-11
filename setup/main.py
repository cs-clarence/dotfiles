#!/usr/bin/env python

from lib import *

pkgs = [
    Pkg("nvim", package_name="neovim"),
    Pkg("git"),
    Pkg("zsh", post_install_scripts=["chsh -s $(which zsh)"]),
    Pkg(
        "snap",
        package_name="snapd",
        post_install_scripts=["sudo ln -s /var/lib/snapd/snap /snap"],
    ),
    Pkg(
        "rg",
        package_name="ripgrep",
    ),
    Pkg(
        "fd",
        package_name="fd-find",
    ),
    Pkg(
        "cargo",
        install_type="script",
        install_scripts=[
            "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
        ],
    ),
    Pkg(
        "fnm",
        install_type="script",
        install_scripts=["curl -fsSL https://fnm.vercel.app/install | sh"],
    ),
    Pkg(
        "bun",
        install_type="script",
        install_scripts=["curl -fsSL https://bun.sh/install | sh"],
    ),
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
