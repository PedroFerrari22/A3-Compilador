alvo -> expr
expr -> expr + termo | expr – termo | termo
termo -> termo * fator | termo / fator | fator
fator -> (exp) | num | nome


grammar Expr;
prog:   (expr NEWLINE)* ;
expr:   expr ('*'|'/') expr
    |   expr ('+'|'-') expr
    |   INT
    |   '(' expr ')'
    ;
NEWLINE : [\r\n]+ ;
INT     : [0-9]+ ;

