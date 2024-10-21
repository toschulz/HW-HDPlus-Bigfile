#!/bin/bash

DIR_LIST="`find . -type d`"
BIGGIE_DIRS="*"

for i in ${DIR_LIST}
do
	if [ "${i}" != "." ]
	then
		BIGGIE_DIRS="${BIGGIE_DIRS} ${i}/*";
	fi
done

echo "Updating Update.big with the following dir list"

TMPVAR="`echo \"${BIGGIE_DIRS}\" | sed "s|\./||g"`"
echo "${TMPVAR}"

if [ -f ../new.big ]
then
	rm ../new.big
fi
if [ -f ../new_patch.big ]
then
	rm ../new_patch.big
fi

biggie -f ../new.big ${TMPVAR}

if [ -f ../new.big ]
then
	biggie -u ../../Homeworld.big ../new.big ../new_patch.big
else
	echo "new.big is missing"
fi

if [ -f ../new_patch.big ]
then
	mv ../new_patch.big ../../Update.big.nlips.etg
else
	echo "new_patch is missing"
fi
