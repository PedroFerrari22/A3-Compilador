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