# Analisis Sintáctico

Genera un árbol sintáctico (parse tree)

El árbol tiene:
 1- Raíz -> Símbolo inicial -> regla de inicio
 2- Nodos -> Reglas gramaticales
 3- Hojas -> Terminales (tokens)

 Nodos tienen 1 o más hijos

----

## Descendente

desde la raíz hacia las Hojas

acciones -> derivar y match

```
s : ( s ) s
  |
  ;
```

Entrada ->  (())()

```
$ s            (())() $ derivar
$ s ) s (      (())() $ match
$ s ) s         ())() $ derivar
$ s ) s ) s (   ())() $ match
$ s ) s ) s      ))() $ derivar
$ s ) s )        ))() $ match
$ s ) s           )() $ derivar
$ s )             )() $ match
$ s                () $ derivar
$ s ) s (          () $ match
$ s ) s             ) $ derivar
$ s )               ) $ match
$ s                   $ derivar
$                     $ OK
```

Entrada ->  `())()`

```
$ s             ())() $ derivar
$ s ) s (       ())() $ match
$ s ) s          ))() $ derivar
$ s )            ))() $ match
$ s               )() $ derivar
$                 )() $ Error
```

Entrada ->  `((()`

```
$ s              ((() $ derivar
$ s ) s (        ((() $ match
$ s ) s           (() $ derivar
$ s ) s ) s (     (() $ match
$ s ) s ) s        () $ derivar
$ s ) s ) s ) s (  () $ match
$ s ) s ) s ) s     ) $ derivar
$ s ) s ) s )       ) $ match
$ s ) s ) s           $ derivar
$ s ) s )             $ Error
```

---

## **Ascendente**

acciones -> desplazar y reducir

```
s : ( s ) s
  |
  ;
```

Entrada ->  `(())()`

```
$              (())() $ desplazar
$ (             ())() $ desplazar
$ ( (            ))() $ reducir
$ ( ( s          ))() $ desplazar
$ ( ( s )         )() $ reducir
$ ( ( s ) s       )() $ reducir
$ ( s             )() $ desplazar
$ ( s )            () $ desplazar
$ ( s ) (           ) $ reducir
$ ( s ) ( s         ) $ desplazar
$ ( s ) ( s )         $ reducir
$ ( s ) ( s ) s       $ reducir
$ ( s ) s             $ reducir
$ s                   $ OK

```

Entrada ->  `())()`

```
$               ())() $ desplazar
$ (              ))() $ reducir
$ ( s            ))() $ desplazar
$ ( s )           )() $ reducir
$ ( s ) s         )() $ reducir
$ s               )() $ Error
```

Entrada ->  `((()`

```
$               ((() $ desplazar
$ (              (() $ desplazar
$ ( (             () $ desplazar
$ ( ( (            ) $ reducir
$ ( ( ( s          ) $ desplazar
$ ( ( ( s )          $ reducir
$ ( ( ( s ) s        $ reducir
$ ( ( s              $ Error
```

-------------

AS Descendente

exp : term e ;

e : MAS   term e
  | MENOS term e
  |
  ;

term : ENTERO
     ;

Entrada --> 5 - 10 + 6

```
$ exp                5 - 10 + 6 $ derivar
$ e term             5 - 10 + 6 $ derivar
$ e ENTERO           5 - 10 + 6 $ match
$ e                    - 10 + 6 $ derivar
$ e term MENOS         - 10 + 6 $ match
$ e term                 10 + 6 $ match
$ e                         + 6 $ derivar
$ e term MAS                + 6 $ match
$ e term                      6 $ match
$ e                             $ derivar
$                               $ OK
```

Entrada --> 5 - + 10 + 6

```
$ exp                5 - + 10 + 6 $ derivar
$ e term             5 - + 10 + 6 $ match
$ e                    - + 10 + 6 $ derivar
$ e term MENOS         - + 10 + 6 $ match
$ e term                 + 10 + 6 $ ERROR
```
-------------

AS Ascendente

exp : term e ;

e : MAS   term e
  | MENOS term e
  |
  ;

term : ENTERO
     ;

Entrada --> 5 - 10 + 6
```
$                    5 - 10 + 6 $ desplazar
$ 5                    - 10 + 6 $ reducir
$ ENTERO               - 10 + 6 $ reducir
$ term                 - 10 + 6 $ desplazar
$ term MENOS             10 + 6 $ desplazar
$ term MENOS term           + 6 $ desplazar
$ term MENOS term MAS         6 $ desplazar
$ term MENOS term MAS term      $ reducir
$ term MENOS term MAS term e    $ reducir
$ term MENOS term e             $ reducir
$ term e                        $ reducir
$ exp                           $ OK
```

Entrada --> 5 - + 10 + 6
```
$                    5 - + 10 + 6 $ desplazar
$ term                 - + 10 + 6 $ desplazar
$ term MENOS             + 10 + 6 $ desplazar
$ term MENOS MAS           10 + 6 $ desplazar
$ term MENOS MAS term         + 6 $ desplazar
$ term MENOS MAS term MAS       6 $ desplazar
$ term MENOS MAS term MAS term    $ reducir
$ term MENOS MAS term MAS term e  $ reducir
$ term MENOS MAS term e           $ reducir
$ term MENOS e                    $ ERROR
```

