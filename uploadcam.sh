#!/bin/bash

imgsnap="/Users/cflood/bin/ImageSnap-v0.2.5/imagesnap -q"
username=YOURUSER
host=YOURHOST
lpath=~/bin/archive
rpath=/home/$username/public_html/cam
interval=45

while true; do
    date=`date +%d%m%y%H%M%S`
    echo -n "Capturing image ... "
    $imgsnap $lpath/cam_$date.jpg
    echo "Done."

    echo -n "Uploading image ... "
    scp -Cq $lpath/cam_$date.jpg $username@$host:$rpath/archive
    echo "Done."

    echo -n "Making image link ... "
    ssh -Cq $username@$host ln -fs $rpath/archive/cam_$date.jpg $rpath/cam_work.jpg
    echo "Done."

    echo

    sleep $interval

done

