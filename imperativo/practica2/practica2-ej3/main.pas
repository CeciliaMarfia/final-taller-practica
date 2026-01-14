{3.- Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random”
mayores a 0 y menores a 100. Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
encuentra en la lista o falso en caso contrario.}
program ejercicio3Practica2;
const
    fin = 0;
type
    lista = ^nodo; 

    nodo = record                    
        dato: integer;
        sig: lista;
    end;

{---------------Fin del type----------------}
procedure cargarLista(var l:lista);
    
    procedure leerRandom (var num:integer);
    begin
    	writeln('Ingrese un nro mayor a 0 y menor a 100');
    	num := random (10);//es a 100 pero lo hago para probar
    	writeln(num);
    end;
    
    procedure agregarAdelante(var l:lista; dato:integer);
    var
        nue:lista;
    begin
        new(nue);
        nue^.dato:=dato;
        nue^.sig:=l;
        l:=nue;
    end;
var 
    num:integer;
begin
    //si inicializo la lista acá la pierdo!!!!!
    leerRandom(num);
    if (num <> fin) then begin //recordar que en recursión SIEMPRE SE USA IF
        agregarAdelante(l,num);
        cargarLista(l);
    end;
end;
procedure imprimirLista(l:lista);
begin
    while (l <> nil) do begin
        write(l^.dato,'|');
        l:=l^.sig;
    end;
end;

function calcularMinimo(l:lista; min:integer):integer;
begin
    if (l = nil) then
        calcularMinimo:= min
    else begin
        if(l^.dato < min ) then
            min:= l^.dato;
        calcularMinimo:=calcularMinimo(l^.sig, min);
    end;
end;

function calcularMaximo(l:lista; max:integer):integer;
begin
    if (l = nil) then
        calcularMaximo:= max
    else begin
        if(l^.dato > max ) then 
            max:= l^.dato;
        calcularMaximo:= calcularMaximo(l^.sig, max);
    end;
end;

function buscarNum(l:lista;num:integer):boolean;
begin
    if(l = nil) then
        buscarNum:=false
    else
        if(l^.dato = num) then
             buscarNum:=true
        else
            buscarNum:= buscarNum(l^.sig, num);
end;
{---------------Programa Principal----------------}
var
    l:lista;
    min,max,nro:integer;
begin
    l:=nil;
    min:=999;
    max:=-1;
	randomize;
	cargarLista(l);
	imprimirLista(l); //no lo pide lo hago yo de control
	writeln();
    writeln('--------------');
	writeln('MIN: ',calcularMinimo(l,min));
	writeln('MAX: ',calcularMaximo(l,max));
    writeln('--------------');
    write('Nro. a buscar:');
    readln(nro);
    writeln;
    if(buscarNum(l,nro)) then writeln('ENCONTRADO!')
    else
        writeln('NO ENCONTRADO!');
end.
