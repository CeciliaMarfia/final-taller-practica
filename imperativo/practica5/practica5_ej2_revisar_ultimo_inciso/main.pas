{2-Una agencia dedicada a la venta de autos ha organizado su stock y, 
dispone en papel de la información de los autos en venta. Implementar un programa que:
a) Lea la información de los autos (patente, año de fabricación (2010..2018), marca y modelo) 
y los almacene en dos estructuras de datos:
i. Una estructura eficiente para la búsqueda por patente.
ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
almacenar todos juntos los autos pertenecientes a ella.
b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
cantidad de autos de dicha marca que posee la agencia.
c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
la cantidad de autos de dicha marca que posee la agencia.
d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
la información de los autos agrupados por año de fabricación.
e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
modelo del auto con dicha patente.
f) Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
modelo del auto con dicha patente.

}
program ejercicioPractica;
const

	fin = 0 ;

type
	cadena10 = String[10];
    rangoFab= 2010..2018;
    
	auto = record
	    patente:integer;
	    anioFab:rangoFab;
	    marca:cadena10;
	    modelo:cadena10;
	end;

    autoMismaMarca = record
        patente:integer;
        anioFab:rangoFab;
        modelo:cadena10; //no pongo la marca porque sino repito informacion
    end;
    
    lista = ^nodo;
    
    nodo = record
        dato:autoMismaMarca;
        sig:lista;
    end;
    
    registroXMarca = record
        marca:cadena10;
        listaAutos:lista;
    end;

    arbol = ^nodoArbol;  /// ordenado por patente
    
    nodoArbol = record
        dato: auto;
        hi: arbol;
        hd: arbol;
    end;
    
    arbol2 = ^nodoArbol2;  /// ordenado por marca
    
    nodoArbol2 = record
        dato: registroXMarca;
        hi: arbol2; //ojo acá los arboles deben apuntar el arbol2!!!!!!!
        hd: arbol2;
    end;
    
    autoXAnio = record
	    patente:integer;
	    marca:cadena10;
	    modelo:cadena10;
	end;
    lista2 = ^nodo2;
    
    nodo2 = record
        dato:autoXAnio;
        sig:lista2;
    end;
    
    vector = array [rangoFab] of lista2;  // ordenada por año
{---------------Fin del type----------------}
procedure cargarArboles(var a:arbol; var a2:arbol2);
    procedure leerDato (var car:auto);
    begin
    	with car do begin
    		patente := random (5);
    		writeln('PATENTE: ',patente);
    		if( patente <> fin) then begin
    		    anioFab:=random(2019)-1;
    		    writeln('AÑO FABRICACION: ',anioFab);
    		    write('Ingrese marca:');
    		    readln(marca);
    		    write('Ingrese modelo:');
    		    readln(modelo);
    		end;
    	end;
    end;
    
    procedure agregarAlArbol(var a:arbol;car:auto);
    begin
        if(a=nil) then begin
            new(a);
            a^.dato:=car;
            a^.hi:=nil;
            a^.hd:=nil;
        end
        else
            if(car.patente <= a^.dato.patente) then
                agregarAlArbol( a^.hi,car)
            else
                agregarAlArbol( a^.hd,car)
        
    end;
    
    procedure armarRegistro(car:auto;var info:autoMismaMarca);
    begin
        info.patente:= car.patente;
	    info.anioFab:=car.anioFab;
	    info.modelo:=car.modelo;
    end;
    
    procedure cargarArbolDeListas(var a2:arbol2; marca: cadena10; aut: autoMismaMarca);
        procedure agregarAdelante(var l:lista; aut:autoMismaMarca);
        var
            aux:lista;
        begin
            new(aux);
            aux^.dato:=aut;
            aux^.sig:=l;
            l:=aux;
        end;
    begin
        if(a2=nil) then begin
            new(a2);
            a2^.dato.marca:= marca;
            a2^.dato.listaAutos:=nil;//TENGO QUE PONER LA LISTA EN NIL!!!!!!!!!!!!!!!
            agregarAdelante(a2^.dato.listaAutos, aut);//sino no agrega el primer nodo!!!!
            a2^.hi:=nil; //ojo acá los arboles deben apuntar el arbol2!!!!!!!
            a2^.hd:=nil;
        end
        else begin
            if(marca = a2^.dato.marca) then
                agregarAdelante(a2^.dato.listaAutos,aut)
            else 
                if(marca < a2^.dato.marca) then
                    cargarArbolDeListas(a2^.hi,marca,aut)
                else
                    cargarArbolDeListas(a2^.hd,marca,aut)
        end;
    end;
var
    car:auto;
    info: autoMismaMarca;
begin
    a:=nil;
    a2:=nil;
    leerDato(car);
    while( car.patente <> fin) do begin
        agregarAlArbol(a,car);
        armarRegistro(car, info);
        cargarArbolDeListas(a2, car.marca, info);
        leerDato(car);
    end;
end;

procedure imprimirArboles(a:arbol; a2:arbol2);
    procedure imprimirArbol(a:arbol);
    begin
        if (a <> nil) then begin
            imprimirArbol(a^.HI);
            writeln('Patente: ',a^.dato.patente);
            writeln('Año de fabricación: ',a^.dato.anioFab);
            writeln('Marca: ',a^.dato.marca);
            writeln('Modelo: ',a^.dato.modelo);
            writeln('-------------');
            imprimirArbol(a^.HD);
        end;
    end;
    
    procedure imprimirArbol2(a2:arbol2);
		procedure imprimirLista(l:lista);
		begin
			while (l <> nil) do begin
					writeln('Marca: ', a2^.dato.marca);
					writeln('Patente: ', l^.dato.patente);
					writeln('Año de fabricación: ', l^.dato.anioFab);
					writeln('Modelo: ', l^.dato.modelo);
					writeln('-------------');
			 l := l^.sig;
            end;
         end;
 
    begin
        if (a2 <> nil) then  begin
			writeln ('lista de autos para la marca: ', a2^.dato.marca);
			ImprimirLista (a2^.dato.listaAutos);
            imprimirArbol2(a2^.HI);
            imprimirArbol2(a2^.HD);
        end;
    end;
begin
    if (a = nil) then 
        writeln('--arbol vacío--')
    else begin
		writeln('--Arbol x autos');
        imprimirArbol(a);
    writeln('*****');
    end;
    if (a2 = nil) then 
        writeln('--arbol vacío--')
    else begin
    writeln('--Arbol x Marca--');
        imprimirArbol2(a2);
     end
end;
function cantAutosXMarcaArbol1(a: arbol; marca: cadena10): integer;
begin
    if (a = nil) then
        cantAutosXMarcaArbol1 := 0
    else begin
        if (a^.dato.marca = marca) then
            //coincide sumo y sigo buscando
            cantAutosXMarcaArbol1 := 1 + cantAutosXMarcaArbol1(a^.hi, marca) + cantAutosXMarcaArbol1(a^.hd, marca)
        else
            
            //no coincide, sigo buscando
            cantAutosXMarcaArbol1 := cantAutosXMarcaArbol1(a^.hi, marca) + cantAutosXMarcaArbol1(a^.hd, marca);
    end;
end;

procedure inicializarVecListas(var v:vector);
var
    i:rangoFab;
begin
    for i:=2010 to 2018 do
        v[i]:=nil;
end;

function cantAutosXMarca(a2:arbol2; marca:cadena10; total:integer):integer;
begin
    if (a2 = nil) then
        cantAutosXMarca := total
    else if (a2^.dato.marca = marca) then begin
        while (a2^.dato.listaAutos <> nil) do begin
            total := total + 1;
            a2^.dato.listaAutos := a2^.dato.listaAutos^.sig;
        end;
        cantAutosXMarca := total;
    end
    else if (marca < a2^.dato.marca) then
        cantAutosXMarca := cantAutosXMarca(a2^.hi, marca, total)
    else
        cantAutosXMarca := cantAutosXMarca(a2^.hd, marca, total);
end;

procedure cargarVectorListas(var v:vector; a:arbol);
    procedure cargarRegistro(auto2:auto; var reg:autoXAnio);
    begin
        reg.patente:=auto2.patente;
        reg.marca:=auto2.marca;
        reg.modelo:=auto2.modelo;
    end;
    procedure agregarAdelante2(var l:lista2; reg:autoXAnio);
        var
            aux:lista2;
        begin
            new(aux);
            aux^.dato:=reg;
            aux^.sig:=l;
            l:=aux;
        end;
var
    auto2: autoXAnio;
begin
    if (a <> nil) then  begin
        cargarRegistro(a^.dato, auto2);
        agregarAdelante2(v[a^.dato.anioFab],auto2);
        cargarVectorListas(v,a^.hi);
        cargarVectorListas(v,a^.hd);
    end;
end;


procedure buscarPatente(a:arbol; patente:integer; var modelo:cadena10);
begin
     if (a = nil) then
        modelo:= 'no hay'
     else begin
        if (a^.dato.patente = patente) then
            modelo:= a^.dato.modelo
        else begin
            if(patente < a^.dato.patente) then
               buscarPatente(a^.HI,patente,modelo)
            else
                buscarPatente(a^.HD,patente,modelo);
        end;
     end;
end;

procedure buscarPatenteArbol2(a:arbol2; patente:integer; var modelo:cadena10);

begin
     if (a <> nil) then
        modelo:= 'no hay'
    else begin
        while (a^.dato.listaAutos <> nil) and (a^.dato.listaAutos^.dato.patente<> patente) do   
		  a^.dato.listaAutos := a^.dato.listaAutos^.sig; //AVANZAR EN LA LISTA
		if ((a^.dato.listaAutos <> nil)) then
		    modelo:= a^.dato.listaAutos^.dato.modelo;
        if(a^.dato.listaAutos = nil) then begin
            buscarPatenteArbol2(a^.HI,patente,modelo);
            buscarPatenteArbol2(a^.HD,patente,modelo);
        end;
    end;
end;


{---------------Programa Principal----------------}
var
    a:arbol;
    a2:arbol2;
    marca,modelo:cadena10;
    v:vector;
    buscado:arbol;
    patente:integer;
begin
	randomize;
	cargarArboles(a,a2);
	imprimirArboles(a,a2);
	write('INGRESE UNA MARCA: ');
    readln(marca);
    writeln('CANTIDAD DE AUTOS PARA LA MARCA: ',marca,' ',cantAutosXMarcaArbol1(a,marca));
	writeln('-----EN ARBOL 2--------');
    write('INGRESE UNA MARCA: ');
    readln(marca);
    writeln('CANTIDAD DE AUTOS PARA LA MARCA: ',marca,' ',cantAutosXMarca(a2,marca,0));
    inicializarVecListas(v);
    cargarVectorListas(v,a);
    write('INGRESE UNA PATENTE: ');
    readln(patente);
    buscarPatente(a,patente,modelo);
    writeln('Modelo: ',modelo);
    write('INGRESE UNA PATENTE: ');
    readln(patente);
    buscarPatenteArbol2(a2,patente,modelo);
    writeln('Modelo: ',modelo);
end.
