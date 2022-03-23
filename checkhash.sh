#!/bin/bash
#
# To do: Add detection if running Linux or MacOS
# https://stackoverflow.com/questions/3466166/how-to-check-if-running-in-cygwin-mac-or-linux

help() {
    echo " "
    echo "Usage: checkhash.sh [checksum type] [checksum to compare] [Path to file]"
    echo "       Gets a checksum from source file and compares that to a given hash."
    echo "       Checksum types: md5; sha1; sha256; sha512"
    echo "       checkhash.sh -h Shows this help."
    echo " "
    exit 0;
}

if [ $# -eq 0 -o "$1" = "-h" ]; then help;
    # Call without parameter or with -h shows help
else
    # Call with required 3 parameters
    TYPE=$1
    GIVENCHECKSUM=$2
    WHEREISFILE=$3
fi

# Set command for hashtype
case ${TYPE} in
    md5)
        COMMAND="md5"
        POS="4"
    ;;
    sha1)
        COMMAND="shasum"
        POS="1"
    ;;
    sha256)
        COMMAND="shasum -a 256"
        POS="1"
    ;;
    sha512)
        COMMAND="shasum -a 512"
        POS="1"
    ;;
    
esac

DETCHECKSUM=$(
    $COMMAND "$WHEREISFILE" | cut -d ' ' -f $POS
)

echo " "
echo "Checksum is ${DETCHECKSUM}"

if [[ $GIVENCHECKSUM = $DETCHECKSUM ]]; then
    echo "Checksum OK"
else
    echo "Checksum Error !"
fi

# echo "Pfad ist ${WHEREISFILE}"
echo " "

echo "All done. Goodbye."
echo " "
exit 0
