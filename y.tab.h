/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    CREATETABLE = 258,             /* CREATETABLE  */
    DROPTABLE = 259,               /* DROPTABLE  */
    SELECT = 260,                  /* SELECT  */
    WHERE = 261,                   /* WHERE  */
    GROUPBY = 262,                 /* GROUPBY  */
    ORDERBY = 263,                 /* ORDERBY  */
    INSERT = 264,                  /* INSERT  */
    INTO = 265,                    /* INTO  */
    DELETE = 266,                  /* DELETE  */
    UPDATE = 267,                  /* UPDATE  */
    MAX = 268,                     /* MAX  */
    MIN = 269,                     /* MIN  */
    AVG = 270,                     /* AVG  */
    COUNT = 271,                   /* COUNT  */
    VALUES = 272,                  /* VALUES  */
    FROM = 273,                    /* FROM  */
    SET = 274,                     /* SET  */
    ASC = 275,                     /* ASC  */
    DESC = 276,                    /* DESC  */
    VARCHAR = 277,                 /* VARCHAR  */
    DECIMAL = 278,                 /* DECIMAL  */
    INTERGER = 279,                /* INTERGER  */
    AND = 280,                     /* AND  */
    OR = 281,                      /* OR  */
    PARABRE = 282,                 /* PARABRE  */
    PARCIERRA = 283,               /* PARCIERRA  */
    COMA = 284,                    /* COMA  */
    PUNTO_COMA = 285,              /* PUNTO_COMA  */
    ASIGN = 286,                   /* ASIGN  */
    ASTERISCO = 287,               /* ASTERISCO  */
    IDENTIFICADOR = 288,           /* IDENTIFICADOR  */
    ENTERO = 289,                  /* ENTERO  */
    FLOAT = 290,                   /* FLOAT  */
    NUMERO = 291,                  /* NUMERO  */
    CADENA = 292,                  /* CADENA  */
    SUM = 293,                     /* SUM  */
    RESTA = 294,                   /* RESTA  */
    MULT = 295,                    /* MULT  */
    DIV = 296,                     /* DIV  */
    IGUAL = 297,                   /* IGUAL  */
    DIFERENCIA = 298,              /* DIFERENCIA  */
    MAYORQUE = 299,                /* MAYORQUE  */
    MENORQUE = 300,                /* MENORQUE  */
    MAYORIGUAL = 301,              /* MAYORIGUAL  */
    MENORIGUAL = 302               /* MENORIGUAL  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define CREATETABLE 258
#define DROPTABLE 259
#define SELECT 260
#define WHERE 261
#define GROUPBY 262
#define ORDERBY 263
#define INSERT 264
#define INTO 265
#define DELETE 266
#define UPDATE 267
#define MAX 268
#define MIN 269
#define AVG 270
#define COUNT 271
#define VALUES 272
#define FROM 273
#define SET 274
#define ASC 275
#define DESC 276
#define VARCHAR 277
#define DECIMAL 278
#define INTERGER 279
#define AND 280
#define OR 281
#define PARABRE 282
#define PARCIERRA 283
#define COMA 284
#define PUNTO_COMA 285
#define ASIGN 286
#define ASTERISCO 287
#define IDENTIFICADOR 288
#define ENTERO 289
#define FLOAT 290
#define NUMERO 291
#define CADENA 292
#define SUM 293
#define RESTA 294
#define MULT 295
#define DIV 296
#define IGUAL 297
#define DIFERENCIA 298
#define MAYORQUE 299
#define MENORQUE 300
#define MAYORIGUAL 301
#define MENORIGUAL 302

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
