import re
import subprocess
from dataclasses import dataclass
from typing import Literal, NotRequired, Required, TypedDict

import distro

Scripts = list[str | list[str]]

WS = re.compile(r"\s+")


class InstallJob:
    pre_install_scripts: Scripts | None
    install_scripts: Scripts
    post_install_scripts: Scripts | None

    @staticmethod
    def dnf(
        package_name: str, pre: Scripts | None, post: Scripts | None
    ) -> "InstallJob":
        return InstallJob(
            install=[f"sudo dnf install -y {package_name}"], pre=pre, post=post
        )

    @staticmethod
    def scripts(
        scripts: Scripts, pre: Scripts | None, post: Scripts | None
    ) -> "InstallJob":
        return InstallJob(
            install=scripts,
            pre=pre,
            post=post,
        )

    @staticmethod
    def snap_classic(
        package_name: str, pre: Scripts | None, post: Scripts | None
    ) -> "InstallJob":
        return InstallJob(
            install=[f"sudo snap install --classic {package_name}"], pre=pre, post=post
        )

    @staticmethod
    def snap(
        package_name: str, pre: Scripts | None, post: Scripts | None
    ) -> "InstallJob":
        return InstallJob(
            install=[f"sudo snap install {package_name}"], pre=pre, post=post
        )

    @staticmethod
    def flatpak(
        package_name: str, pre: Scripts | None, post: Scripts | None
    ) -> "InstallJob":
        return InstallJob(
            install=[
                f"sudo flatpak install flathub {package_name}",
            ],
            pre=pre,
            post=post,
        )

    def exec(self) -> None:
        if self.pre_install_scripts is not None:
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

        if self.post_install_scripts is not None:
            for cmd in self.post_install_scripts:
                if isinstance(cmd, str):
                    subprocess.run(WS.split(cmd))
                else:
                    subprocess.run(cmd)

    def __init__(
        self,
        install=[],
        pre: Scripts | None = None,
        post: Scripts | None = None,
    ):
        self.pre_install_scripts = pre
        self.install_scripts = install
        self.post_install_scripts = post


InstallType = Literal[
    "snap", "snap-classic", "flatpak", "native-package-manager", "script"
]


class PackageName(TypedDict, total=False):
    all: Required[str]
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
        match self.install_type:
            case "snap" | "snap-classic":
                if self.package is None:
                    raise Exception("Package name is required for snap packages")

                pkg = ""
                if isinstance(self.package, str):
                    pkg = self.package
                else:
                    if "snap" in self.package:
                        pkg = self.package["snap"]
                    elif "all" in self.package:
                        pkg = self.package["all"]
                    else:
                        raise Exception("Package name is required for snap packages")

                if self.install_type == "snap":
                    return InstallJob.snap(
                        pkg,
                        pre=self.pre_install_scripts,
                        post=self.post_install_scripts,
                    )
                elif self.install_type == "snap-classic":
                    return InstallJob.snap_classic(
                        pkg,
                        pre=self.pre_install_scripts,
                        post=self.post_install_scripts,
                    )
                else:
                    raise Exception("Not implemented")

            case "native-package-manager":
                distro_id = distro.id()

                match distro_id:
                    case "fedora":
                        if self.package is None:
                            raise Exception(
                                "Package name is required for native package manager"
                            )

                        pkg = ""
                        if isinstance(self.package, str):
                            pkg = self.package
                        else:
                            if "dnf" in self.package:
                                pkg = self.package["dnf"]
                            elif "all" in self.package:
                                pkg = self.package["all"]
                            else:
                                raise Exception(
                                    "Package name is required for native package manager"
                                )

                        return InstallJob.snap(
                            pkg,
                            pre=self.pre_install_scripts,
                            post=self.post_install_scripts,
                        )
                    case _:
                        raise Exception("Not implemented")

            case "flatpak":
                if self.package is None:
                    raise Exception("Package name is required for flatpak")

                pkg = ""
                if isinstance(self.package, str):
                    pkg = self.package
                else:
                    if "flatpak" in self.package:
                        pkg = self.package["flatpak"]
                    elif "all" in self.package:
                        pkg = self.package["all"]
                    else:
                        raise Exception("Package name is required for flatpak")

                return InstallJob.flatpak(
                    pkg,
                    pre=self.pre_install_scripts,
                    post=self.post_install_scripts,
                )

            case "script":
                if self.install_scripts is None:
                    raise Exception("Install scripts are required to install a script")

                return InstallJob.scripts(
                    self.install_scripts,
                    pre=self.pre_install_scripts,
                    post=self.post_install_scripts,
                )
            case _:
                raise Exception("Not implemented")


Pkg = PackageInformation
