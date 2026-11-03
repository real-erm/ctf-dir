# Welcome to the ctf-dir Wiki

> **"A tool to quickly hop on CTF with an organized workspace, built around my personal set-up."**

`ctf-dir` is a fast CLI utility that removes the repetitive friction of creating folders, unpacking challenge archives, managing writeup assets, and opening your editor for every challenge during a CTF competition.

---

## Workspace Architecture

Every challenge initialized with `ctf-dir` follows this standard directory tree:

```
[domain-genre]/           # Optional category directory (created via -d)
└── <project-name>/
    ├── challenge/        # Extracted challenge files (binaries, code, pcaps)
    ├── flag.txt          # Target file for the discovered flag
    ├── src/              # The original challenge archive (.zip, .7z, etc.)
    └── writeup/
        ├── assets/
        │   └── images/   # Writeup screenshots, POC images, diagrams
        └── readme.md     # Writeup template
```

---

## How It Works Under the Hood

### 1. Challenge Archive Ingestion (`-i`)
When you direct `ctf-dir` to an archive:
```bash
ctf-dir -i ~/Downloads/challenge.zip
```
1. Resolves the absolute path of the input file.
2. Copies the untouched original archive into `src/` to serve as a reliable reference point.
3. Automatically detects the archive format (`.zip`, `.7z`, `.tar.gz`, `.tar.bz2`, `.tar.xz`, etc.) using available host utilities (`unzip`, `7z`, `tar`).
4. Extracts all challenge contents cleanly into the `challenge/` folder.

### 2. Automatic Space Management & Deletion
By default, downloaded challenge files in `~/Downloads` will quickly pile up and waste disk space.
- Once the archive is successfully copied to `src/` and unpacked to `challenge/`, `ctf-dir` deletes the original download from its source location.
- If you wish to preserve the downloaded file in place, pass the `-keep` flag:
  ```bash
  ctf-dir -i ~/Downloads/sample.7z -keep
  ```

### 3. Category Nesting (`-d`)
Organize your competition files by CTF genre or track:
```bash
ctf-dir -d "web" -i chall.zip
ctf-dir -d "reverse engineering" -i binary.7z
```
- If the domain directory exists, the challenge folder is nested inside it.
- If it does not exist, `ctf-dir` creates it automatically.
- Pre-fills the `- **Category:** <domain>` header in `writeup/readme.md`.

### 4. Direct Editor Integration (`-vs`)
Pass `-vs` to immediately launch **VSCodium** (or **VS Code**) targeting the newly generated challenge workspace:
```bash
ctf-dir -d "pwn" -i bof.zip -vs
```

---

## Command Reference

| Command / Flag | Behavior |
| :--- | :--- |
| `ctf-dir` | Interactive prompt; asks for project name |
| `ctf-dir <name>` | Scaffolds workspace directly with `<name>` |
| `-i, --import <file>` | Copies archive to `src/` and unpacks into `challenge/` |
| `-keep, --keep` | Skips deletion of the original compressed archive |
| `-d, --domain <genre>` | Nests workspace under `<genre>/<name>` |
| `-vs, --vs` | Opens workspace in VSCodium / VS Code |
| `-h, --help` | Displays command line usage and flag overview |

---

## Writeup Template (`writeup/readme.md`)
Each project automatically contains a standardized Markdown template with sections for challenge metadata, problem description, step-by-step solution, and the final flag.
