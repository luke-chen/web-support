#!/bin/bash
ls www/*.$1 | while read NAME
do
    mv $NAME ${NAME%\.$1}.$2
done
