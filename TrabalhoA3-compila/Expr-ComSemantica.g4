grammar Expr;

options { tokenVocab=ExprLexer; }

program
    : stat* EOF
    ;

stat
    : ID '=' expr ';'
        {
            // Verificação de tipo para atribuição
            if (!isDeclared($ID.text)) {
                System.err.println("Erro: Variável '" + $ID.text + "' não foi declarada.");
            } else if (!getType($ID.text).equals(getExprType(expr()))) {
                System.err.println("Erro: Tipos incompatíveis na atribuição para '" + $ID.text + "'.");
            }
        }
    | expr ';'
    ;

def
    : ID '(' ID (',' ID)* ')' '{' stat* '}'
        {
            // Adiciona a função à tabela de símbolos
            declareFunction($ID.text);
        }
    ;

expr returns [String type]
    : ID
        {
            // Verificação de tipo para variável
            if (!isDeclared($ID.text)) {
                System.err.println("Erro: Variável '" + $ID.text + "' não foi declarada.");
                $type = "error";
            } else {
                $type = getType($ID.text);
            }
        }
    | INT
        {
            $type = "int";
        }
    | func
    | 'not' e=expr
        {
            // Verificação de tipo para operação 'not'
            if (!$e.type.equals("int")) {
                System.err.println("Erro: Operação 'not' aplicada a um tipo não inteiro.");
                $type = "error";
            } else {
                $type = "int";
            }
        }
    | left=expr 'and' right=expr
        {
            // Verificação de tipo para operação 'and'
            if (!$left.type.equals("int") || !$right.type.equals("int")) {
                System.err.println("Erro: Operação 'and' aplicada a tipos não inteiros.");
                $type = "error";
            } else {
                $type = "int";
            }
        }
    | left=expr 'or' right=expr
        {
            // Verificação de tipo para operação 'or'
            if (!$left.type.equals("int") || !$right.type.equals("int")) {
                System.err.println("Erro: Operação 'or' aplicada a tipos não inteiros.");
                $type = "error";
            } else {
                $type = "int";
            }
        }
    ;

func returns [String id]
    : i=ID LParen e=expr (Comma e=expr)* RParen
        {
            // Verificação de tipo para chamada de função
            String functionName = (i != null) ? i.getText() : "error";
            if (!isFunctionDeclared(functionName)) {
                System.err.println("Erro: Função '" + functionName + "' não foi declarada.");
                $id = "error";
            } else {
                $id = functionName;
            }
        }
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

// Estrutura de dados para rastrear informações dos símbolos
String[] variableDeclarations = new String[100]; // ajuste o tamanho conforme necessário
String[] functionDeclarations = new String[100]; // ajuste o tamanho conforme necessário

// Índice atual para rastrear a próxima posição disponível nos arrays
int variableIndex = 0;
int functionIndex = 0;

// Métodos auxiliares para manipular a tabela de símbolos
boolean isDeclared(String id) {
    for (int i = 0; i < variableIndex; i++) {
        if (id.equals(variableDeclarations[i])) {
            return true;
        }
    }
    return false;
}

void declareVariable(String id) {
    variableDeclarations[variableIndex++] = id;
}

String getType(String id) {
    // Lógica para obter o tipo da variável
    // Pode ser necessário um mapeamento ou uma lógica mais complexa
    return "int";
}

void declareFunction(String id) {
    functionDeclarations[functionIndex++] = id;
}

boolean isFunctionDeclared(String id) {
    for (int i = 0; i < functionIndex; i++) {
        if (id.equals(functionDeclarations[i])) {
            return true;
        }
    }
    return false;
}
