%{
#include <stdio.h>

void yyerror(char *s);
int yylex(void);
extern char *yytext;
%}

%token N OP EOL
%left OP
%%
S:	S E EOL { $$ = $2; }
	|
;
E:
	N { $$ = $1; }
	| E OP E { $$ = $1 + $3}
	;
%%
void yyerror(char *s){
	printf("Syntax error: %s, near %s", s, yytext);
}
