 /********************************************************
 * hint.y
 ********************************************************/
// -- PREAMBLE ------------------------------------------

%{
  #include <iostream>
  using namespace std;

  // Things from Flex that Bison needs to know
  extern int yylex();
  extern int line_num;
  extern char* yytext;

  // Prototype for Bison's error message function
  int yyerror(const char *p);
%}

  /* -- TOKEN DEFINITIONS -- */
  // what tokens to expect from Flex
%token T_IDENT
%token T_DECIMAL
%token T_INTEGER

%token K_SEMICOLON ";"
%token K_ASSIGN    ":-"
%token K_LPAREN    "("
%token K_RPAREN    ")"
%token K_WRITE     "write"


%%  //-- GRAMMAR RULES ------------------------------------
/* NOTE: Bison likes the start symbol to be the first rule */
