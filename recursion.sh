#!/bin/bash

# создать скрипт, который генерирует си программу, которая генерирует скрипт, который генерирует си программу с хеллоу ворлд
#hw 6

mkdir temp
cd temp

touch main.c
{
    echo "#include <stdio.h>"
    echo "#include <stdlib.h>"
    echo ""
    echo "int main() {"
    echo "   FILE *shell = fopen(\"shell.sh\", \"ab+\");"
    echo "   fprintf(shell, \"#!/bin/bash\n\""
    echo "                  \"\n\""
    echo "                  \"touch temp.c\n\""
    echo "                  \"{\n\""
    echo "                  \"    echo \\\"#include <stdio.h>\\\"\n\""
    echo "                  \"    echo \"\"\n\""
    echo "                  \"    echo \\\"int main() {\\\"\n\""
    echo "                  \"    echo \\\"    printf(\\\\\\\"Hello, World!\\\\n\\\\\\\");\\\"\n\""
    echo "                  \"    echo \\\"    return 0;\\\"\n\""
    echo "                  \"    echo \\\"}\\\"\n\""
    echo "                  \"} > temp.c\n\""
    echo "                  \"g++ -o temp temp.c && ./temp\n\""
    echo "                  \"cd ..\n\""
    echo "                  \"rm -rf temp && rm -rf shell.sh\");"
    echo "   fclose(shell);"
    echo "   system(\"chmod +x shell.sh\");"
    echo "   return system(\"./shell.sh\");"
    echo "}"
} > main.c
g++ -o main main.c && ./main
