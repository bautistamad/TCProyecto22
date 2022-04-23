grammar compiladores;

@header {
package compiladores;
}


// Dada la regla sintáctica

//declaracion -> int x;
//               double y;
//               int z = 0;
//               double w, q, t;
//               int a = 5, b, c = 10;
//
//asignacion -> x = 1;
//              z = y;
//iwhile -> while (x comp y) { instrucciones }

// iwhile -> while (x comp y) { instrucciones }

// NOTA: Entregar solamente el archivo *.g4
//fragment NUMERO: [0-9];

// iwhile -> while (x comp y) { instrucciones }

fragment DIGITO: [0-9] ;

// Special Characters
PA : '(';
PC : ')';
LA : '{';
LC : '}';
PyC: ';';
IGUAL: '=';
COMA: ',';

// Logical Operators
EQ: '==';
GT: '>';
GE: '>=';
LT: '<';
LE: '<=';
NEQ: '!=';

// Logical Expresions
AND: '&&';
OR: '||';


// Aritmetic Rules 
SUMA: '+';
RESTA: '-';
MULT: '*'; 
DIV: '/'; 
MOD: '%';

// Variables
INT : 'int' ;
DOUBLE: 'double';

// Reserve Words

IWHILE: 'while';

VAR: [a-zA-Z];
ENTERO: DIGITO+;
DOBLE: DIGITO+ '.' DIGITO+;

WS : [ \t\n\r] -> skip;

programa : instrucciones EOF ;

instrucciones : instruccion instrucciones
              |
              ;

instruccion : declaracion PyC
            | asignacion PyC
            | bucleWhile 
            ;

declaracion:  INT VAR concatenacion 
            | DOUBLE VAR concatenacion 
            | INT asignacion concatenacion 
            | DOUBLE asignacion concatenacion 
            ;

concatenacion: COMA VAR concatenacion 
              |COMA asignacion
              |
              ;

asignacion: VAR IGUAL VAR
            | VAR IGUAL ENTERO
            | VAR IGUAL DOBLE
            ;

bloque: LA instrucciones LC;

bucleWhile: IWHILE PA cond PC bloque;

cond: e comparadores e 
    | cond AND cond
    | cond OR cond
    ;


comparadores : GT
             | GE
             | LT
             | LE
             | EQ
             | NEQ
             ;

e: term exp;

exp: SUMA e
    | RESTA e
    |
    ;

term: factor t;

t: MULT term
 | DIV term
 | MOD term
 |
 ;

factor: ENTERO
      | DOBLE
      | VAR
      | PA e PC
      ;


