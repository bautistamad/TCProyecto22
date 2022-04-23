grammar compiladores;

@header {
package compiladores;
}
/*
    Dado el proyecto base de Java con ANTLR presentado en clases, realizar el archivo .g4 que contemple lo siguiente:

    Definir una Expresión Regular para capturar fechas correspondientes a los meses pares (formato DD/MM/YYYY).
    Definir una Expresión Regular para capturar horas correspondientes a las horas entre las 08:00 y las 12:59 (formato HH:MM).
    Definir una Expresión Regular para capturar horas correspondientes a las horas entre las 18:30 y las 21:30 (formato HH:MM).

    Al ejecutar el programa, deberá imprimir en pantalla el número de línea, el tipo de token y el token encontrado (ver archivo ejemplo adjunto). 
*/


// 2do Ejercicio
// Definir una Expresión Regular para capturar horas correspondientes a 
// las horas entre las 08:00 y las 12:59 (formato HH:MM)
// Agarra todas las posiblidades de Dia
fragment DIA : ('0'[1-9]|'1'[0-9]|'2'[0-9]|'3'[0-1]); 
// Agarra las posiblididades de mes que queremos (Pares)
fragment MES : '/'('0'[1-9] | '1'[0-2]); 
// Agarra todas las posiblidades de anio (entre 1000 a 2999)
fragment ANO : '/'([1-2])([0-9])([0-9])([0-9]);
fragment HORA1 : ( ('0'[89]) | ([1][0-2]) )':'([0-5][0-9]);
HORA_1 : HORA1;
FECHA : (DIA)(MES)(ANO);
ID: (FECHA)([ \t\r\n]+)(HORA_1);
OTRO: . ;
s : ID   { System.out.println("ID ->" + $ID.getText() + "<--"); }     s
 | FECHA   { ; }     s
 | OTRO  { ; }   s
 | EOF
 ;