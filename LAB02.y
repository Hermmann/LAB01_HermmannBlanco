%{
#include <stdio.h>
#include <string.h>
int yylex();

%}

/* TOKENS comandos SQL*/
%token CREATETABLE DROPTABLE SELECT WHERE GROUPBY ORDERBY INSERT INTO DELETE UPDATE MAX MIN 
%token AVG COUNT VALUES FROM SET ASC DESC VARCHAR DECIMAL INTERGER AND OR

/* SEPARADORES Y ASTERISCO*/
%token PARABRE PARCIERRA COMA PUNTO_COMA ASIGN ASTERISCO

/*--IDENTIFICADORES, NUMERO Y CADENA---*/
%token IDENTIFICADOR ENTERO FLOAT NUMERO CADENA 

/*OPERADORES MATEMATICOS*/
%token SUM RESTA MULT DIV IGUAL DIFERENCIA MAYORQUE MENORQUE MAYORIGUAL MENORIGUAL



%start inicio

%%

inicio: /* Define la regla inicial de tu gramática */
        | sentencia
        | inicio sentencia /* Para manejar múltiples sentencias */
        ;

sentencia: CREATETABLE IDENTIFICADOR PARABRE lista_columnas PARCIERRA PUNTO_COMA
         | DROPTABLE IDENTIFICADOR PUNTO_COMA
         | SELECT lista_campos FROM IDENTIFICADOR PUNTO_COMA
         | INSERT INTO IDENTIFICADOR PARABRE lista_campos PARCIERRA VALUES PARABRE lista_valores PARCIERRA PUNTO_COMA
         | DELETE FROM IDENTIFICADOR WHERE condicion PUNTO_COMA
         | UPDATE IDENTIFICADOR SET lista_asignaciones WHERE condicion PUNTO_COMA
         ;

lista_columnas: IDENTIFICADOR IDENTIFICADOR PARABRE ENTERO PARCIERRA
              | lista_columnas COMA IDENTIFICADOR IDENTIFICADOR PARABRE ENTERO PARCIERRA
              ;

lista_campos: ASTERISCO
            | IDENTIFICADOR
            | lista_campos COMA IDENTIFICADOR
            ;

lista_valores: valor
             | lista_valores COMA valor
             ;

valor: IDENTIFICADOR
     | ENTERO
     | FLOAT
     | CADENA
     ;

lista_asignaciones: IDENTIFICADOR ASIGN valor
                 | lista_asignaciones COMA IDENTIFICADOR ASIGN valor
                 ;

condicion: IDENTIFICADOR IGUAL valor
         | IDENTIFICADOR DIFERENCIA valor
         | IDENTIFICADOR MAYORQUE valor
         | IDENTIFICADOR MENORQUE valor
         | IDENTIFICADOR MAYORIGUAL valor
         | IDENTIFICADOR MENORIGUAL valor
         | condicion AND condicion
         | condicion OR condicion
         | PARABRE condicion PARCIERRA
         ;

%%

int main(int argc, char** argv ){
    FILE *input = fopen(argv[1], "r");
    char * line = NULL;
    size_t len= 0;

    //GUIATE DEL LABORATORIO DEL SEMESTRE PASADO
}
// int main(int argc, char* argv[]) {
//     if (argc != 2) {
//         fprintf(stderr, "Uso: %s <archivo de entrada>\n", argv[0]);
//         return 1;
//     }

//     FILE* file = fopen(argv[1], "r");
//     if (!file) {
//         perror("Error al abrir el archivo");
//         return 1;
//     }

//     yyin = file;

//     yyparse();

//     fclose(file);

//     return 0;
// }

// void yyerror(const char* s) {
//     fprintf(stderr, "Error sintáctico: %s\n", s);
// }


// %%

// %{
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>

// void yyerror(const char* s);
// extern int yylex();
// extern FILE* yyin;
// %}

// %union {
//     char* strval;
//     int intval;
//     float floatval;
// }

// %token CREATE_DROP INSERT DELETE UPDATE SELECT FROM WHERE GROUP BY ORDER ASC_DESC INTO VALUES SET AND OR FUNC
// %token IDENTIFIER INTEGER DECIMAL STRING
// %token OPEN_PAREN CLOSE_PAREN COMMA SEMICOLON EQUAL NOT_EQUAL GREATER_EQUAL LESS_EQUAL GREATER LESS

// %type <strval> IDENTIFIER STRING
// %type <intval> INTEGER
// %type <floatval> DECIMAL

// %%

// sql_stmt: create_drop_stmt
//         | insert_stmt
//         | delete_stmt
//         | update_stmt
//         | select_stmt

// create_drop_stmt: CREATE DROP TABLE IDENTIFIER '(' col_def_list ')' SEMICOLON
//                 | CREATE TABLE IDENTIFIER '(' col_def_list ')' SEMICOLON
//                 ;

// col_def_list: IDENTIFIER col_def
//             | col_def_list ',' IDENTIFIER col_def
//             ;

// col_def: IDENTIFIER IDENTIFIER '(' INTEGER ')' 
//        | IDENTIFIER IDENTIFIER '(' INTEGER ')' ',' col_def
//        ;

// insert_stmt: INSERT INTO IDENTIFIER VALUES '(' val_list ')' SEMICOLON
//            ;

// val_list: val
//         | val_list ',' val
//         ;

// val: INTEGER
//    | DECIMAL
//    | STRING
//    ;

// delete_stmt: DELETE FROM IDENTIFIER WHERE cond_list SEMICOLON
//            ;

// cond_list: condition
//          | cond_list AND condition
//          | cond_list OR condition
//          ;

// condition: IDENTIFIER EQUAL val
//          | IDENTIFIER NOT_EQUAL val
//          | IDENTIFIER GREATER_EQUAL val
//          | IDENTIFIER LESS_EQUAL val
//          | IDENTIFIER GREATER val
//          | IDENTIFIER LESS val
//          ;

// update_stmt: UPDATE IDENTIFIER SET update_list WHERE cond_list SEMICOLON
//            ;

// update_list: IDENTIFIER EQUAL val
//            | IDENTIFIER EQUAL val ',' update_list
//            ;

// select_stmt: SELECT select_list FROM IDENTIFIER opt_where opt_group_by opt_order_by SEMICOLON
//            ;

// opt_where: WHERE cond_list
//          | /* empty */
//          ;

// opt_group_by: GROUP BY IDENTIFIER SEMICOLON
//             | /* empty */
//             ;

// opt_order_by: ORDER BY order_list ASC_DESC SEMICOLON
//             | /* empty */
//             ;

// order_list: IDENTIFIER
//           | order_list ',' IDENTIFIER
//           ;

// select_list: '*'
//            | select_item_list
//            ;

// select_item_list: select_item
//                 | select_item_list ',' select_item
//                 ;

// select_item: FUNC '(' IDENTIFIER ')' 
//            | IDENTIFIER
//            ;

// %%


