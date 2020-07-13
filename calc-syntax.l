%{
#include <stdio.h>
#include <stdlib.h>
#ifdef YACC_TABLE_H
#include YACC_TABLE_H
#endif
void yyerror(char *s);
%}

%%
[0-9]+		        {yylval.intVal = atoi(yytext); return N;}
[+]		            { return OP;}
import              { return IMPORT;}
'                   { return QUOTE;}
\"                  { return DOUBLE_QUOTE;}
\n		            { return EOL;}
[ \t]+	            ;
. 		            {printf("Token unrecognized");}
%%

int yywrap(){
	return 1;
}
