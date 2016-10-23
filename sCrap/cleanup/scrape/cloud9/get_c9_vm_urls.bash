# Theses lines will create a simple HTML file with a links to all the C9 virtual machines.

# The input file needs to be manually produced...
# log into Cloud9 at : https://c9.io/login
# copy/paste the view source into a file input.html
# Change <user_name> to whatever your user id is.

input_file='input.html'
output_file='test.txt'
user_name='koreahaos'


# cat $input_file | grep -Eo "https://ide.c9.io/$user_name/[a-zA-Z0-9./?=_-]*" | sort | uniq | awk '{print "      <li><a href=\""$1"\" target=\"blank\">"$1"</a></li>"}'  >> $output_file

#cat $input_file | grep -Eo "https://ide.c9.io/$user_name/[a-zA-Z0-9./?=_-]*" | sort | uniq | awk '{print $1 "\""$1"\" target=\"blank\">"$1""}'  >> $output_file


# In Progress! 

cat $input_file | grep -Eo "https://ide.c9.io/$user_name/[a-zA-Z0-9./?=_-]*" | sort | uniq | awk '{print $1 " \n "$(echo "$1" | sed -e "s#^http://##; s#/score/$##" ) }'  > $output_file

