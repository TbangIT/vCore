# Using Nix in this Image
This template supports Nix out-of-the-box, enabling declarative package management alongside traditional RPMs and containerized services.

## 💡 When to Use What

| **Method**           | **Example**                                     | **Use Cases**                                | **Benefits**                                |
|----------------------|--------------------------------------------------|-----------------------------------------------|----------------------------------------------|
| **Base Image RPMs**  | Kernel updates, GPU drivers, systemd, security tools | System-level components that need tight integration | Stability, system integration, trusted updates |
| **Nix Packages**     | `ffmpeg`, `ripgrep`, dev environments (`rustc`, `go`) | Developer tools, CLI utilities, ad-hoc installs | Reproducibility, isolation, rollback         |
| **Podman Containers**| Web services, databases, media servers (e.g., Vaultwarden) | Services with persistent runtime environments   | Sandboxing, portability, runtime consistency |

## ❓ Why Not Just Use NixOS or Containers?
TODO: Add a rationale explaining the hybrid appeal of bootc-based systems (e.g., combining atomic host upgrades with Nix and container flexibility without needing a full NixOS setup).

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