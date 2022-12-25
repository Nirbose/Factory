YELLOW="\e[33m"
RED_BOLD="\e[1;31m"
BG_RED="\e[48;5;1m"
SUCCESS="\e[1;32m"
YELLOW_BOLD="\e[1;33m"
ENDCOLOR="\e[0m"
TEST_DIR="./tests"

ask() {
    read REPLY
    if [ $(echo $REPLY | tr '[:upper:]' '[:lower:]') = "y" ] || [ $(echo $REPLY | tr '[:upper:]' '[:lower:]') = "yes" ]; then
        mkdir $TEST_DIR
        echo "\n${SUCCESS}Successfully created repertoire!${ENDCOLOR}"
    elif [ $(echo $REPLY | tr '[:upper:]' '[:lower:]') = "n" ] || [ $(echo $REPLY | tr '[:upper:]' '[:lower:]') = "no" ]; then
        exit 0
    else
        echo "\n${RED_BOLD}This answer does not exist${ENDCOLOR}"
        ask
    fi
}

if [ "$#" = 0 ]; then
    echo "${BG_RED} ERROR ${ENDCOLOR} There are missing arguments to \"make\".\n"
    echo "  ├ make:test"
    echo ""
    exit 0
fi

# Equal to : test
if [ "$1" = "test" ]; then
    if [ "$#" = 2 ]; then
        TEST_NAME=$2
    else
        echo "${YELLOW_BOLD}Test name :${ENDCOLOR}"
        read TEST_NAME
        if ! [ -d $TEST_DIR ]; then
            echo "\nThe \e[1;11m\"tests\"${ENDCOLOR} directory does not exist. Would you like to create it ? (Y/n)"
            ask
        fi
    fi
    cat $(dirname $0)/../template/test.c.template >> "${TEST_DIR}/${TEST_NAME}.c"
    echo "\n${SUCCESS}Test created with success!${ENDCOLOR}"
    exit 0
fi