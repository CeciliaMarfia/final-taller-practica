{Realizar el punto a) del ejercicio anterior, 
pero sabiendo que todos los reclamos de un mismo DNI se leen de forma consecutiva 
(no significa que vengan ordenados los DNI).
}
program ejercicioPractica;
const
	fin =  -1;
type
    reclamo = record //info del reclamo
        codigo:integer;
	    DNI:integer;
	    anio:integer;
	    tipoReclamo:integer;
	end;
    
    infoReclamo = record //es la informacion del reclamo que va dentro de cada nodo de la lista; es decir info de cada reclamo hecho por ese DNI
        rec:reclamo;
        cantReclamos:integer;
    end;
    
    lista = ^nodo;  

    nodo = record                    
    	dato: infoReclamo;
    	sig: lista;
    end;

    infoDNI = record //informacion del nodo del arbol, almacena para cada DNI que es un nodo diferente la lista de reclamos y el total de reclamos que hizo ese DNI
		dni:integer;
		reclamo:lista;
		cantReclamos:integer;
    end;
    
    arbol = ^nodoArbol;  /// ordenado por DNI
    
    nodoArbol = record
        dato: infoDNI;
        hi: arbol;
        hd: arbol;
    end;
    

{---------------Fin del type----------------}
procedure cargarArbol(var a:arbol);    
    procedure leerReclamo (var rec: reclamo);
    begin
    	with rec do begin
    		codigo := random (10)-1;
            writeln('CODIGO: ',codigo);
    		if( codigo <> fin) then begin
                write('DNI:');
                readln(DNI); //si lo hago con random no cumple el enunciado
                anio:= random (27)+2000;
                writeln('AÑO: ',anio);
    			tipoReclamo:= random(5)+1;
				writeln('RECLAMO: ',tipoReclamo);
    			writeln('----------------');
    		end;
    	end;
    end;
    
    procedure agregarAdelante(var l:lista; rec:reclamo);
    var
        aux:lista;
    begin
        new(aux);
        aux^.dato.rec := rec;
        aux^.sig := l;
        l := aux;
    end;
   procedure agregarAlArbol(var a:arbol; info:infoDNI);
    begin
        if (a = nil) then begin
            new(a);
            a^.dato := info;
            a^.hi := nil;
            a^.hd := nil;
        end
        else if (info.dni < a^.dato.dni) then
            agregarAlArbol(a^.hi, info)
        else
            agregarAlArbol(a^.hd, info);
    end;

    
var
    rec: reclamo;
    dniActual: integer;
    listaAux: lista;
    cant: integer;
    info: infoDNI;
begin
    a:=nil;
    leerReclamo(rec); //leo el reclamo
     while (rec.codigo <> fin) do begin
        dniActual := rec.DNI; //me guardo el dni actual
        listaAux := nil; //genero una lista auxiliar que es la que voy a guardar
        cant := 0; //cant de reclamos para este DNI

        while (rec.codigo <> fin) and (rec.DNI = dniActual) do begin //mientras no llegue al final y siga en el mismo dni
            agregarAdelante(listaAux, rec); //lo agrego a la lista
            cant := cant + 1; //incremento la cantidad
            leerReclamo(rec);//leo el proximo
        end;
        
        //podria modularizarlo pero acá es :
        info.dni := dniActual;  //en el registro del nodo del arbol guardo el DNI del nodo
        info.reclamo := listaAux;//en el registro del nodo del arbol guardo la lista que acabo de armar para ese dni
        info.cantReclamos := cant; //guardo la cantidad de reclamos para ese dni

        agregarAlArbol(a, info); //añado el nodo al arbol :)
     end;
end;

procedure imprimirArbol(a:arbol);
    procedure imprimirLista(l: lista);
    begin
        while (l <> nil) do begin
            writeln('  CODIGO: ', l^.dato.rec.codigo);
            writeln('  AÑO: ', l^.dato.rec.anio);
            writeln('  TIPO RECLAMO: ', l^.dato.rec.tipoReclamo);
            writeln('  --------');
            l := l^.sig;
        end;
    end;

	procedure imprimirA(a:arbol);
	begin
		if(a <> nil) then begin
			imprimirA(a^.HI);

			writeln('DNI: ', a^.dato.dni);
			writeln('Cant. reclamos: ', a^.dato.cantReclamos);
			writeln('Reclamos:');
			imprimirLista(a^.dato.reclamo);

			writeln('======================');
			imprimirA(a^.HD);
		end;
	end;
begin
	if (a = nil) then
		writeln('--ARBOL VACIO--')
	else
		imprimirA(a);
end;

{---------------Programa Principal----------------}
var
    a:arbol;
begin
	randomize;
	cargarArbol(a);
	writeln('**ARBOL FINAL**');
	imprimirArbol(a);
end.