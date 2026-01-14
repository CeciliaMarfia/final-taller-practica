{2.- Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número
leído, sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo
recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 256, se debe
imprimir 2 5 6}
program Hello;
const
    fin = 0;
//--fin del const--
procedure imprimirRecursivo(num:integer);
var
    dig:integer;
begin
    if (num <> fin) then begin
        dig:=num mod 10; // me quedo con el ultimo digito
        num:=num div 10; //le quito el ultimo digito
        imprimirRecursivo(num);
        write(dig);
    end;
end;
procedure leerNumero(num:integer);
begin
    write('Ingrese un número:');
    readln(num);
    while(num <> fin) DO begin
        imprimirRecursivo(num);
        writeln ('Ingrese un número:');
        readln(num);
    end;
end;
//--------PP---------
var
    num:integer;
begin
    leerNumero(num);
    imprimirRecursivo(num);
end.
