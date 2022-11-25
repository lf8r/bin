#!/bin/sh
for f in *.jpg;
do
	echo Processing $f
	echo $f
	convert -border 150x150 -pointsize 60 -font Helvetica -bordercolor "#000000" -fill white -gravity north -annotate +100+12 "S U B H A J I T   D A S G U P T A\nR E F L E C T I O N S" -font Helvetica -pointsize 60 -fill white -gravity south -annotate +100+12 "${FILENAME}\n" $f $f;
done
