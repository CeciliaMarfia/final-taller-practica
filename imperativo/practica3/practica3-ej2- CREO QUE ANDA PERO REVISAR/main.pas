{2. Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee código de producto, fecha y cantidad de unidades vendidas. La lectura finaliza con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. Cada nodo del árbol debe contener el código de producto y la cantidad total de unidades vendida.
Nota: El módulo debe retornar los dos árboles.
b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.
2023
c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne
la cantidad total de unidades vendidas de ese producto.

}
program ejercicioPractica;
const
	fin =  0;
type
    rangoDia = 1..31;
    rangoMes =1..12;
    rangoAnio = 1900..2050;
    
	cadena = String[10];
    fecha = record 
        dia:rangoDia;
        mes:rangoMes;
        anio:rangoAnio;
    end;
	venta = record
	    codProd:integer;
	    fecha:fecha;
        unidadesVendidas:integer;
	end;


    arbol = ^nodoArbol;  /// ordenado por codProd
    
    nodoArbol = record
        dato: venta;
        hi: arbol;
        hd: arbol;
    end;
    
    productoVendido = record
	    codProd:integer;
        unidadesVendidas:integer;
	end;
    arbol2 = ^nodoArbol2;  /// ordenado por codProd
    
    nodoArbol2 = record
        dato: productoVendido;
        hi: arbol2;
        hd: arbol2;
    end;

{---------------Fin del type----------------}

procedure cargarArbol(var a:arbol;var a2:arbol2);
    procedure leerVenta (var ven: venta);
        procedure leerFecha (var fec: fecha);
        begin
        	with fec do begin
        		dia := random (30)+1;
        		writeln('Dia: ',dia);
        		mes := random (11)+1;
        		writeln('Mes: ',mes);
        		anio := random (5)+2020;
        		writeln('Año: ',dia);
        	end;
        end;
    begin
    	with ven do begin
    		codProd := random (10);
    		writeln('Cod. Producto: ',codProd);
    		if( codProd <> fin) then begin
    		    writeln('Fecha: ');
    		    leerFecha(fecha);
    		    unidadesVendidas := random (30);
    		    writeln('Cant. unidades vendidas: ',unidadesVendidas);
    		end;
    	end;
    end;
    
    procedure agregarAlArbol(var a:arbol; ven:venta);
    begin
        if(a = nil) then begin
            new(a);
            a^.dato:=ven;
            a^.hi:=nil;
            a^.hd:=nil;
        end
        else
            if(ven.codProd <= a^.dato.codProd) then
                agregarAlArbol(a^.hi,ven)
            else
                agregarAlArbol(a^.hd,ven);
    end;
    
    procedure insertarAlArbol(var a2:arbol2;var prod:productoVendido);
    begin
         if(a2 = nil) then begin
                new(a2);
                a2^.dato.codProd:=prod.codProd;
                a2^.dato.unidadesVendidas:=prod.unidadesVendidas;
                a2^.hi:=nil;
                a2^.hd:=nil;
            end
            else if(prod.codProd = a2^.dato.codProd) then
                a2^.dato.unidadesVendidas := a2^.dato.unidadesVendidas + prod.unidadesVendidas
            else if(prod.codProd < a2^.dato.codProd) then
                insertarAlArbol(a2^.hi, prod)
            else
                insertarAlArbol(a2^.hd, prod);
    end;
var
    ven:venta;
    prod:productoVendido;
begin
    a:=nil; a2:=nil;
    leerVenta(ven);
    while(ven.codProd <> fin) do begin
        prod.codProd := ven.codProd;
        prod.unidadesVendidas := ven.unidadesVendidas;
        agregarAlArbol(a,ven);
        insertarAlArbol(a2,prod);
        leerVenta(ven);
    end;
end;
    
    
procedure imprimirArbol(a:arbol);
begin
    if(a<>nil) then begin
        imprimirArbol(a^.hi);
        writeln('Cod. Producto: ',a^.dato.codProd);
        writeln('fecha: ',a^.dato.fecha.anio);
        writeln('Cant. unidades vendidas: ',a^.dato.unidadesVendidas);
        writeln('-------------------');
        imprimirArbol(a^.hd);
    end;
end;

procedure buscarVendidos(a:arbol; cod:integer; var total:integer);
begin
    if(a<>nil) then
        if(cod = a^.dato.codProd) then 
            total:= total + a^.dato.unidadesVendidas
        else
            if(cod < a^.dato.codProd) then //es importante aprovechar el orden en la busqueda y no recorrer todo si ya se que el codigo que tengo es mayor o menos del nodo que estoy actualmente
                buscarVendidos(a^.hi, cod,total)
            else
                buscarVendidos(a^.hd, cod,total);
end;

procedure buscarVendidosArbol2(a2:arbol2; cod:integer; var total:integer);
begin
    if(a2<>nil) then
        if(cod = a2^.dato.codProd) then 
            total:= a2^.dato.unidadesVendidas
        else
            if(cod < a2^.dato.codProd) then //es importante aprovechar el orden en la busqueda y no recorrer todo si ya se que el codigo que tengo es mayor o menos del nodo que estoy actualmente
                buscarVendidosArbol2(a2^.hi, cod,total)
            else
                buscarVendidosArbol2(a2^.hd, cod,total);
end;
{---------------Programa Principal----------------}
var
    a:arbol;
    a2:arbol2;
    cod,total:integer;
begin
	randomize;
	total:=0;
	cargarArbol(a,a2);
	imprimirArbol(a);
	writeln('Codigo el código a buscar ARBOL 1:');
	cod:=random(5)+1;
	writeln(cod);
    buscarVendidos(a,cod,total);
    writeln('TOTAL: ',total);
    writeln('*************');
    writeln('Codigo el código a buscar ARBOL 2:');
	cod:=random(5)+1;
	writeln(cod);
    buscarVendidosArbol2(a2,cod,total);
    writeln('TOTAL: ',total);
end.
