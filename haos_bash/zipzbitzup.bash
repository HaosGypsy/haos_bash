if [ -z "$1" ]
then
    PUT_THEM_HERE="PUT_THEM_HERE"
    ZIPS_ARE_HERE="ZIPS_GO_HERES"
else
    PUT_THEM_HERE="$1"
    if [ -z "$2" ]
    then
        ZIPS_ARE_HERE="ZIPS_GO_HERES"
    else
        ZIPS_ARE_HERE="$2"
    fi
fi



function zip_up_everything_in_dir_1_into_dir_2_numd() {
    echo "directory \$1 : $1 <- Contents get zipped."
    echo "directory \$2 :-> $2 <- Zipped are Contents."
    
    read -p "If thats sounds good, press the 'Y' key. (No lower case this time, you better be sure..) : " users_wanz_zipinz

    if [[ "$users_wanz_zipinz"  == "Y" ]]
    then
        echo 'zipping!'
        zip -r "$2" ./"$1"
    else
        echo 'nopz!!'
    fi
}

cd $GOPATH

mkdir $PUT_THEM_HERE

read -p "Please press the 'y' (or 'Y') key once you have moved the files into that directory." users_dizician_gardin_z_zipinz

if [[ "$users_dizician_gardin_z_zipinz"  =~ ^[Yy]$ ]]
then
    echo "zipS-it-is then!"
    zip_up_everything_in_dir_1_into_dir_2_numd "$1" "$2"
else
    echo "Then i will just zip on outa here!"
fi

echo "Bye now!"



