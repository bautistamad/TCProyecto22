grammar compiladores;

@header {
package compiladores;
}

//3er Ejercicio
//Definir una Expresión Regular para capturar horas correspondientes a las horas 
//entre las 18:30 y las 21:30 (formato HH:MM)
// Agarra todas las posiblidades de Dia
fragment DIA : ('0'[1-9]|'1'[0-9]|'2'[0-9]|'3'[0-1]);

// Agarra las posiblididades de mes que queremos (Pares)
fragment MES : '/'('0'[1-9] | '1'[0-2]) ;

// Agarra todas las posiblidades de anio (entre 1000 a 2999)
fragment ANO : '/'([1-2])([0-9])([0-9])([0-9]);

fragment MIN1 : ':'(([3-5][0-9]));

fragment HORA1 : ( ('1'[8]) )':'(([3-5][0-9]));
fragment HORA2 : ( ('1'[9]) )':'(([0-5][0-9])) | ( ('2'[0]) )':'(([0-5][0-9]));
fragment HORA3 : ( ('2'[1]) )':'(([0-2][0-9]) | '30');

HORA_1 : HORA1 ;
HORA_2 : HORA2 ;
HORA_3 : HORA3 ;

FECHA : (DIA)(MES)(ANO);

ID: (FECHA)([ \t\r\n]+)(HORA_1) | (FECHA)([ \t\r\n]+)(HORA_2) | (FECHA)([ \t\r\n]+)(HORA_3);

OTRO: . ;
//
s : ID   { System.out.println("ID ->" + $ID.getText() + "<--"); }     s
 | FECHA   { ; }     s
 | OTRO  { ; }   s
 | EOF
 ;