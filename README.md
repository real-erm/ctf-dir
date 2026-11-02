# ctf-dir

> **A tool to quickly hop on CTF with an organized workspace, built around my personal set-up.**

`ctf-dir` is a fast, lightweight CLI utility for Linux that scaffolds a consistent, standardized folder scheme for CTF challenges, unpacks challenge archives, archives original source references, and launches your code editor in one command.

---

## Workspace Layout

When initialized, `ctf-dir` creates the following clean hierarchy:

```text
[domain-genre]/           # Optional parent directory (when using -d / --domain)
└── <project-name>/
    ├── challenge/        # Extracted files from the challenge archive
    ├── flag.txt          # Quick destination for the solved flag
    ├── src/              # Original immutable challenge archive (.zip / .7z / .tar.gz)
    └── writeup/
        ├── assets/
        │   └── images/   # Screenshots, solve diagrams, and writeup assets
        └── readme.md     # Pre-templated writeup document
```

The generated `writeup/readme.md` is automatically initialized with standard metadata fields:
```markdown
# <challenge-name>

## Overview
- **Category:** <domain-if-specified>
- **Points:** 
- **Difficulty:** 

## Description
- 

## Solution
- 

## Flag
```
flag{}
```
```

---

## Key Features

- **Standardized Scheme:** Never worry about inconsistent CTF layouts or misplaced screenshots across different categories.
- **Archive Extraction (`-i <archive>`):** Unpacks `.zip`, `.7z`, `.tar.gz`, `.tar.bz2`, `.tar.xz`, and `.gz` archives directly into `challenge/`.
- **Reference Preservation:** Copies the untouched compressed archive into `src/` so you always have the original challenge reference.
- **Auto Clean-up & Keep (`-keep`):** Automatically deletes the downloaded archive (e.g., from `~/Downloads/`) after successful import and extraction to prevent clutter. Pass `-keep` to retain it.
- **Domain & Genre Categorization (`-d <genre>`):** Nest challenges neatly into category directories (e.g. `web`, `crypto`, `pwn`, `app sec`). Automatically creates the genre folder if it doesn't exist, or adds to it if it does.
- **VSCodium / VS Code Launch (`-vs`):** Immediately opens the newly initialized challenge workspace in VSCodium (`codium`) or VS Code (`code`).
- **Smart Naming:** Prompts for project name interactively if omitted, suggesting the archive base name as the default.

---

## Installation

### One-Line Quick Install
```bash
curl -fsSL https://raw.githubusercontent.com/real-erm/ctf-dir/main/install.sh | bash
```

### From Source
```bash
git clone https://github.com/real-erm/ctf-dir.git
cd ctf-dir
./install.sh
```

The script installs to `~/.local/bin/ctf-dir`. Make sure `~/.local/bin` is in your `$PATH`.

### Uninstall
```bash
./install.sh --uninstall
# or manually:
rm -f ~/.local/bin/ctf-dir
```

---

## Usage

```bash
ctf-dir [-vs] [-i <archive>] [-keep] [-d <domain>] [PROJECT_NAME]
```

### Options
| Flag | Description |
| :--- | :--- |
| `-i, --import <file>` | Import a challenge archive (`.zip`, `.7z`, etc.), copy to `src/`, and unpack into `challenge/` |
| `-keep, --keep` | Keep the original compressed archive (default deletes it after extraction) |
| `-d, --domain <genre>`| Place challenge inside a genre/category subfolder (e.g. `web`, `pwn`, `crypto`) |
| `-vs, --vs` | Automatically open the newly generated workspace in VSCodium / VS Code |
| `-h, --help` | Display help and usage information |

---

## Examples

### 1. Simple Interactive Creation
```bash
ctf-dir
# Prompts: Enter CTF project name:
```

### 2. Direct Challenge Name
```bash
ctf-dir buffer-overflow-101
```

### 3. Import Downloaded Archive & Launch Editor
```bash
ctf-dir -i ~/Downloads/chall.zip -vs
```
*Copies `chall.zip` to `src/`, unpacks it into `challenge/`, deletes the original from `~/Downloads/`, and opens in VSCodium.*

### 4. Categorize by Genre & Keep Original Archive
```bash
ctf-dir -i ~/Downloads/firmware.7z -d "reverse engineering" -keep -vs
```
*Creates `reverse engineering/firmware/`, extracts into `challenge/`, retains the downloaded `.7z`, and pre-fills `Category: reverse engineering` in `readme.md`.*

---

## Dependencies
- `bash` (v4+)
- `unzip` (optional, for `.zip` extraction)
- `7z` / `7za` (optional, for `.7z` extraction)
- `tar` / `bsdtar` (optional, for `.tar.*` extraction)
- `codium` / `code` (optional, for `-vs` flag)

---

## License
MIT License. See [LICENSE](LICENSE) for details.
