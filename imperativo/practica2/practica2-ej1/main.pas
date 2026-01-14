{1.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto, los
almacene en un vector con dimensión física igual a 10 y retorne el vector.
b. Un módulo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un módulo recursivo que reciba el vector generado en a) e imprima el contenido del vector..
d. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne la cantidad de caracteres leídos. El programa debe informar el valor retornado.
e. Un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y
retorne una lista con los caracteres leídos.
f. Un módulo recursivo que reciba la lista generada en e) e imprima los valores de la lista en el
mismo orden que están almacenados.
g. Implemente un módulo recursivo que reciba la lista generada en e) e imprima los valores de
la lista en orden inverso al que están almacenados.
}
program Hello;
const
    dimF = 10;
    fin = '.';
type
    lista = ^nodo;
    
    nodo = record
        dato:char;
        sig:lista;
    end;
    
    vector = array[1..dimF] of char;
//---------fin del type-----------

procedure cargarVector(var v:vector; var dimL:integer);
var
   car:char; 
begin
    write('Ingrese un caracter: ');
    readln(car);
    if(car <>fin) and (dimL < dimF) then begin
        dimL:= dimL+1;
        v[dimL]:=car;
        cargarVector(v,dimL);
    end;
    
end;
procedure imprimirVector(v:vector; dimL:integer);
var
   i:integer; 
begin
    for i:=1 to dimL do
       writeln(v[i]);
end;
procedure contadorChars(var cant:integer);
var
    car: char;
begin
    write('Ingrese un caracter: ');
    readln(car);
    if (car<>fin) then begin
        cant:= cant +1;
        contadorChars(cant);
    end;
end;

procedure imprimirVectorRecursivo(v:vector; dimL:integer; i:integer);
begin
    if(dimL = 0) then
        writeln('-- vector sin elementos --')
    else
        if (i <= dimL) then begin 
           writeln(v[i]);
           imprimirVectorRecursivo(v,dimL,i+1);
        end;
end;

procedure cargarLista(var l:lista);
    procedure agregarAdelante (var l: lista; dato: char);
	var
		aux: lista;
	begin
		new(aux);
		aux^.dato := dato;
		aux^.sig := l;
		l:= aux;
	end;
var 
    car:char;
begin
    //OJO QUE SI HAGO L:=NIL ACÁ EN CADA LLAMADA RECURSIVA ESO BORRA LA LISTA CADA VEZ.
    write('Ingrese un caracter: ');
    readln(car);
    if(car <> fin) then begin
        agregarAdelante(l,car);
        cargarLista(l);
    end;
end;
procedure imprimirLista(l:lista);
begin
    if(l <> nil) then begin
        imprimirLista(l^.sig);
        writeln(l^.dato);
    end;
end;
procedure imprimirListaInvertida(l:lista);
begin
    if(l <> nil) then begin
        writeln(l^.dato);
        imprimirLista(l^.sig);
    end;
end;
//-------programa principal------
var
    v:vector; 
    dimL,i,cant:integer;
    l:lista;
begin
    dimL:=0;
    cant:=0;
    l:=nil;
    cargarVector(v,dimL);
    imprimirVector(v,dimL);
    writeln('ahora recursivo: ');
    imprimirVectorRecursivo(v,dimL,1);
    contadorChars(cant);
    writeln('total leídos: ',cant);
    cargarLista(l);
    imprimirLista(l);
    writeln('lista invertida: ');
    imprimirListaInvertida(l);
end.
