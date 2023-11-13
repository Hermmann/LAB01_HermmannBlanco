flex LAB01.l
yacc LAB02.y
gcc -o compilado lex.yy.c y.tab.c -lfl
.\compilado entrada > salida.txt