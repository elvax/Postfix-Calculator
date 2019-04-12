%{
    #include <stdio.h>
    #include <ctype.h>
    #include <math.h>
    #include <string.h>
    #include <stdarg.h>
    
    #define RP_LINE_LEN 200

    int ERROR = 0;
    int yylex (void);
    void yyerror (char const *);
    int divide(int, int);
    int modulo(int, int);
    void add_to_buffer(const char*, ...);

    char rp_notation_buff[RP_LINE_LEN];
%}

%token NUM T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT T_MODULO T_POWER
%token T_NEWLINE
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE T_MODULO
%right NEG
%right T_POWER

%%

input:
  %empty
| input line
;

line:
  T_NEWLINE
| error T_NEWLINE   {  yyerrok; memset(rp_notation_buff, '\0', RP_LINE_LEN);  }
| exp T_NEWLINE     {  if (!ERROR) {
                         printf ("%s\n= %d\n", rp_notation_buff, $1);
                       }
                       memset(rp_notation_buff, '\0', RP_LINE_LEN);
                       ERROR = 0;                                        
                    }
;


exp:  
    NUM                   { add_to_buffer("%d ", yyval);
                            $$ = $1;                                                                                              
                          }
|   exp T_PLUS exp        { add_to_buffer("+ ");
                            $$ = $1 + $3;                                                                                       
                          }
|   exp T_MULTIPLY exp    { add_to_buffer("* "); 
                            $$ = $1 * $3; 
                          }
|   exp T_MINUS exp       { add_to_buffer("- "); 
                            $$ = $1 - $3; 
                          }
|   exp T_DIVIDE exp      { add_to_buffer("/ "); 
                            if ($3){
                              $$ = divide($1, $3); 
                            } else {
                              ERROR = 1;
                              yyerror("by zero");;
                            }
                          }
|   exp T_MODULO exp      { add_to_buffer("%% "); 
                            $$ = modulo($1, $3); 
                          }
|   exp T_POWER exp       { add_to_buffer("^ "); 
                            $$ = pow($1, $3); 
                          }
|   T_MINUS exp %prec NEG { add_to_buffer("~ "); 
                            $$ = -$2;      
                          }
|   T_LEFT exp T_RIGHT    { $$ = $2; }
;

%%

void add_to_buffer(const char *format, ...) {
    va_list args;
    va_start(args, format);
    vsnprintf(rp_notation_buff + strlen(rp_notation_buff), (sizeof rp_notation_buff) - strlen(rp_notation_buff), format, args);
    va_end(args);
}

int divide(int a, int b) {
    int rounded_to_zero = a / b;
    if (a % b == 0)
      return rounded_to_zero;

    return (a > 0) == (b > 0) ? rounded_to_zero : rounded_to_zero - 1;
}

int modulo(int a, int b) {
  int q = divide(a, b);
  return a - q * b;
}

void yyerror (char const *s) {
  fprintf(stderr, "%s\n", s);
}

int main (void) {
  return yyparse();
}