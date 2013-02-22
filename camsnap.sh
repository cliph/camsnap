#!/bin/bash

imgsnap=~/bin/ImageSnap-v0.2.5/imagesnap
dropbox=~/Dropbox

$imgsnap $dropbox/tmp/`date +%d%m%y%H%M%S`_snap.jpg
