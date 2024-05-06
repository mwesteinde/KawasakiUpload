import os

folder_path = "/path/to/your/folder"  # Update this with the path to your folder
output_file = "formatted_files.txt"

# Function to format a file name
def format_file_name(file_name):
    return f"timeout=240\nsendln 'LOAD robodkpaths\\{file_name}'\nwait 'File load'\n"

# Get all file names in the folder
file_names = os.listdir(folder_path)

# Write formatted file names to the output file
with open(output_file, "w") as f:
    for file_name in file_names:
        formatted_line = format_file_name(file_name)
        f.write(formatted_line)