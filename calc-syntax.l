%{
#include <stdio.h>
#include <stdlib.h>
#ifdef YACC_TABLE_H
#include YACC_TABLE_H
#endif
void yyerror(char *s);
%}

%%
[0-9]+		{yylval = atoi(yytext); return N;}
\n		{ return EOL;}
[+]		{ return OP;}
[ \t]+	;
. 		{printf("Token unrecognized");}
%%

int yywrap(){
	return 1;
}
