#!/usr/bin/env bash
# newproject.sh - utility script to automate generation of new projects

NAME=$1
NAME=${NAME:="newproject"}
mkdir $NAME
cp examples/linux/asm_io.inc $NAME/
cp examples/linux/driver.c $NAME/
cp examples/linux/cdecl.h $NAME/
cat examples/linux/skel.asm | sed "s/skel/$NAME/" > $NAME/${NAME}.asm
echo "# $NAME" > $NAME/README.md

