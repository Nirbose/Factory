BG_SUCCESS="\e[48;5;2m"
BG_ERROR="\e[48;5;1m"
ENDCOLOR="\e[0m"

if [ $1 = "check" ]; then
    HAS_ERROR=$(norminette | grep "Error" -c)
    if [ HAS_ERROR = 0 ]; then
        echo "${BG_SUCCESS} Ok ${ENDCOLOR} The clean code"
    else
        echo "${BG_ERROR} Fail ${ENDCOLOR}"
        echo "There are $(norminette | grep "Error!" | wc -l) files that are not in the standard"
        echo "As well as $(norminette | grep "Error:" | wc -l) standard errors"
        echo "\nUse nono:clean for clean code"
    fi
fi

if [ $1 = "clean" ]; then
    FILE=""
    for line in $(norminette); do
        if [ $(echo $line | grep -e "\.[ch]:" -c) = 1 ]; then
            FILE=$(echo $line | cut -d ":" -f 1)
        fi
        if [ $(echo $line | grep "INVALID_HEADER" -c) = 1 ] && ! [ $FILE = "" ]; then
            $(echo ":Stdheader\n:wq" | vi "$FILE")
        fi
    done
fi