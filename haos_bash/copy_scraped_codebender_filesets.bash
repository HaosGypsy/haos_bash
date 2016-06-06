mkdir ./test_of_copy
find ./codebender_files -maxdepth 1 -type d -name 'smart_software_project*' -exec cp -rf {} ./test_of_copy \;
