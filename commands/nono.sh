B_YELLOW="\e[1;33m"
BG_SUCCESS="\e[48;5;2m"
BG_ERROR="\e[48;5;1m"
ENDCOLOR="\e[0m"

if [ $1 = "check" ]; then
    echo "Norminette :"
    HAS_ERROR=$(norminette | grep "Error" -c)
    if [ $HAS_ERROR = 0 ]; then
        echo "${BG_SUCCESS} Ok ${ENDCOLOR} The clean code"
    else
        echo "${BG_ERROR} Fail ${ENDCOLOR} ${B_YELLOW}$(norminette | grep "Error:" | wc -l)${ENDCOLOR} errors in ${B_YELLOW}$(norminette | grep "Error!" | wc -l)${ENDCOLOR} files"
    fi
    if [ -f "Makefile" ]; then
        echo "\nMakefile :"
        make -s
        HAS_ERROR=$(make | grep "make:" -c)
        if ! [ $HAS_ERROR = 0 ]; then
            echo "${BG_SUCCESS} Ok ${ENDCOLOR} Good Makefile"
        else
            echo "${BG_ERROR} Fail ${ENDCOLOR} Makefile relink"
        fi
        make fclean -s
    fi
    if [ -d "tests" ]; then
        echo "\nTests :"
        HAS_ERROR=$(sh $(dirname $0)/test.sh | grep "Error" -c)
        if [ $HAS_ERROR = 0 ]; then
            echo "${BG_SUCCESS} Ok ${ENDCOLOR} All tests is good"
        else
            echo "${BG_ERROR} Fail ${ENDCOLOR}"
        fi
    fi
fi