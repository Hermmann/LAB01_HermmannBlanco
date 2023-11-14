%{
#define YYSTYPE char const *    
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "y.tab.h"
int yylex();
int numCount = 1;
bool errorFlag = false;
int lexerError = 0;
int lexerWrite=0;

#define MAX_IDENFIERS  100
#define MAX_ERRORS  100


int id_counter = 0;
char ids[MAX_IDENFIERS][256];
int ids_numebers  [MAX_IDENFIERS];
bool is_ids_repeated [MAX_IDENFIERS];

int errors_count =0;
char errors[MAX_ERRORS][256];

// void add_id(string id) {
//     string
    
// }

int idExist(char* identifier) {
    for(int i = 0; i < id_counter; i++){
        if(strcmp(ids[i], identifier) == 0){
            return i;
        }
    
    }
    return -1;
}


%}
/*%option noyywrap
%option yylineno     


/*SECCION DE TOKENS */

LETRA      [a-zA-Z]
DIGITO     [0-9]
PUNTO      ["."]

/*Comandos SQL*/
CREATETABLE           "CREATE TABLE"|"CREATE Table"|"Create table"; 
DROPTABLE             "DROP TABLE"|"DROP table"
SELECT                "SELECT"|"select"  
WHERE                 "WHERE"|"where"
GROUPBY               "GROUP BY"
ORDERBY               "ORDER BY"
INSERT                "INSERT"|"insert"
DELETE                "DELETE"|"delete"
UPDATE                "UPDATE"|"updtate"
MAX                   "MAX"
MIN                 "MIN"
AVG                 "AVG"
COUNT           "COUNT"
INTO            "INTO"
VALUES          "VALUES"
FROM        "FROM"
SET     "SET"
ASC         "ASC"
DESC            "DESC"



/*SEPARADORES */
PARABRE  "("
PARCIERRA  ")"
COMA  ","
PUNTO_COMA  ";""
ASIGN  "="

/*CARACTERES ESPECIALES*/
ASTERISCO  "*"

/*IDENTIFICADORES, NUMERO Y CADENA*/
IDENTIFICADOR         [a-zA-ZáéíóúÁÉÍÓÚ][a-zA-ZáéíóúÁÉÍÓÚ0-9]*
ENTERO                {DIGITO}({DIGITO})*
DECIMAL               {DIGITO}{PUNTO}{DIGITO}({DIGITO})*
NUMERO               {ENTERO} | {DECIMAL}
CADENA           \"[^\n"]*\"|\'[^\n']*\'

ERROR {DIGITO}+{LETRA}+({DIGITO}|{LETRA})*|[^{NUMERO}]{PUNTO}[^{NUMERO}]


%%

{CREATETABLE}   { printf("CREATE TABLE ");} ; return CREATETABLE;
{DROPTABLE}    { printf("DROP TABLE "); }   ; return DROPTABLE;
{SELECT} { printf("SELECT "); } ; return SELECT;
{WHERE} { printf("WHERE "); }   return WHERE;
{GROUPBY} { printf("GROUP BY "); }  return GROUPBY;
{ORDERBY} { printf("ORDER BY "); }  return ORDERBY;
{INSERT} { printf("INSERT "); } return  INSERT;
{DELETE} { printf("DELETE "); } return DELETE;
{UPDATE} { printf("UPDATE "); } return UPDATE ; 
{MAX} { printf("MAX "); }  return MAX;
{MIN} { printf("MIN "); }  return MIN;
{AVG} { printf("AVG "); }  return AVG ;
{COUNT} { printf("COUNT "); }  return COUNT;
{INTO} { printf("INTO "); } return INTO;
{VALUES} { printf("VALUES "); } return VALUES;
{FROM} { printf("FROM "); } return FROM;
{SET} { printf("SET "); }   return SET;
{ASC} { printf("ASC "); }   return ASC ; 
{DESC} { printf("DESC "); } return DESC;
"VARCHAR" { printf("VARCHAR "); }   return VARCHAR;
"DECIMAL" { printf("DECIMAL"); }    return DECIMAL;
"INTEGER" { printf("INTEGER "); }   return INTERGER;
"AND" { printf("AND "); }   return AND;
"OR" { printf("OR "); } return OR;


{IDENTIFICADOR}   {int index = idExist(yytext);
                        if(index == -1){
                            index = id_counter;
                            strcpy(ids[index], yytext);
                            ids_numebers [index] = ++id_counter;
                            
                            is_ids_repeated[index] = false;

                            // ids[id_counter] = yytext;           
                            // id_counter++;
                            // //ids.insert(ids.end(), yytext);
                            // index = idExist(yytext);
                        }else{
                            is_ids_repeated[index]=true;
                        }
                        printf("id%d=%s ", ids_numebers[index], yytext);}; return IDENTIFICADOR;
                        
                               

{ENTERO}             { printf(" entero=%s ", yytext); }; return ENTERO;
{DECIMAL}        { printf(" decimal=%s ", yytext); }; return FLOAT;
{CADENA}         { printf(" cadena=%s ", yytext); }; return CADENA;

"+"                { printf(" suma=%s ", yytext); }; return SUM;
"-"                { printf(" resta=%s ", yytext); }; return RESTA;
"*"                { printf(" multiplicacion=%s ", yytext);}; return MULT;
"/"                { printf(" div=%s ", yytext); };  return DIV;
"=="               { printf(" igual=%s ", yytext); };    return IGUAL;
"<>"               { printf(" diferencia=%s ", yytext); };  return DIFERENCIA;
">"                { printf(" mayor%s ", yytext); }; return MAYORQUE;
"<"                { printf(" menor=%s ", yytext); }; return MENORQUE;
">="               { printf(" mayorIgual=%s ", yytext); }; return MAYORIGUAL;
"<="               { printf(" menorIgual=%s ", yytext); }; return  MENORIGUAL;

"("                { printf(" parabre=%s ", yytext); };  return PARABRE;
")"                { printf(" paracierr=%s ", yytext); }; return PARCIERRA;
","                { printf(" coma=%s ", yytext); } return COMA;    
";"                { printf(" puntcoma=%s", yytext); };  return PUNTO_COMA;
"="                { printf(" asig= %s ", yytext); };    return ASIGN;
[^({NUMERO}|{PARABRE})]{ASTERISCO}[^({NUMERO}|{PARABRE})] {printf("asterisco=%s ",yytext);}; return ASTERISCO;



{ERROR}    { printf("ERROR=%s ",yytext);
   errors_count++;
};

%%
//"*"                { printf("asterisco=%s", yytext); }
//colocar que puedan reconocer los comandos SQL tanto mayusculas como
//también hay que reconocer al caracter especial asterisco que podría estarprecedido por el select
 // también veo saber distinguir cuales son los que se repiten y cuales no

int yywrap(void) {
    return 1;
}
// int main(int argc, char *argv[]){
//     //++argv, --argc;
//     /*Abro el archivo en modo lectura y dejo apuntando el puntero yyvin que nos pide el FLEX alli*/
//     if ((yyin = fopen(argv[1], "rt")) == NULL){
//         printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
//         return 1;
//     }else{
//         //printf("\nEl archivo %s se abrio correctamente\n",argv[1]);
//         //yyin = stdin;

//     yylex();
//     printf("\n\n");
//          printf("%d Identificadores encontrados:", id_counter);
//          printf("\n\n");

//     for (int i = 0; i < id_counter ; i++) {
//         printf("id%d=%s\n", i + 1, ids[i]);
//     }

//         //Aquí es en donde se muestra los errores léxicos encontrados y cuántos de ellos se encontraron
//     printf("\nErrores léxicos encontrados:\n");
    
//     printf("\n\n");
//     printf("%d Errores léxicos: ", errors_count);

//     return 0;

//     }
//     printf("\nFLEX Finalizo la lectura del archivo %s \n", argv[1]);
//     fclose(yyin);
//     return 0;
// }