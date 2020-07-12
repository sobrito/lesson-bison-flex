%{
#include <stdio.h>
#include <stdlib.h>
#ifdef YACC_TABLE_H
#include YACC_TABLE_H
#endif
#include "Parser.h"
void yyerror(char *s);
%}
%option noyywrap
_NUMBER		[0-9]+
_EOL		\n
_SUM		[+]
_SPACE		[ \t]
%%
{_NUMBER}	{yylval = atoi(yytext); return N;}
{_EOL}		{ return EOL;}
{_SUM}		{ return OP;}
{_SPACE}+	;
. 		{printf("Token unrecognized");}
%%

int Test::Parser::parser() {
    return yyparse();
}

