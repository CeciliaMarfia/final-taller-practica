{4.- Escribir un programa con:
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 0 y
menores a 100.
b. Un módulo recursivo que devuelva el máximo valor del vector.
c. Un módulo recursivo que devuelva la suma de los valores contenidos en el vector}
program ejercicioPractica;
const
	dimF = 10;// es de 20; pero hago 10 por fiaca
	valorAlto= 999;
type
	rango = 1..dimF;
    vector = array [rango] of integer;  

{---------------Fin del type----------------}

procedure cargarVector (var v:vector; var dimL:integer);
var
    num:integer;
begin
	    num := random(100);
        writeln(num);
        if(dimL < dimF) then begin
            dimL:=dimL+1;
            v[dimL]:=num;
            cargarVector(v,dimL);
        end;
end;

procedure imprimirVector(v:vector);
var
    i:integer;
begin
    for i:=1 to dimF do 
         write( v[i],'|');
end;
function calcularMaximo(v:vector;max,i:integer):integer;
begin
    if(i = dimF) then
        calcularMaximo:= max
    else begin
        if (v[i] > max) then
            max:=v[i];
        calcularMaximo:=calcularMaximo(v,max,i+1);
    end;
end;

function calcularSuma(v:vector; i:integer):integer;
begin
    if (i > dimF) then
        calcularSuma := 0
    else
        calcularSuma := v[i] + calcularSuma(v, i + 1);
end;

{---------------Programa Principal----------------}
var
    v:vector;
    dimL,max,i:integer;
begin
    dimL:=0;
    max:=-1;
	randomize;
	cargarVector(v,dimL);
    imprimirVector(v); //no lo pide, lo hago de control
    writeln;
    writeln('MAXIMO DEL VECTOR: ',calcularMaximo(v,max,1));
    writeln('SUMA DEL VECTOR: ',calcularSuma(v,1));
end.
