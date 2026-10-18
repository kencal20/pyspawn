#!/usr/bin/env python3
# create a new file
# make sure the file has the permissions chmod u+x <filename> in bash
# then add the template
##!/usr/bin/env python3
#
# def main():
#   print('hello world ')
#
# if __name__ =="__main__":
#   main()

import os
import sys


def create_from_file():
    valid_files = []
    filename = input("What is the name of the file that has the .py files: ")
    if not filename:
        print("filename field cannot be ledt empty")
        return
    try:
        with open(filename) as file:
            for line in file:
                line = line.strip()
                if not line:
                    continue
                if not line.endswith(".py"):
                    print(f"file {line} does not end with .py")
                    continue
                valid_files.append(line.strip())
        return valid_files

    except (FileNotFoundError, OSError):
        print(f"file {filename} not found or is corrupted")
        return


def create_project(filename):

    template = """#!/usr/bin/env python3
        
def main():
    print("Hello, world")

if __name__=="__main__":
    main()
    """

    try:
        with open(filename, "w") as file:
            file.write(template)

        os.chmod(filename, 0o755)
    except FileExistsError:
        print("File already exist try another name")


def main():
    files_created = []
    if len(sys.argv) == 1:
        files = create_from_file()
        if files:
            for line in files:
                create_project(line)
                files_created.append(line)
    elif len(sys.argv) == 2:
        filename = sys.argv[1]
        if not filename.endswith(".py"):
            print(f"{filename} is not a python file therefore creation is not possible")
            return
        create_project(filename)
        files_created.append(filename)

    else:
        print("Number of arguemnts is more than required")
        return

    if len(files_created) > 0:
        print("Summary")
        for file in files_created:
            print(f"- {file} has been created successfully")
        print(f"{len(files_created)} files created")


if __name__ == "__main__":
    main()
