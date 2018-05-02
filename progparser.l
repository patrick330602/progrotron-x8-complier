/* --- progparser.l | HW by jwtxz, Jinming Wu */

%{
#include <iostream>
#include <iomanip>
#include "progparser.tab.h"
using namespace std;

int line_num = 1;

/* --- FUNCTION PROTOTYPES */
void writeToken(const char* toktype);

%}

/* --- OPTIONS */
%option noyywrap

/* --- DEFINITIONS */
WHITE      [ \t]
DIGIT      [0-9]
ALPHA      [a-zA-Z]
ALPHANUM   [a-zA-Z0-9]

%%   /* -- REGULAR EXPRESSIONS ---------------------------- */

{WHITE}    ;
\n         { line_num++; }
";"        { return K_SEMICOLON; }
":-"       { return K_ASSIGN; }
","        { return K_COMMA; }
"("        { return K_LPAREN; }
")"        { return K_RPAREN; }
"write"    { return K_WRITE; }
"return"   { return K_RETURN; }
"if"       { return K_IF; }
"endif"    { return K_ENDIF; }
"else"     { return K_ELSE; }
"while"    { return K_WHILE; }
"endw"     { return K_ENDW; }
"function" { return K_FUNCTION; }
"endfun."  { return K_ENDFUN; }
"&"        { return K_AMP; }
"+"        { return K_PLUS; }
"-"        { return K_MINUS; }
"*"        { return K_MULT; }
"/"        { return K_DIV; }
"<="       { return K_LTE; }
"<"        { return K_LT; }
"="        { return K_EQ; }
"#"        { return K_NEQ; }
"~"        { return K_NEG; }
{ALPHA}{ALPHANUM}*         { writeToken("T_IDENT"); return T_IDENT; }
[+-]?{DIGIT}+              { writeToken("T_INTEGER"); return T_INTEGER; }
[+-]?{DIGIT}+\.{DIGIT}+    { writeToken("T_DECIMAL"); return T_DECIMAL; }
\".+\"                     { writeToken("T_STRING"); return T_STRING; }


%%   /* -- CODA  -------------------------------------- */

// Purpose: prints that a complex token was found
void writeToken(const char* toktype)
{
    cout << "TOKEN: ";
    cout << left << setw(14) << toktype;
    cout << "LEXEME: " << yytext << endl;
}
