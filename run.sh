flex LAB01.l
yacc LAB02.y
gcc -o compilado lex.yy.c y.tab.c 
./compilado entrada.txt > salida.txt
