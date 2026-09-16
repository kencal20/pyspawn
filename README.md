# create_py — Batch Create Executable Python Files

A small Bash utility that creates new Python files with a proper shebang (`#!/usr/bin/env python3`) and makes them executable. Useful when starting multiple practice scripts or project files at once.

---

## Features

- Create one or many `.py` files in a single command
- Two usage modes:
  1. **Arguments mode** — pass filenames directly
  2. **List-file mode** — feed a text file containing one filename per line
- Automatically skips:
  - Files that already exist (no overwrites)
  - Names that do not end in `.py`
- Adds the standard Python shebang
- Sets the user-executable bit (`chmod u+x`)
- Prints a clear summary of every file that was created

---

## Requirements

- Bash 4+ (uses arrays and `[[ ]]`)
- Write permission in the current directory

---

## Installation

```bash
# Make the script executable (only needed once)
chmod +x create_py.sh

# Optional: place it somewhere on your PATH
mkdir -p ~/bin
cp create_py.sh ~/bin/create_py
