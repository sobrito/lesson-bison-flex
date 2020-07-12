%{
#include "y.tab.h"
#include "Parser.h"
extern int intval;
%}
integer [0-9]+
nl      \n

%%
[ \t]+  ;
{integer}    {sscanf(yytext, "%d", &intval);  return INTEGER;}
{nl}         {return NEWLINE;}
.            {return yytext[0];}
%%
