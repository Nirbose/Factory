SUCCESS="\e[1;32m"
ERROR="\e[1;31m"
BG_SUCCESS="\e[48;5;2m"
BG_ERROR="\e[48;5;1m"
ENDCOLOR="\e[0m"
ELEMENT_COMPILE=""

if ! [ $# = 0 ]; then
	if [ $1 = "-w" ]; then
		if ! [ $# = 2 ]; then
			echo "Missing libs/file to add at compile time"
			exit 1
		fi
		ELEMENT_COMPILE=$(dirname $0)/$2
	fi
fi

if [ $(ls tests/ | wc -l) = 0 ]; then
	echo "There is no test"
	exit 0
fi
echo ""
for file in tests/*; do
	if ! [ -f $file ]; then
		continue
	fi
	clang $file $ELEMENT_COMPILE -o test.out
	LINES=$(./test.out)
	if [ $(echo $LINES | grep "Error" -c) = 0 ]; then
		echo "${BG_SUCCESS} PASS ${ENDCOLOR} $(basename $file)"
	else
		echo "${BG_ERROR} ECHEC ${ENDCOLOR} $(basename $file)"
	fi
	for line in $LINES; do
		if [ "$(echo $line | grep "Ok" -c)" -eq 1 ]; then
			echo "  ${SUCCESS}✔ Ok${ENDCOLOR}"
		else
			echo "  ${ERROR}✖ Error${ENDCOLOR}"
		fi
	done
	echo ""
done
rm test.out
