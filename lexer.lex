%option noyywrap

%{
    #include "gram.tab.h"
    #include <stdlib.h>
    extern int yylval;
%}

%%
[ \t]
[0-9]+  { yylval=atoi(yytext);
          return NUM;           } 
"+"     { return T_PLUS;        }
"-"     { return T_MINUS;       }
"*"     { return T_MULTIPLY;    }
"/"     { return T_DIVIDE;      }
"%"     { return T_MODULO;      }
"^"     { return T_POWER;       }
"("     { return T_LEFT;        }
")"     { return T_RIGHT;       }
\\\n
\n      { return T_NEWLINE;     }
#(.|\\\n.)*     // ignore lines starting with # (comments)
%%