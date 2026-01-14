{3. Un supermercado requiere el procesamiento de sus productos. 
De cada producto se conoce código, rubro (1..10), stock y precio unitario. Se pide:
a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su vez, 
para cada rubro, se requiere que la búsqueda de un producto por código sea lo más eficiente posible.
La lectura finaliza con el código de producto igual a -1.
b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código de producto y 
retorne si dicho código existe o no para ese rubro.
c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada rubro, el código y 
stock del producto con mayor código.
d) Implementar un módulo que reciba la estructura generada en a), dos códigos y retorne, para cada rubro, 
la cantidad de productos con códigos entre los dos valores ingresados.

}
program ejercicioPractica;
const
	dimF = 10;
	fin =  -1;

type
	rango = 1..dimF;

	producto = record
	    codigo:integer;
	    rubro:rango;
	    stock:integer;
	    precioUnitario:real;
	end;

    arbol = ^nodoArbol;  /// ordenado por codigo
    
    nodoArbol = record
        dato: producto;
        hi: arbol;
        hd: arbol;
    end;
    
     vector = array [rango] of arbol;  // ordenada por ...

{---------------Fin del type----------------}
procedure inicializarVector(var v:vector);
var
    i:rango;
begin
    for i:=1 to dimF do
        v[i]:=nil;
end;
procedure cargarVector(var v:vector);
    procedure leerProducto (var prod: producto);
    begin
    	with prod do begin
    		codigo := random (10)-1;
    		writeln('Codigo: ',codigo);
    		if( codigo <> fin) then begin
        		rubro := random (9)+1;
        		writeln('rubro: ',rubro);
        		stock := random (100);
        		writeln('stock: ',stock);
        		precioUnitario := random (1000);
        		writeln('Precio unitario: $',precioUnitario:2:2);
        		writeln('................');
    		end;
    	end;
    end;
    
    procedure agregarAlArbol(var a:arbol;prod:producto);
    begin
        if(a=nil) then begin
            new(a);
            a^.dato:=prod;
            a^.hi:=nil;
            a^.hd:=nil;
        end
        else
            if(prod.codigo <= a^.dato.codigo) then
                agregarAlArbol(a^.hi,prod)
            else
                agregarAlArbol(a^.hd,prod)
    end;
var
    prod:producto;
begin
    leerProducto(prod);
    while ( prod.codigo <> fin) do begin
        agregarAlArbol(v[prod.rubro],prod);
        leerProducto(prod);
    end;
end;
procedure imprimir(v:vector);
    procedure imprimirArbol(a:arbol);
    begin
        if(a <> nil) then begin
            imprimirArbol(a^.hi);
            writeln('CODIGO: ',a^.dato.codigo);
        	writeln('STOCK: ',a^.dato.stock);
        	writeln('PRECIO UNITARIO: $',a^.dato.precioUnitario:2:2);
        	writeln('................');
            imprimirArbol(a^.hd);
        end;
    end;
var
    i:rango;
begin
    for i:=1 to dimF do begin
        if(v[i] = nil) then
            writeln('-RUBRO ',i, ' VACÍO-')
        else begin 
            writeln('***RUBRO ',i,'***');
            imprimirArbol(v[i]);
            writeln('--------------');
        end;
    end;
end;

function buscar(a:arbol;codigo:integer):boolean;
begin
    if(a = nil) then
        buscar:=false
    else
        if(a^.dato.codigo = codigo) then
            buscar:=true
        else begin
            if(codigo < a^.dato.codigo) then
                buscar:=buscar(a^.hi,codigo)
            else
                buscar:=buscar(a^.hd,codigo)
        end;
end;

procedure maximoPorRubro(v:vector);
    procedure calcularMaximo(a:arbol;var maxCod,maxStock:integer);
    begin
        if(a^.hd = nil) then begin //el de la derecha es el mas grande por eso miro ese primero!
            maxCod:= a^.dato.codigo;
            maxStock:= a^.dato.stock;
    end
    else
      calcularMaximo(a^.hd,maxCod,maxStock);//conviene siempre llamar a la derecha aprovechando el orden ;)
    end;
var
    i:rango;
    maxCod,maxStock:integer;
begin
    for i:=1 to dimF do begin
        maxCod:=-1;
        maxStock:=-1;
        if (v[i] = nil) then
			writeln('Arbol vacio ')
		else begin
            calcularMaximo(v[i],maxCod,maxStock);
            writeln('MAXIMO RUBRO ',i, 'CODIGO: ',maxCod,' STOCK: ',maxStock);
        writeln('--------------');
        end;
    end;
end;

procedure entreValores(v:vector; codigo1,codigo2:integer);
    function contarCantidad(a: arbol; codigo1, codigo2: integer): integer;
    begin
        if (a = nil) then
            contarCantidad := 0 //si el arbol esta vacio no suma nada
        else 
            if (a^.dato.codigo < codigo1) then 
                contarCantidad := contarCantidad(a^.hd, codigo1, codigo2)
            else if (a^.dato.codigo > codigo2) then
                contarCantidad := contarCantidad(a^.hi, codigo1, codigo2)
            else
                contarCantidad := 1 + contarCantidad(a^.hi, codigo1, codigo2) + contarCantidad(a^.hd, codigo1, codigo2);
    end;
var
    i:rango;
begin
    for i:=1 to dimF do begin
        if (v[i] = nil) then
			writeln('Arbol vacio ')
		else 
            writeln('RUBRO ',i, 'CANTIDAD: ',(contarCantidad(v[i],codigo1,codigo2)));
        writeln('--------------');
    end;
end;
{---------------Programa Principal----------------}
var
    v:vector;
    rubro:rango;
    codigo,codigo1,codigo2:integer;
begin
	randomize;
	inicializarVector(v);
	cargarVector(v);
	imprimir(v);
	write('-Rubro a buscar:');
	readln(rubro);
	write('-Codigo a buscar:');
    readln(codigo);
	if (buscar(v[rubro],codigo)) then writeln('ENCONTRADO!')
	else
	    writeln('NO ENCONTRADO!');
	maximoPorRubro(v);
	write('-Codigo 1 a buscar:');
    readln(codigo1);
    write('-Codigo 2 a buscar:');
    readln(codigo2);
	entreValores(v,codigo1,codigo2);
end.
