{2. Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN -1. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada  ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
h. Un módulo recursivo que reciba la estructura generada en h. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
}
program ejercicioPractica;
const
	fin =  -1;

type
	rangoDia = 1..31;
	rangoMes = 1..12;

	prestamo = record
	    isbn: integer;
	    nroSocio:integer;
	    dia:rangoDia;
	    mes:rangoMes;
	    cantDiasPrestados:integer;
	end;

    lista = ^nodo;  // ordenada por ISBN

    nodo = record                    
    	dato: prestamo;
    	sig: lista;
    end;

    arbol = ^nodoArbol;  /// ordenado por ISBN
    
    nodoArbol = record
        dato: prestamo;
        hi: arbol;
        hd: arbol;
    end;
    
    arbol2 = ^nodoArbol2;  /// ordenado por ...
    
    nodoArbol2 = record
        dato: lista;
        hi: arbol;
        hd: arbol;
    end;

{---------------Fin del type----------------}

    procedure leerPrestamo (var pres: prestamo);
    begin
    	with pres do begin
    		isbn := random (10)-1;
    		writeln('ISBN: ',isbn);
    		if( isbn <> fin) then begin
    		    nroSocio:= random (100);
        		writeln('Nro. Socio: ',nroSocio);
        		dia:= random (30)+1;
        		writeln('Dia: ',dia);
        		mes:= random (11)+1;
        		writeln('Mes: ',mes);
    		    cantDiasPrestados:= random (30);
    		    writeln('Días de préstamo: ',cantDiasPrestados);
    		    writeln('......................');
    		end;
    	end;
    end;
    
procedure cargarArbol(var a:arbol);
    procedure agregarAlArbol(var a:arbol; pres:prestamo);
    begin
        if (a=nil) then begin
            new(a);
            a^.dato:= pres;
            a^.HI:= nil;
            a^.HD:= nil;
        end
        else
            if (pres.isbn <a^.dato.isbn) then
                agregarAlArbol(a^.HI,pres)
            else
                agregarAlArbol(a^.HI,pres);
    end;
var
    pres:prestamo;
begin
    leerPrestamo(pres);
    while(pres.isbn <> fin) do begin
        agregarAlArbol(a,pres);
        leerPrestamo(pres);
    end;
end;

procedure cargarArbol2(var a:arbol2);
    procedure agregarAlArbol(var a:arbol; pres:prestamo);
    var
        l:lista;
    begin
        if (a=nil) then begin
            new(a);
            agregarAdelante(l,pres);
            a^.dato:= l;
            a^.HI:= nil;
            a^.HD:= nil;
        end
        else
            if (pres.isbn <a^.dato.isbn) then
                agregarAlArbol(a^.HI,pres)
            else
                agregarAlArbol(a^.HI,pres);
    end;
var
    pres:prestamo;
begin
    leerPrestamo(pres);
    while (pres.isbn <> fin) do begin
        agregarAlArbolDeListas(a,pres);
        leerPrestamo(pres);
    end;
end;

{---------------Programa Principal----------------}
var
    a:arbol;
    a2:arbol2;
begin
	randomize;
    cargarArbol(a);
    cargarArbolListas(a2);
end.
