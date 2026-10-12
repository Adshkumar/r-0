<div align="center">

# r0

### A focused, native code editor for everyday development

[Source](https://github.com/Adshkumar/r0) · [Issues](https://github.com/Adshkumar/r0/issues) · [Build guide](docs/building-from-source.md)

</div>

r0 is a Rust-based desktop code editor maintained by Adarsh Kumar. It brings editing, language tools, terminal work, and remote development together in one native application.

## What you can do

- **Work with language servers:** use LSP-powered diagnostics, completions, and code actions.
- **Choose how you edit:** enable modal, Vim-style editing when it suits your workflow.
- **Keep tools close:** work with an integrated terminal, source control, and debugging panels.
- **Develop remotely:** connect to remote workspaces from the editor.
- **Extend the editor:** use WASI-compatible extensions and customize the interface with built-in themes.

## Get started

### Requirements

- Rust and Cargo matching the version specified in [`Cargo.toml`](Cargo.toml).
- The native development tools and libraries required for your operating system. Linux package requirements are listed in the [build guide](docs/building-from-source.md).

### Build and run

```powershell
git clone https://github.com/Adshkumar/r0.git
Set-Location r0
cargo run --profile release-lto --bin r0
```

To install the editor into Cargo's binary directory instead:

```powershell
cargo install --path . --bin r0 --profile release-lto --locked
```

On Linux and macOS, use the same Cargo commands in a shell. See the [build guide](docs/building-from-source.md) for Linux system dependencies and package builds.

## The r0 experience

r0 uses its own product name and visual identity, with theme-aware menus and editor colors. The project is maintained in the [r0 repository](https://github.com/Adshkumar/r0); its features continue to build on the editor foundation and ecosystem credited below.

## Extensions

The extension browser currently uses the Lapce plugin catalog. Extension names, descriptions, publisher names, and repository links are supplied by that catalog. r0 displays those details while preserving the original extension identifiers and publisher credits.

## Project and licensing

r0 is maintained by [Adarsh Kumar](https://github.com/Adshkumar).

This project is based on [Lapce](https://github.com/lapce/lapce), created by Dongdong Zhou and contributors. It retains the upstream Apache-2.0 license and required notices. Dependencies, bundled components, and extensions may have their own licenses and attribution requirements; see their respective project information.

See [`LICENSE`](LICENSE) for the license text.
