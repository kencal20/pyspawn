# Python Toolkit (`pyspawn`)

A collection of lightweight utilities (in both **Python** and **Bash**) designed to quickly spin up new Python scripts complete with proper shebangs (`#!/usr/bin/env python3`), standard boilerplate code, and user-executable permissions.

---

## Utilities Included

1. **`pyspawn.py` (Python Core)** — Recommended core script for bootstrapping `.py` files using Python itself.
2. **`python_toolkit.sh` (Bash Version)** — The original shell script version for POSIX environments.

---

## Features

- **Flexible Input Modes**:
  1. **Argument Mode** — Pass one or more filenames directly via the command line.
  2. **Interactive List Mode** — Run with no arguments to read filenames line-by-line from a text file.
- **Safety Checks**:
  - Automatically skips files that already exist to prevent accidental overwrites.
  - Validates that target names end with `.py`.
- **Automatic Setup**:
  - Injects a standard Python template with a `main()` function block.
  - Grants executable permissions automatically (`chmod u+x` / `0o755`).
- **Summary Report**: Prints a clean breakdown of all successfully created files at the end.

---

## Installation & Setup

Make both scripts executable and optionally link them to your path:

```bash
# Make them executable
chmod +x pyspawn.py python_toolkit.sh

# Example: Link the Python version globally as 'pyspawn'
sudo ln -sf "$(pwd)/pyspawn.py" /usr/local/bin/pyspawn
