flex LAB01.l
yacc LAB02.y
gcc -o LAB01 lex.yy.c y.tab.c 
./LAB01 entrada.txt > salida.txt
