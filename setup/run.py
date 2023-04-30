#!/usr/bin/env python

import shutil
import subprocess
from typing import Literal, NotRequired, TypedDict, Unpack

import distro

PackageType = Literal["native", "snap", "flatpak"]


class PackageNameDict(TypedDict, total=False):
    dnf: NotRequired[str]
    snap: NotRequired[str]
    flatpak: NotRequired[str]


class PostInstallScriptsDict(TypedDict, total=False):
    fedora: NotRequired[list[str]]


class InstallJob:
    executable_name: str
    package_name: PackageNameDict
    args: list[str]
    post_install_scripts: PostInstallScriptsDict
    type: PackageType

    @staticmethod
    def snap(
        exe_name: str,
        snap: str,
        args: list[str] = [],
        post_install: PostInstallScriptsDict = {},
    ) -> "InstallJob":
        return InstallJob(exe_name, args, post_install, type="snap", snap=snap)

    @staticmethod
    def snap_classic(
        exe_name: str,
        snap: str,
        args: list[str] = [],
        post_install: PostInstallScriptsDict = {},
    ) -> "InstallJob":
        return InstallJob(
            exe_name, args + ["--classic"], post_install, type="snap", snap=snap
        )

    @staticmethod
    def flatpak(
        exe_name: str,
        flatpak: str,
        args: list[str] = [],
        post_install: PostInstallScriptsDict = {},
    ) -> "InstallJob":
        return InstallJob(exe_name, args, post_install, type="flatpak", flatpak=flatpak)

    def __init__(
        self,
        exe_name: str,
        args: list[str] = [],
        post_install: PostInstallScriptsDict = {},
        type: PackageType = "native",
        **package_name: Unpack[PackageNameDict],
    ):
        self.executable_name = exe_name
        self.package_name = package_name
        self.post_install_scripts = post_install
        self.type = type
        self.args = args
        pass


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
    InstallJob.snap_classic(
        "flutter",
        args=["--classic"],
        snap="flutter",
    ),
    InstallJob.snap_classic("telegram-desktop", snap="telegram-desktop"),
]


def install_dnf_package(package_name: str) -> None:
    subprocess.run(["sudo", "dnf", "install", "-y", package_name])


def install_native_package(job: InstallJob) -> None:
    distro_id = distro.id()
    match (distro_id):
        case "fedora":
            if "dnf" in job.package_name:
                install_dnf_package(job.package_name["dnf"])
            else:
                raise Exception(f"{job.package_name}: DNF package name not specified")
        case _:
            raise Exception(f"Unsupported distro: {distro_id}")


def install_snap_package(job: InstallJob) -> None:
    if "snap" in job.package_name:
        subprocess.run(
            [
                "sudo",
                "snap",
                "install",
                job.package_name["snap"],
                *job.args,
            ]
        )
    else:
        raise Exception(f"{job.package_name}: Snap package name not specified")


def install_flatpak_package(job: InstallJob) -> None:
    if "flatpak" in job.package_name:
        subprocess.run(
            [
                "sudo",
                "flatpak",
                "flathub",
                "install",
                job.package_name["flatpak"],
                *job.args,
            ]
        )
    else:
        raise Exception(f"{job.package_name}: Flatpak package name not specified")


def run_post_install(job: InstallJob) -> None:
    distro_id = distro.id()
    match (distro_id):
        case "fedora":
            if "fedora" in job.post_install_scripts:
                for cmd in job.post_install_scripts["fedora"]:
                    subprocess.run(["sudo", "sh", "-c", cmd])
        case _:
            raise Exception(f"Unsupported distro: {distro_id}")


def run(job: InstallJob) -> None:
    match (job.type):
        case "native":
            install_native_package(job)
        case "snap":
            install_snap_package(job)
        case "flatpak":
            install_flatpak_package(job)

    run_post_install(job)


def run_install_jobs(install_jobs: list[InstallJob]) -> None:
    for install_job in install_jobs:
        if shutil.which(install_job.executable_name) is None:
            print(f"Installing {install_job.executable_name}")
            run(install_job)
        else:
            print(f"{install_job.executable_name} is already installed")


if __name__ == "__main__":
    run_install_jobs(jobs)
