#!/bin/bash

FILE=/home/rancid/CVS/ncadmin/configs/$1,v
MD5SUM=/usr/bin/md5sum
MD5_CHECK_FILE=/tmp/$1.tmp


check_file(){
#       if test ! -e "$FILE" -a ! -f "$FILE"
        sudo ls $FILE &> /dev/null
        if [ $? != 0 ]
        then echo "ERROR: please enter your file" ; exit 1
        fi
        if [ -z $MD5_CHECK_FILE ]
        then echo "ERROR: MD5 file doesn't exist" ; exit 1
        fi
}

md5check(){
RANCID_MD5=$(sudo $MD5SUM $FILE | awk '{print $1}')
        if [ $? != 0 ]
        then echo "ERROR: MD5 check faild" ; exit 1
        fi
CHECK_FILE=$(sudo cat $MD5_CHECK_FILE)
        if [ -z $CHECK_FILE ]
        then echo "ERROR: check file doesn't exist" ; exit 1
        fi

if [ $RANCID_MD5 != $CHECK_FILE ]
then echo "Configuration changed"
else echo "OK"
fi

sudo $MD5SUM $FILE | awk '{print $1}' > $MD5_CHECK_FILE
}

check_file
md5check
