# GitHub Finder (gf) Installer

A simple Bash script to **install `gf` (GitHub Finder)**, download custom templates, and configure Zsh completions.

---

```
┳┳┓┏┳┓┏┓┓ ┏┓┏┓┳┓┏┓┏┓┏┓
┃┃┃ ┃ ┣ ┃ ┣ ┃┃┃┃┃┃┃┫┃┃
┻┛┗ ┻ ┗┛┗┛┗┛┗┛┛┗┗╋┗┛┗╋
```

## Features

- Installs `gf` via Go.
- Downloads and extracts custom `gf` templates.
- Sets up Zsh completions automatically.
- Color-coded terminal output for clear status messages.

---

## Requirements

- [Go](https://golang.org/doc/install)  
- `wget`  
- `unzip`  
- Zsh (optional, for completion)

---

## Installation

1. Clone this repository:

```bash
wget https://raw.githubusercontent.com/INTELEON404/random-tips/refs/heads/main/GF-INSTALL/gf.sh
````

2. Make the installer executable:

```bash
chmod +x install-gf.sh
```

3. Run the installer:

```bash
./install-gf.sh
```

---

## How It Works

* **gf Installation**: Uses `go install github.com/tomnomnom/gf@latest`.
* **Template Download**: Fetches templates from:

  ```
  https://github.com/INTELEON404/AppStore/raw/refs/heads/main/gf.zip
  ```
* **Extraction**: Extracted to `~/.gf`.
* **Zsh Completion**: Adds `source <gf-completion>` to `~/.zshrc` if missing.

---

## Usage

Restart your terminal or source Zsh configuration:

```bash
source ~/.zshrc
```

Use `gf` with any downloaded template:

```bash
gf <pattern_name>
```

Templates are stored in `~/.gf`.

---

## Script Output

The script provides **color-coded messages**:

* `[+]` Success (green)
* `[!]` Warning (yellow)
* `[*]` Info (blue)
* `[-]` Error (red)

---

## Notes

* Ensure Go is installed and available in your `$PATH`.
* The script overwrites existing templates in `~/.gf`.
* Bash users may need to manually source the completion file.

---

## License

MIT License. See [LICENSE](LICENSE) for details.

```

This version is:

- **Cleaner:** Less repetitive, clear headers, concise sentences.  
- **Professional:** GitHub-friendly formatting.  
- **Readable:** Focused on instructions, outputs, and usage.  

I can also **add a “banner preview and script demo” section** showing the ASCII banner and colored messages—this makes it visually appealing for GitHub.  

Do you want me to add that?
```
