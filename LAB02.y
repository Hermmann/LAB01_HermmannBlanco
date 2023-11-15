%{
#include <stdio.h>
#include <string.h>
int yylex(), check_lexical_error();
void yyerror(const char *s);
typedef struct yy_buffer_state * YY_BUFFER_STATE;
extern FILE *yyout;
// extern int lexerError, lexerWrite, numCount;
extern YY_BUFFER_STATE yy_scan_string(char * str);
extern void yy_delete_buffer(YY_BUFFER_STATE buffer);
int errorCounter = 0;
int contadorlinea =1;


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

         | SELECT lista_campos FROM IDENTIFICADOR PUNTO_COMA  // check

         | SELECT funcide FROM IDENTIFICADOR PUNTO_COMA // check

         | SELECT funcide FROM IDENTIFICADOR PUNTO_COMA // check

         | SELECT lista_campos FROM IDENTIFICADOR WHERE condiciones PUNTO_COMA // check

         | SELECT lista_campos FROM IDENTIFICADOR GROUPBY IDENTIFICADOR PUNTO_COMA // check

         | SELECT lista_campos FROM IDENTIFICADOR ORDERBY identificadores orden PUNTO_COMA // check

         | SELECT lista_campos FROM IDENTIFICADOR WHERE condiciones GROUPBY IDENTIFICADOR ORDERBY identificadores orden PUNTO_COMA // 

         | INSERT INTO identificadores VALUES PARABRE identificadores PARCIERRA PUNTO_COMA //

         | DELETE FROM IDENTIFICADOR WHERE condiciones PUNTO_COMA

         | UPDATE IDENTIFICADOR SET lista_asignaciones WHERE condiciones PUNTO_COMA
         ;

lista_columnas: IDENTIFICADOR tipo_dato PARABRE  ENTERO PARCIERRA
              | lista_columnas COMA IDENTIFICADOR tipo_dato PARABRE  ENTERO PARCIERRA
              | lista_columnas COMA IDENTIFICADOR tipo_dato
              ;

lista_campos: ASTERISCO
            | IDENTIFICADOR
            | lista_campos COMA IDENTIFICADOR
            ;

funcide:    funcion PARABRE IDENTIFICADOR PARCIERRA
            | IDENTIFICADOR
            | funcide COMA IDENTIFICADOR
            | funcide COMA funcion PARABRE IDENTIFICADOR PARCIERRA
            ;
    
identificadores: IDENTIFICADOR
                 | identificadores COMA IDENTIFICADOR
                 | COMA IDENTIFICADOR
;

orden:  ASC
       | DESC
        ;

condiciones:  condicion
             | condiciones COMA  AND condicion
             | condiciones COMA  OR condicion
             | COMA AND condicion
             | COMA OR condicion
         ;

condicion:  valor IGUAL valor
            | valor DIFERENCIA valor
            | valor MAYORQUE valor
            | valor MENORQUE valor
            | valor MAYORIGUAL valor
            | valor MENORIGUAL valor
        ;

funcion: MAX
        | MIN
        | AVG
        | COUNT
;

tipo_dato:   VARCHAR 
            | DECIMAL 
            | INTERGER
;

valor: IDENTIFICADOR
     | ENTERO
     | FLOAT
     | CADENA
     ;

lista_asignaciones: IDENTIFICADOR ASIGN valor
                 | lista_asignaciones COMA IDENTIFICADOR ASIGN valor
                 ;

         



%%

int main(int argc, char **argv ){
    FILE *input = fopen(argv[1], "r");
    char * line = NULL;
    size_t len= 0;
    ssize_t read;
    //GUIATE DEL LABORATORIO DEL SEMESTRE PASADO

    while((read = getline(&line, &len, input)) !=-1) {
        line[strcspn(line, "\n")]=0;

        
        //numCount =1;
        YY_BUFFER_STATE buffer = yy_scan_string(line);
        yyparse();
         printf("Análisis Sintáctico: \nErrores Sintácticos: %d\n\n", errorCounter);
        // if(check_lexical_error()){
        //     //lexerError = 0;
        //     printf("Análisis Sintáctico:\nNo se ejecuta\n\n");
        // }else{
        //     //lexerError = 0;
        //     //errorCounter = 0;
        //     //yy_delete_buffer(buffer);
        //     YY_BUFFER_STATE buffer = yy_scan_string(line);
        //     yyparse();
        //     if(errorCounter == 0){
        //         printf("Análisis Sintáctico:\nCorrecto!\n\n");
        //     }else{
        //         printf("Análisis Sintáctico:\nErrores Sintácticos: %d\n\n", errorCounter);
        //     };
        //     yy_delete_buffer(buffer);
        // };
        //yy_delete_buffer(buffer);
    };
    return 0;
}

// void yyerror(const char *s) {
//     printf("Error: %s\n", s);
//     if (strstr(s, "lexical")) {
//         lexicalErrorCounter++;
//     } else if (strstr(s, "syntax")) {
//         syntaxErrorCounter++;
//     }
// }


void yyerror(const char *s) {
    //fprintf(stderr, "%s\n", s);
    ++errorCounter;
}

// int check_lexical_error(){
//     lexerWrite = 1;
//     int token = yylex();
//     while(token){
//         token = yylex();
//     };
//     return lexerError;
// }

// void yyerror(const char *s) {
//     fprintf(stderr, "%s\n", s);
// }

// void yyerror(const char* s) {
//     fprintf(stderr, "Error sintáctico: %s\n", s);
// }
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


