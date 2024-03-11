#!/usr/bin/env python

from lib import *
import argparse

parser = argparse.ArgumentParser("setup")
parser.add_argument("--gui", help = "Whether to install GUI packages", default = True, action = argparse.BooleanOptionalAction)
parser.add_argument("--optional", help = "Whether to install optional (not required) packages", default = False, action = argparse.BooleanOptionalAction)
args = parser.parse_args()

pkgs = [
    Pkg("nvim", package_name="neovim", required = True),
    Pkg("python", required = True),
    Pkg("git"),
    Pkg("zsh", post_install_scripts=["chsh -s $(which zsh)"], required = True),
    Pkg(
        "snap",
        package_name="snapd",
        post_install_scripts=["sudo ln -s /var/lib/snapd/snap /snap"],
    ),
    Pkg(
        "rg",
        package_name="ripgrep",
        required = True,
    ),
    Pkg(
        "fd",
        package_name="fd-find",
        required = True,
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
        required = True,
    ),
    Pkg(
        "bun",
        install_type="script",
        install_scripts=["curl -fsSL https://bun.sh/install | sh"],
        required = True,
    ),
    Pkg("clang"),
    Pkg("cmake"),
    Pkg("shfmt"),
    Pkg("alacritty", has_gui = True),
    Pkg("firefox", has_gui = True),
    Pkg("qbittorrent", has_gui = True),
    Pkg("vlc", has_gui = True),
    Pkg("flutter", install_type="snap-classic"),
]

pkgs_final = []
for pkg in pkgs:
    if pkg.required or (pkg.has_gui and args.gui) or (not pkg.required and args.optional):
        pkgs_final.append(pkg)

        
def main():
    for pkg in pkgs_final:
        pkg.create_install_job().exec()

if __name__ == "__main__":
    main()
