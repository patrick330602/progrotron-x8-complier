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
%token T_STRING
%token T_DECIMAL
%token T_INTEGER

%token K_SEMICOLON ";"
%token K_ASSIGN    ":-"
%token K_LPAREN    "("
%token K_RPAREN    ")"
%token K_WRITE     "write"
%token K_RETURN    "return"
%token K_IF        "if"
%token K_ENDIF     "endif"
%token K_ELSE      "else"
%token K_WHILE     "while"
%token K_ENDW      "endw"
%token K_FUNCTION  "function"
%token K_ENDFUN    "endfun."
%token K_AMP       "&"
%token K_PLUS      "+"
%token K_MINUS     "-"
%token K_MULT      "*"
%token K_DIV       "/"
%token K_LTE       "<="
%token K_LT        "<"
%token K_EQ        "="
%token K_NEQ       "#"
%token K_NEG       "~"


%%  //-- GRAMMAR RULES ------------------------------------
/* NOTE: Bison likes the start symbol to be the first rule */
program : functiondec
          { cout << "RULE: program ::= functiondec" << endl; }
        | program functiondec
          { cout << "RULE: program ::= program functiondec" << endl; }
        ;
functiondec : "function" T_IDENT "(" paramlist ")" stmtseq "endfun."
           { cout << "RULE: functiondec ::= function identifier ( paramlist ) stmtseq endfun." << endl; }
         ;
paramlist : %empty
            { cout << "RULE: paramlist ::= empty" << endl; }
          | paramseq
            { cout << "RULE: paramlist ::= paramseq" << endl; }
          ;
paramseq : T_IDENT
           { cout << "RULE: paramseq ::= identifier" << endl; }
         | paramseq "," T_IDENT
           { cout << "RULE: paramseq ::= paramseq , identifier" << endl; }
         ;
stmtseq : statement
          { cout << "RULE: stmtseq ::= statement" << endl; }
        | stmtseq statement
          { cout << "RULE: stmtseq ::= stmtseq statement" << endl; }
        ;
statement : T_IDENT ":-" expression ";"
            { cout << "RULE: statement ::= identifier :- expression ;" << endl;}
          | "write" "(" expression ")" ";"
            { cout << "RULE: statement ::= write ( expression ) ;" << endl; }
          | "return" expression ";"
            { cout << "RULE: statement ::= return expression ;" << endl; }
          | "if" "(" expression ")" stmtseq "endif"
            { cout << "RULE: statement ::= if ( expression ) stmtseq endif;" << endl; }
          | "if" "(" expression ")" stmtseq "else" stmtseq "endif"
            { cout << "RULE: statement ::= if ( expression ) stmtseq else stmtseq endif" << endl; }
          | "while" "(" expression ")" stmtseq "endw"
            { cout << "RULE: statement ::= while ( expression ) stmtseq endw" << endl; }
          ;
expression : expression "&" expression 
             { cout << "RULE: expression ::= expression & expression" << endl; }
           | expression "+" expression
             { cout << "RULE: expression ::= expression + expression" << endl; }
           | expression "-" expression
             { cout << "RULE: expression ::= expression - expression" << endl; }
           | expression "*" expression
             { cout << "RULE: expression ::= expression * expression" << endl; }
           | expression "/" expression
             { cout << "RULE: expression ::= expression / expression" << endl; }
           | expression "<" expression
             { cout << "RULE: expression ::= expression < expression" << endl; }
           | expression "<=" expression
             { cout << "RULE: expression ::= expression <= expression" << endl; }
           | expression "=" expression
             { cout << "RULE: expression ::= expression = expression" << endl; }
           | expression "#" expression
             { cout << "RULE: expression ::= expression # expression" << endl; }
           | "~" expression
             { cout << "RULE: expression ::= ~ expression" << endl; }
           | "(" expression ")"
             { cout << "RULE: expression ::= ( expression )" << endl; }
           | T_IDENT
             { cout << "RULE: expression ::= identifier" << endl; }
           | T_STRING
             { cout << "RULE: expression ::= string" << endl; }
           | T_DECIMAL
             { cout << "RULE: expression ::= decimal" << endl; }
           | T_INTEGER
             { cout << "RULE: expression ::= integer" << endl; }
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
