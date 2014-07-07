#!/bin/bash

imgsnap=~/bin/ImageSnap-v0.2.5/imagesnap
dropbox=~/Dropbox
rpisize="-w 1280 -h 720"
rpiopts="-awb auto -ex auto -q 15"
rpisnap="/usr/bin/raspistill ${rpisize} ${rpiopts} -vf -hf -o "
rpipath=/home/cliph/www/cam
interval=45

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

function clean {
   echo -n "Cleaning $outpath ... "
   cd $outpath
   shopt -s nullglob
   files=( *.jpg )
   if (( ${#files[@]} ));
   then
      rm -v *.jpg
      echo "Done."
   else
      echo "Nothing to do."
   fi
   exit 0
}

if [ "$#" == 1 ]
then
   if [[ $1 =~ ^-?[0-9]+$ ]]
   then
      loop=$1
   elif [[ $1 =~ "clean" ]]
   then
      clean
   fi
fi

# exit

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
   
   if [ -n "$loop" ]
   then
      loop=$(($loop - 1))
      if [ $loop -lt 1 ]
      then
         exit 0
      fi
   fi

   sleep $interval

done
