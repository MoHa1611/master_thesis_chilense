--------------script--------------------------

find . -type f -name "dem_*.tif" -exec mv {} /data/proj/chilense/30_genomes_outputs/Moritz/climatic_variables/elevation_data/ \;

--------------script--------------------------
########################## Erläuterung #################################
Move all dem_*.tif files:

For this, you can use the mv command in combination with the find command to identify and move the files.

This command searches for all files starting with "dem_" and ending with ".tif" in the current directory and its subdirectories, then moves them to the specified directory.

The . after find specifies the starting directory for the search, which in this case is the current directory. The find command by default performs a recursive search through all subdirectories unless otherwise specified.

So, by using find ., you are instructing the command to start searching in the current directory and recursively search through all its subdirectories.

The -type f option specifies that you're interested in files (not directories or other types of filesystem objects). The -name "dem_*.tif" option specifies the name pattern to match against.

Directories:
Use -type d to search for directories.

Symbolic links:
Use -type l to search for symbolic links.

Example:
find . -type l -name "my_symlink_name"


    Regular files:
    As previously mentioned, use -type f to search for regular files.

    Block devices:
    Use -type b to search for block devices.

    Character devices:
    Use -type c to search for character devices.

    Pipes (FIFOs):
    Use -type p to search for pipes.

    Sockets:
    Use -type s to search for sockets.

    Any type:
    If you don't specify a -type option, find will search for any type of filesystem object that matches the other given criteria.

Remember, you can combine these criteria with other find options, such as -name for name patterns, -mtime for modification time, -size for file size, and many others to refine your search.
###########################################################################
2. Rename the variables:

For this, you can use the rename command. Here's how you can do it:


--------------script--------------------------

cd /data/proj/chilense/30_genomes_outputs/Moritz/climatic_variables/selected_vars/missing_selvar_Ne

# Loop through the directories
for dir in 12.7kya 1.6kya 2.6kya 4.3kya 6.4kya 9.1kya; do
    cd $dir
    # Loop through files and rename
    for file in *.tif; do
        # Use parameter expansion to get the desired name
        new_name="${file%%_*}.tif"
        mv "$file" "$new_name"
    done
    cd /data/proj/chilense/30_genomes_outputs/Moritz/climatic_variables/selected_vars/missing_selvar_Ne
done
--------------script--------------------------
${file%%_*}: This will strip the longest match of _* from the back of $file. For instance, if $file is bio03_-6.tif, the result of ${file%%_*} will be bio03. 
Adding .tif will give the desired filename.





check out later
--------------script--------------------------

cd /data/proj/chilense/30_genomes_outputs/Moritz/climatic_variables/selected_vars/missing_selvar_Ne
# Loop through the directories
for dir in 12.7kya 1.6kya 2.6kya 4.3kya 6.4kya 9.1kya; do
    # Change to the directory
    cd $dir
    # Rename the files
    rename 's/_[^_]+\.tif$/.tif/' bio*.tif
    # Go back to the parent directory
    cd /data/proj/chilense/30_genomes_outputs/Moritz/climatic_variables/selected_vars/missing_selvar_Ne
done


--------------script--------------------------
rename 's/_[^_]+\.tif$/.tif/' bio*.tif

    rename: This command is used for renaming files.

    's/_[^_]+\.tif$/.tif/': This is a Perl regular expression passed to the rename command to specify the renaming pattern.

        s: The s at the beginning indicates a substitution operation.

        /_[^_]+\.tif$/: This is the pattern we're looking to match and replace.

            _: Matches an underscore.

            [^_]: This is a character class that matches any character that is NOT an underscore.

            +: Matches one or more of the preceding element (in this case, any character that isn't an underscore).

            \.tif: Matches the string ".tif". The backslash before the dot is necessary because a dot is a special character in regular expressions that matches any single character. By using \., we're escaping the dot to match an actual dot.

            $: Matches the end of the string (in this case, the end of the filename).

        /.tif/: This is the replacement pattern. It says to replace the matched pattern with just ".tif".

    bio*.tif: Specifies which files the rename command should operate on. In this case, it's any file in the current directory that starts with "bio" and ends with ".tif".

In simpler terms, this command looks for files starting with "bio" and ending in .tif that have an underscore followed by any characters before the .tif extension. It then renames these files by removing the underscore and any characters between the underscore and .tif, leaving just the "bio" prefix and the .tif extension.



