#!/bin/bash

imgsnap=~/bin/ImageSnap-v0.2.5/imagesnap
dropbox=~/Dropbox
rpisize="-w 1280 -h 720"
rpisnap="/usr/bin/raspistill ${rpisize} -vf -hf -o "
rpipath=/home/cliph/www/cam
interval=5

if [ -x $imgsnap ]
then
   capbin=$imgsnap
elif [ -x $ripisnap ]
then
   capbin=$rpisnap
   outpath=$rpipath
else
   exit 0
fi

# $imgsnap $dropbox/tmp/`date +%d%m%y%H%M%S`_snap.jpg

while true; do
   date=`date +%d%m%y%H%M%S`
   echo -n "Capturing image ... "
   $capbin $outpath/cam_$date.jpg
   echo "Done."

   echo -n "Making image link ... "
   ln -fs cam_$date.jpg $outpath/cam.jpg
   echo "Done."

   echo

   sleep $interval

done
