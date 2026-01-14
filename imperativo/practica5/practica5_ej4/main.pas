{Una oficina requiere el procesamiento de los reclamos de las personas. 
De cada reclamo se lee código, DNI de la persona, año y tipo de reclamo. 
La lectura finaliza con el código de igual a -1. Se pide:
a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. 
Para cada DNI se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de reclamos efectuados por ese DNI.
c) Un módulo que reciba la estructura generada en a)
y dos DNI y retorne la cantidad de reclamos efectuados por todos los DNI comprendidos entre
los dos DNI recibidos.
d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de los reclamos 
realizados en el año recibido.
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
    
    listaAnio = ^nodoLista;
	nodoLista = record
		dato: integer;
		sig: listaAnio;
	end;
{---------------Fin del type----------------}
procedure cargarArbol(var a:arbol);    
    procedure leerReclamo (var rec: reclamo);
    begin
    	with rec do begin
    		codigo := random (10)-1;
            writeln('CODIGO: ',codigo);
    		if( codigo <> fin) then begin
    		    DNI:= random (100);
                writeln('DNI: ',DNI);
                anio:= random (27)+2000;
                writeln('AÑO: ',anio);
    			tipoReclamo:= random(5)+1;
				writeln('RECLAMO: ',tipoReclamo);
    			writeln('----------------');
    		end;
    	end;
    end;
    
    procedure cargarRegistro(rec:reclamo; var info:infoReclamo);
    begin
        info.rec:= rec;
        info.cantReclamos:=1; //cuenta reclamos individuales
    end;
    
    procedure agregarAlArbol(var a:arbol; info:infoReclamo; dni:integer);
        procedure agregarAdelante(var l:lista; info:infoReclamo);
        var
            aux:lista;
        begin
            new(aux);
            aux^.dato:=info;
            aux^.sig:=l;
            l:=aux;
        end;
    begin
        if(a = nil )then begin //si el arbol esta vacio
            new(a); //genero el nodo
            a^.dato.dni:=dni; //le asigno el DNI al nodo
            a^.dato.cantReclamos:=1;//inicializo el contador de reclamos
            a^.dato.reclamo:=nil; //inicializo la lista para ESE DNI
            agregarAdelante(a^.dato.reclamo,info); //agrego adelante el reclamo en dicha lista
            a^.HI:=nil; //inicializo los punteros de los hijos
            a^.HD:=nil;
        end
        else if (dni = a^.dato.dni ) then begin //si el DNI ya se encuentra en el arbol
            a^.dato.cantReclamos:=a^.dato.cantReclamos+1; //incremento el contador para ese DNI
            agregarAdelante(a^.dato.reclamo,info); //agrego el reclamo a la lista de ese DNI
        end
        else if (dni < a^.dato.dni ) then //sino lo agrego segun corresponda
            agregarAlArbol(a^.HI,info,dni)
        else
            agregarAlArbol(a^.HD, info,dni);
    end;
    
var
    rec:reclamo;
    info:infoReclamo;
begin
    a:=nil;
    leerReclamo(rec); //leo el reclamo
    while (rec.codigo <> fin) do begin //mientras no finalice la carga de reclamos
        cargarRegistro(rec,info); //cargo la información del reclamo que va a ir dentro de la lista
        agregarAlArbol(a,info,rec.DNI); //al agregarAlArbol le envio el arbol, el reclamo  que va en la lista y el DNI al que se le va a agregar
        leerReclamo(rec);
    end;
end;

procedure imprimirArbol(a:arbol);
	procedure imprimirA(a:arbol);
	begin
		if(a <> nil) then begin
			imprimirA(a^.HI);
			writeln('DNI: ',a^.dato.dni);
			writeln('reclamo: ',a^.dato.cantReclamos);
			writeln('----------------');
			imprimirA(a^.HD);
		end;
	end;
begin
	if (a = nil) then
		writeln('--ARBOL VACIO--')
	else
		imprimirA(a);
end;


function reclamosEfectuados(a:arbol; dni:integer):integer;
begin
    if(a = nil) then
        reclamosEfectuados:=0
    else
        if(a^.dato.dni = dni) then
            reclamosEfectuados:=a^.dato.cantReclamos
        else
            if(dni < a^.dato.dni ) then
                reclamosEfectuados:=reclamosEfectuados(a^.HI,dni)
            else
                reclamosEfectuados:=reclamosEfectuados(a^.HD,dni);
end;

function reclamosEntreDNI(a:arbol;DNI1,DNI2:integer):integer;
begin
     if(a = nil) then
        reclamosEntreDNI:=0
    else
        if(a^.dato.dni < DNI1) then
            reclamosEntreDNI:=reclamosEntreDNI(a^.HD,DNI1,DNI2)
        else
            if(a^.dato.dni > DNI2) then
                reclamosEntreDNI:=reclamosEntreDNI(a^.HI,DNI1,DNI2)
            else
                 reclamosEntreDNI:=a^.dato.cantReclamos+reclamosEntreDNI(a^.HI,DNI1,DNI2)+reclamosEntreDNI(a^.HD,DNI1,DNI2)          
        
end;

procedure generarListaAnioArb(a:arbol; anio:integer; var l:listaAnio);
    procedure generarListaAnioLis(pri:lista; anio:integer; var l:listaAnio);
        procedure agregarAdelante(var l:listaAnio; cod:integer);
        var
            aux:listaAnio;
        begin
            new(aux);
            aux^.dato:=cod;
            aux^.sig:=l;
            l:=aux;
        end;
    begin
        while(pri <> nil) do begin
            if(pri^.dato.rec.anio = anio) then
                agregarAdelante(l, pri^.dato.rec.codigo);
            pri:= pri^.sig;    
        end;
    end;
begin
    if(a <> nil) then begin
       generarListaAnioArb(a^.HI,anio,l);
       generarListaAnioLis(a^.dato.reclamo,anio,l); //le estoy mandando el puntero inicial de la lista
       generarListaAnioArb(a^.HD,anio,l);
    end;
end;

procedure imprimirListaAnio(l: listaAnio);
begin
	while(l<>nil) do
		begin
			write(' | CODIGO=', l^.dato);
			l:= l^.sig;
		end;
end;

{---------------Programa Principal----------------}
var
    a:arbol;
    DNI,DNI1,DNI2,anio:integer;
    l: listaAnio;
begin
	randomize;
	cargarArbol(a);
	imprimirArbol(a);
	write('Ingrese el DNI a buscar:');
    readln(DNI);
    writeln('Cantidad de reclamos efectuados para el DNI: ',DNI,': ',reclamosEfectuados(a,DNI));
    write('Ingrese el DNI inicio a buscar:');
    readln(DNI1);
    write('Ingrese el DNI fin a buscar:');
    readln(DNI2);
    writeln('Cantidad de reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos: ',reclamosEntreDNI(a,DNI1,DNI2));
    write('Ingrese el año a buscar:');
    readln(anio);
    l:= nil;
	generarListaAnioArb(a, anio, l);
	write('Lista para el anio ', anio, ': ');
	imprimirListaAnio(l);
end.
