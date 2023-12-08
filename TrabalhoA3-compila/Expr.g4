grammar Expr;

options { tokenVocab=ExprLexer; }

program
    : stat EOF
    | def EOF
    ;

stat
    : ID Assign expr SemiColon
    | expr SemiColon
    ;

def
    : ID LParen ID (Comma ID)* RParen LBrace stat* RBrace
    ;

expr
    : ID
    | INT
    | func
    | Not expr
    | expr And expr
    | expr Or expr
    ;

func
    : ID LParen expr (Comma expr)* RParen
    ;

Assign : '=';
SemiColon : ';';
LParen : '(';
RParen : ')';
LBrace : '{';
RBrace : '}';
Comma : ',';
Not : 'not';
And : 'and';
Or : 'or';
ID : [a-zA-Z]+;
INT : [0-9]+;
