/***********************************************************
 * progparser.l
 * HW by jwtxz, Jinming Wu 
 ***********************************************************/
// -- PREAMBLE ------------------------------------------

%{
  #include <iostream>
  using namespace std;

  extern int yylex();
  extern int line_num;
  extern char* yytext;

  int yyerror(const char *p);
%}

/* -- TOKEN DEFINITIONS -- */

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
stmtseq : statement
          { cout << "RULE: stmtseq ::= statement" << endl; }
        | stmtseq statement
          { cout << "RULE: stmtseq ::= stmtseq statement" << endl; }
        ;

statement : T_IDENT ":-" T_DECIMAL ";"
            { cout << "RULE: statement ::= identifier :- decimal ;" << endl;}
          | "write" "(" T_INTEGER ")" ";"
            { cout << "RULE: statement ::= write ( integer ) ;" << endl; }
          ;

%%
//-- CODA ---------------------------------------------
/* Bison error function */
int yyerror(const char *p)
{
    cout << "ERROR: In line " << line_num << " with token \'"
         << yytext << "\'" << endl;
}

/* MAIN function of Parser  */
int main()
{
  int failcode;
  cout << "Hello Flex + Bison" << endl;
  failcode = yyparse();

  if (failcode)
    cout << "INVALID!" << endl;
  else
    cout << "CORRECT" << endl;
  return 0;
}
