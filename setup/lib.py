import re
import subprocess
from dataclasses import dataclass
from typing import Literal, NotRequired, TypedDict

import distro

Scripts = list[str | list[str]]

WS = re.compile(r"\s+")


class InstallJob:
    pre_install_scripts: Scripts
    install_scripts: Scripts
    post_install_scripts: Scripts

    @staticmethod
    def dnf(package_name: str, pre: Scripts, post: Scripts) -> "InstallJob":
        return InstallJob(
            install=[f"sudo dnf install -y {package_name}"], pre=pre, post=post
        )

    @staticmethod
    def script(script: str, pre: Scripts, post: Scripts) -> "InstallJob":
        return InstallJob(install=[script])

    @staticmethod
    def snap_classic(package_name: str, pre: Scripts, post: Scripts) -> "InstallJob":
        return InstallJob(
            install=[f"sudo snap install --classic {package_name}"], pre=pre, post=post
        )

    @staticmethod
    def snap(package_name: str, pre: Scripts, post: Scripts) -> "InstallJob":
        return InstallJob(
            install=[f"sudo snap install {package_name}"], pre=pre, post=post
        )

    @staticmethod
    def flatpak(package_name: str, pre: Scripts, post: Scripts) -> "InstallJob":
        return InstallJob(
            install=[
                f"sudo flatpak install flathub {package_name}",
            ],
            pre=pre,
            post=post,
        )

    def exec(self) -> None:
        for cmd in self.pre_install_scripts:
            if isinstance(cmd, str):
                subprocess.run(WS.split(cmd))
            else:
                subprocess.run(cmd)

        for cmd in self.install_scripts:
            if isinstance(cmd, str):
                subprocess.run(WS.split(cmd))
            else:
                subprocess.run(cmd)

        for cmd in self.post_install_scripts:
            if isinstance(cmd, str):
                subprocess.run(WS.split(cmd))
            else:
                subprocess.run(cmd)

    def __init__(
        self,
        install=[],
        pre: Scripts = [],
        post: Scripts = [],
    ):
        self.pre_install_scripts = pre
        self.install_scripts = install
        self.post_install_scripts = post


InstallType = Literal[
    "snap", "snap-classic", "flatpak", "native-package-manager", "script"
]


class PackageName(TypedDict, total=False):
    all: NotRequired[str]
    snap: NotRequired[str]
    flatpak: NotRequired[str]
    dnf: NotRequired[str]


@dataclass
class PackageInformation:
    executable: str
    install_type: InstallType | None = None
    package: str | PackageName | None = None
    pre_install_scripts: Scripts | None = None
    install_scripts: Scripts | None = None
    post_install_scripts: Scripts | None = None

    def create_install_job(self) -> InstallJob:
        pass


pkg = PackageInformation
