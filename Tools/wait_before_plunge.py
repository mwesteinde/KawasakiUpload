# Read the program file
z_level = 700

with open("RoboDKpaths/WstFntHndlsHf.pg", "r") as file:
    program_lines = file.readlines()

# Function to check if a line represents an LMOVE under 532 in Z direction
def is_under_z(line):
    if "LMOVE" in line:
        coords = line.split(",")
        z_coordinate = float(coords[2])  # Assuming Z coordinate is at index 3
        return True, (z_coordinate < z_level and coords[2] != 0)
    return False, False

# Iterate through the lines to insert the new line before the appropriate LMOVE instructions
new_program_lines = []
over_z = True
for line in program_lines:
    if is_under_z(line)[1]:
        if over_z:
            new_program_lines.append("  WAIT SIG(1001) \n")  # Insert your new line here
            over_z = False
    elif is_under_z(line)[0]:
        over_z = True
    new_program_lines.append(line)
    

# Write the modified program back to the file
with open("Tools/WstFntHndlsHfMod.pg", "w") as file:
    file.writelines(new_program_lines)