# Obtain application of interest.
set input to choose file with prompt "Please select a application to process:"

# Convert path to quoted posix path for shell script use.
set paths to quoted form of POSIX path of input

# Get the desired output location.
set output to choose folder with prompt "Please output folder:"

# Covert the path again.
set opaths to quoted form of POSIX path of output

# Execute the find operation for executable.
do shell script "find " & paths & "/* -perm +111 -type f ! -name \"*.*\" -exec cp {} " & opaths & " \\;" with administrator privileges
do shell script "find " & paths & "/* -perm +111 -type f -name \"*.dylib\" -exec cp {} " & opaths & " \\;" with administrator privileges

# Dump Function List
do shell script "nm " & opaths & "/* >> " & opaths & "/FunctionList.txt"

# Dump Dependancies
do shell script "otool -L " & opaths & "/* >> " & opaths & "/DependanciesList.txt"
