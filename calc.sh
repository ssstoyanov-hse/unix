function byNumeral {
   regex='^[+-]?[0-9]+([.][0-9]+)?$'
   procedure='^[+-/*^]$'
   echo "Введите первое число"
   read a;
   if ! [[ $a =~ $regex ]] ; then
      echo "ошибка: Не число"
      exit 1
   fi
   echo "Введите второе число"
   read b;
   if ! [[ $b =~ $regex ]] ; then
      echo "ошибка: Не число"  
      exit 1
   fi
   echo "Введите операцию (+ - * ^ /)"
   read c;
   if ! [[ $c =~ $procedure ]] ; then
      echo "ошибка: Не операция или не поддерживается"
      exit 1
   fi
   echo "Результат"
   echo "scale=4; $a$c$b" | bc -l
   sleep 3
   clear
}

function isNumber() {
   if [ "$1" == "один" ]; then
      echo $(("1"))
   elif [ "$1" == "два" ]; then
      echo $(("2"))
   elif [ "$1" == "три" ]; then
      echo $(("3"))
   elif [ "$1" == "четыре" ]; then
      echo $(("4"))
   elif [ "$1" == "пять" ]; then
      echo $(("5"))
   elif [ "$1" == "шесть" ]; then
      echo $(("6"))
   elif [ "$1" == "семь" ]; then
      echo $(("7"))
   elif [ "$1" == "восемь" ]; then
      echo $(("8"))
   elif [ "$1" == "девять" ]; then
      echo $(("9"))
   elif [ "$1" == "десять" ]; then
      echo $(("10"))
   elif [ "$1" == "ноль" ]; then
      echo $(("0"))
   else
      echo "ошибка: Не число или не поддерживается"
      sleep 3
      clear
      exit 1
   fi
}

function isProcedure() {
   echo "Результат"
   if [ "$1" == "умножить" ]; then
      echo "scale=4; $a*$b" | bc -l
   elif [ "$1" == "разделить" ]; then
      echo "scale=4; $a/$b" | bc -l
   elif [ "$1" == "прибавить" ]; then
      echo "scale=4; $a+$b" | bc -l
   elif [ "$1" == "отнять" ]; then
      echo "scale=4; $a-$b" | bc -l
   elif [ "$1" == "степень" ]; then
      echo "scale=4; $a^$b" | bc -l
   else
      echo "ошибка: Не операция или не поддерживается"
      sleep 3
      clear
      exit 1
   fi
}

function byLetters {
   echo "Введите первое число"
   read a;
   a=$(isNumber $a)
   echo "Введите второе число"
   read b;
   b=$(isNumber $b)
   echo "Введите операцию (прибавить отнять умножить степень разделить)"
   read c;
   isProcedure $c
   sleep 3
   clear
}

function levenshtein {
    if [ "${#1}" -lt "${#2}" ]; then
        levenshtein "$2" "$1"
    else
        local str1len=$((${#1}))
        local str2len=$((${#2}))
        local d i j
        for i in $(seq 0 $(((str1len+1)*(str2len+1)))); do
            d[i]=0
        done
        for i in $(seq 0 $((str1len))); do
            d[$((i+0*str1len))]=$i
        done
        for j in $(seq 0 $((str2len))); do
            d[$((0+j*(str1len+1)))]=$j
        done

        for j in $(seq 1 $((str2len))); do
            for i in $(seq 1 $((str1len))); do
                [ "${1:i-1:1}" = "${2:j-1:1}" ] && local cost=0 || local cost=1
                local del=$((d[(i-1)+str1len*j]+1))
                local ins=$((d[i+str1len*(j-1)]+1))
                local alt=$((d[(i-1)+str1len*(j-1)]+cost))
                d[i+str1len*j]=$(echo -e "$del\n$ins\n$alt" | sort -n | head -1)
            done
        done
        echo ${d[str1len+str1len*(str2len)]}
    fi
}

function normalizationNumber {
   if [ $(levenshtein "$1" "один") -le 2  ]; then
      echo $(("1"))
   elif [ $(levenshtein "$1" "два") -le 1 ]; then
      echo $(("2"))
   elif [ $(levenshtein "$1" "три") -le 1 ]; then
      echo $(("3"))
   elif [  $(levenshtein "$1" "четыре") -le 4  ]; then
      echo $(("4"))
   elif [ $(levenshtein "$1" "пять") -le 2 ]; then
      echo $(("5"))
   elif [ $(levenshtein "$1" "шесть") -le 3 ]; then
      echo $(("6"))
   elif [ $(levenshtein "$1" "семь") -le 2 ]; then
      echo $(("7"))
   elif [ $(levenshtein "$1" "восемь") -le 4 ]; then
      echo $(("8"))
   elif [ $(levenshtein "$1" "девять") -le 4  ]; then
      echo $(("9"))
   elif [ $(levenshtein "$1" "десять") -le 4  ]; then
      echo $(("10"))
   elif [ $(levenshtein "$1" "ноль") -le 2  ]; then
      echo $(("0"))
   else
      echo "ошибка: Число не распознается" 
      sleep 3
      clear
      exit 1
   fi
}

function normalizationProcedure {
   echo "Результат"
   if [ $(levenshtein "$1" "умножить") -le 4 ]; then
      echo "scale=4; $a*$b" | bc -l
   elif [ $(levenshtein "$1" "разделить") -le 4 ]; then
      echo "scale=4; $a/$b" | bc -l
   elif [ $(levenshtein "$1" "прибавить") -le 4 ]; then
      echo "scale=4; $a+$b" | bc -l
   elif [ $(levenshtein "$1" "отнять") -le 4 ]; then
      echo "scale=4; $a-$b" | bc -l
   elif [ $(levenshtein "$1" "степень") -le 4 ]; then
      echo "scale=4; $a^$b" | bc -l
   else
      echo "ошибка: Операция не распознается" 
      sleep 3
      clear
      exit 1
   fi
}

function byMisspeledLetters {
   echo "Введите первое число"
   read a;
   a=$(normalizationNumber $a)
   echo "Введите второе число"
   read b;
   b=$(normalizationNumber $b)
   echo "Введите операцию (прибавить отнять умножить степень разделить)"
   read c;
   normalizationProcedure $c
   sleep 3
   clear
}

option=""
until [ "$option" == "никак" ]
do
   echo "Как будем считать?"
   echo "- цифрами"
   echo "- буквами"
   echo "- буквами с ошибками (ошибки)"
   echo "- никак"
   read option;

   if [ $option == "цифрами" ]; then
      byNumeral
   elif [ $option == "буквами" ]; then
      byLetters
   elif [ $option == "ошибки" ]; then
      byMisspeledLetters
   elif [ $option == "никак" ]; then
      clear
      exit
   else
      echo "Вы что-то неправильно ввели, попробуйте ещё раз"
      sleep 2
      clear
   fi
done