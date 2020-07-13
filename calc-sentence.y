%{
#include <stdio.h>
#include "Parser.h"
void yyerror(char *s);
int yylex(void);
extern char *yytext;
%}

%union {
     int intVal;
     float floatVal;
     char *stringVal;
     char charVal;
}

%token <intVal> N OP EOL IMPORT QUOTE DOUBLE_QUOTE
%token <stringVal> VALUE

%left OP
%type <intVal> S E _import
%%
t:
	S
	| _import
	;
_import:
    	IMPORT  QUOTE VALUE QUOTE { printf("q: %s", $3); }
    	| IMPORT DOUBLE_QUOTE  VALUE DOUBLE_QUOTE {printf("dq: %s", $3);}
    	;
S:	S E EOL { $$ = $2; printf("result: %d\r\n", $2); }
	| {}
;
E:
	N { $$ = $1; }
	| E OP E { $$ = $1 + $3;}
	;
%%
void yyerror(char *s){
	printf("Syntax error: %s, near %s", s, yytext);
}
int Test::Parser::parser(){
	return yyparse();
}
