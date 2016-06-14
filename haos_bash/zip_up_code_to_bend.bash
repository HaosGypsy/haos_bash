# This script will Create a zip file that can be downloaded to your desktop and
# then dropped into a the broswer window for codebender.

# It's not perfect, but what is?

parent_folder_path="$GOPATH"
folder_to_zip="$parent_folder_path/a_design_for_ewha/"

new_zip_file_name="a_manage_haos.zip"
new_zip_file_path_and_name="$folder_to_zip/$new_zip_file_name"

# Move to directory where sketch is stored.
#cd "$parent_folder_path"

# Remove any prevoius zip present
if [ -e "$new_zip_file_path_and_name" ]
then
    rm "$new_zip_file_path_and_name"
fi

echo 
# Zip all the files useable in the CodeBender IDE
# zip -9 -y -r -q -j "$zip_file_name" "$folder_to_zip"/ -i '*.ino' '*.cpp' '*.h'
zip -9 -y -r -q -j "$new_zip_file_path_and_name" "$folder_to_zip"/ -i '*.ino' '*.cpp' '*.h'


