import re
import subprocess
from dataclasses import dataclass
from typing import Literal, NotRequired, Required, TypedDict

import distro
import os

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

    @staticmethod
    def noop() -> "InstallJob":
        return InstallJob(install=[])

    def exec(self) -> None:
        if self.pre_install_scripts is not None:
            for cmd in self.pre_install_scripts:
                if isinstance(cmd, str):
                    os.system(cmd)
                else:
                    subprocess.run(cmd)

        for cmd in self.install_scripts:
            if isinstance(cmd, str):
                os.system(cmd)
            else:
                subprocess.run(cmd)

        if self.post_install_scripts is not None:
            for cmd in self.post_install_scripts:
                if isinstance(cmd, str):
                    os.system(cmd)
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
    package_name: str | PackageName | None = None
    pre_install_scripts: Scripts | None = None
    install_scripts: Scripts | None = None
    post_install_scripts: Scripts | None = None
    has_gui: bool = False
    required: bool = False

    def create_install_job(self) -> InstallJob:
        pkg_name = self.package_name or self.executable
        install_type = self.install_type or "native-package-manager"

        # check if executable is installed
        if subprocess.run(["which", self.executable]).returncode == 0:
            return InstallJob.noop()

        match install_type:
            case "snap" | "snap-classic":
                if pkg_name is None:
                    raise Exception("Package name is required for snap packages")

                pkg = ""
                if isinstance(pkg_name, str):
                    pkg = pkg_name
                else:
                    if "snap" in pkg_name:
                        pkg = pkg_name["snap"]
                    elif "all" in pkg_name:
                        pkg = pkg_name["all"]
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
                    case "fedora" | "fedoraremixforwsl":
                        if pkg_name is None:
                            raise Exception(
                                "Package name is required for native package manager"
                            )

                        pkg = ""
                        if isinstance(pkg_name, str):
                            pkg = pkg_name
                        else:
                            if "dnf" in pkg_name:
                                pkg = pkg_name["dnf"]
                            elif "all" in pkg_name:
                                pkg = pkg_name["all"]
                            else:
                                raise Exception(
                                    "Package name is required for native package manager"
                                )

                        return InstallJob.dnf(
                            pkg,
                            pre=self.pre_install_scripts,
                            post=self.post_install_scripts,
                        )
                    case _:
                        raise Exception(f"Native package manager installation for '{distro_id}' is not yet implemented")

            case "flatpak":
                if pkg_name is None:
                    raise Exception("Package name is required for flatpak")

                pkg = ""
                if isinstance(pkg_name, str):
                    pkg = pkg_name
                else:
                    if "flatpak" in pkg_name:
                        pkg = pkg_name["flatpak"]
                    elif "all" in pkg_name:
                        pkg = pkg_name["all"]
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
