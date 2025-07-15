# Using Nix in this Image
This template supports Nix out-of-the-box, enabling declarative package management alongside traditional RPMs and containerized services.

## 💡 When to Use What

| **Method**           | **Examples**                                     | **Use Cases**                                | **Benefits**                                |
|----------------------|--------------------------------------------------|-----------------------------------------------|----------------------------------------------|
| **Base Image RPMs**  | Kernel updates, GPU drivers, systemd, security tools | Essential system-level components that need tight integration with the OS | Stability, system integration, trusted updates |
| **Nix Packages**     | ffmpeg, ripgrep, dev environments | Developer tools, CLI utilities, ad-hoc installs | Reproducibility, isolation, rollback         |
| **Podman Containers**| Web services, databases | Services with persistent runtime environments   | Sandboxing, portability, runtime consistency |

**TL;DR** You do you
I see nix as supplementing bootc. Want to try a tool without including it in the base image? Use nix shell. Want to permanently add it to the image? Declare it in an install script. 

## ❓ Why Not Just Use NixOS or Containers?
I spent too long thinking about this. Ultimately, I wanted something that just worked without the extra fuss. 
While I love NixOS and its declarative model, it’s still ironing out some rough edges—especially around sd-boot's boot counting and automatic rollback. Until that stabilizes, it doesn't quite provide the level of self-healing I’m looking for.
Also, I find the idea of bootable containers to be really interesting. If you’re already using containers for services, it allows you to take that knowledge further. It gives you the NixOS level declarative model without needing to necessarily understand the Nix language.

## 🛠️ Justfile Commands
The provided Justfile includes commands and aliases to streamline building and testing:

## Command	Description
just build	Builds your custom container image
just build-iso	Generates a bootable ISO from your OCI image
just run-vm-qcow2	Boots a VM from a QCOW2 image
just spawn-vm	Launches a VM using systemd-vmspawn

## 🌐 Community
bootc discussion forums

## 📦 ArtifactHub
Use the provided artifacthub-repo.yml to index your custom image on ArtifactHub. Benefits include:

Discoverability for others building on similar foundations

Community visibility and collaboration

A place to show off your README and reach your audience

## 🧪 Community Examples
Explore real-world bootc-based images:

m2Giles' OS

bOS

Homer

Amy OS

VeneOS

🚀 Next Steps
Start customizing your image by editing:

Containerfile: Add RPMs, files, layers, etc.

GitHub workflows: Automate builds, ISO creation, and signing

Leverage Nix, Podman, and RPM strategically to build secure, reproducible, and efficient systems