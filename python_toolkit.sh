#!/usr/bin/env bash

# Keep track of every Python file we successfully create
created_files=()

# ------------------------------------------------------------
# create_py <filename>
# Creates a new .py file with a shebang and makes it executable.
# Skips the file if it already exists or doesn't end with .py.
# ------------------------------------------------------------
create_py() {
  local file=$1

  # Only process files that end with .py
  if [[ "$file" == *.py ]]; then

    # Don't overwrite an existing file
    if [[ -e "$file" ]]; then
      echo "Skipping '$file': File already exists" >&2
      return
    fi

    # Create the file with a Python shebang
    if cat >"$file" <<"EOF"; then
#!/usr/bin/env python3

def main():
  ...
      
if __name__ == "__main__":
  main()
EOF
      chmod u+x "$file" # make it executable for the user
      echo "Successfully created: $file"
      created_files+=("$file") # remember it for the summary
    else
      echo "Error: Failed to create '$file'" >&2
    fi

  else
    echo "Skipping '$file': Not a .py file" >&2
  fi
}

# ------------------------------------------------------------
# has_arg
# Called when the user passes one or more filenames as arguments.
# Example: ./script.sh hello.py world.py
# ------------------------------------------------------------
has_arg() {
  for file in "$@"; do
    create_py "$file"
  done
}

# ------------------------------------------------------------
# has_no_arg
# Called when no arguments are given.
# Asks the user for a text file that contains a list of .py names
# (one per line) and creates each of them.
# ------------------------------------------------------------
has_no_arg() {
  local file

  # Ask for the name of the list file
  read -rp $'What is the name of the file that has the list of python files \n>' file

  # Make sure the list file actually exists
  if ! [[ -f "$file" ]]; then
    echo "file $file is invalid or not found" >&2
    exit 1
  fi

  # Read the list file line by line
  while read -r item; do
    [[ -z "$item" ]] && continue # skip empty lines
    create_py "$item"
  done <"$file"
}

# ------------------------------------------------------------
# main
# Entry point of the script.
# Decides whether to use command-line arguments or a list file,
# then prints a summary of what was created.
# ------------------------------------------------------------
main() {
  if (($# < 1)); then
    has_no_arg # no arguments → ask for a list file
  else
    has_arg "$@" # arguments given → use them directly
  fi

  # Print a clear summary at the end
  echo ""
  echo "Summary:"
  for file in "${created_files[@]}"; do
    echo " - $file"
  done
  echo "Total: ${#created_files[@]} Python file(s) created."
}

# Start the script, passing along any command-line arguments
main "$@"
