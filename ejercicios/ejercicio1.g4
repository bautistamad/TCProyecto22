grammar compiladores;

@header {
package compiladores;
}

// 1er Ejercicio
// Definir una Expresión Regular para capturar fechas correspondientes a 
// los meses pares (formato DD/MM/YYYY)
// // Agarra todas las posiblidades de Dia
fragment DIA : ('0'[1-9]|'1'[0-9]|'2'[0-9]|'3'[0-1]) ;

// // Agarra las posiblididades de mes que queremos (Pares)
fragment MES : '/'('0'[2468] | '1'[02]) ;

// // Agarra todas las posiblidades de anio (entre 1000 a 2999)
fragment ANO : '/'([1-2])([0-9])([0-9])([0-9]);

FECHA : (DIA)(MES)(ANO);

ID: (FECHA)([ \t\r\n]+);

OTRO: . ;

s : ID   { System.out.println("ID ->" + $ID.getText() + "<--"); }     s
 | FECHA   { ; }     s
 | OTRO  { ; }   s
 | EOF
 ;