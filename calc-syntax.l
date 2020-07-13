%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
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