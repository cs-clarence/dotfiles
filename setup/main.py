#!/usr/bin/env python

from lib import *

pkgs = [
    pkg("nvim", package="neovim"),
    pkg("git"),
    pkg("clang"),
    pkg("cmake"),
    pkg("shfmt"),
    pkg("kitty"),
    pkg("firefox"),
    pkg("qbittorrent"),
    pkg("vlc"),
    pkg("flutter", install_type="snap-classic"),
]


def main():
    jobs = [
        InstallJob(
            "snap",
            post_install={"fedora": ["sudo ls -s /var/lib/snapd/snap /snap"]},
            dnf="snapd",
        ),
        InstallJob("nvim", dnf="neovim"),
        InstallJob("git", dnf="git"),
        InstallJob("clang", dnf="clang"),
        InstallJob("cmake", dnf="cmake"),
        InstallJob("shfmt", dnf="shfmt"),
        InstallJob("kitty", dnf="kitty"),
        InstallJob("firefox", dnf="firefox"),
        InstallJob("qbittorent", dnf="qbittorrent"),
        InstallJob("vlc", dnf="vlc"),
        InstallJob.snap_classic(
            "flutter",
            snap="flutter",
        ),
        InstallJob.snap_classic("telegram-desktop", snap="telegram-desktop"),
    ]
    run_install_jobs(jobs)


if __name__ == "__main__":
    main()
