{1. Escribir un programa que:
a. Implemente un módulo que lea información de socios de un club y las almacene en un árbol
binario de búsqueda. De cada socio se lee número de socio, nombre y edad. La lectura finaliza
con el número de socio 0 y el árbol debe quedar ordenado por número de socio.
b. Una vez generado el árbol, realice módulos independientes que reciban el árbol como
parámetro y que :
i. Informe el número de socio más grande. Debe invocar a un módulo recursivo que
retorne dicho valor.
ii. Informe los datos del socio con el número de socio más chico. Debe invocar a un módulo
recursivo que retorne dicho socio.
iii. Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que
retorne dicho valor.
iv. Aumente en 1 la edad de todos los socios.
v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a
un módulo recursivo que reciba el valor leído y retorne verdadero o falso.
vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a
un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
vii. Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha
cantidad.
viii. Informe el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso
vii e invocar a un módulo recursivo que retorne la suma de las edades de los socios.
xi. Informe los números de socio en orden creciente.
x. Informe los números de socio pares en orden decreciente.
}
program ejercicioPractica;
const

	fin =  0;
	valorAlto= 999;
type
	
	cadena10 = String[10];

	socio = record
	    nroSocio:integer;
	    nombre:cadena10;
	    edad:integer;
	end;

    arbol = ^nodoArbol;  /// ordenado por nro de nrosocio
    
    nodoArbol = record
        dato: socio;
        hi: arbol;
        hd: arbol;
    end;

{---------------Fin del type----------------}
procedure cargarArbol(var a:arbol);

    procedure leerSocio (var soc: socio);
    begin
    	with soc do begin
    		nroSocio:= random (5);
    		writeln('Nro. socio = ', nroSocio);
    		if(nroSocio <> fin) then begin
    			write('Nombre = ');
    			readln(nombre);
    			edad:= random (50)+18;
    			writeln('Edad = ', edad);
    		end;
    	end;
    end;
    
    procedure agregarAlArbol(var a:arbol; soc:socio);
    begin
        if(a = nil) then begin
            new(a);
            a^.dato:=soc;
            a^.HI:= nil;
            a^.HD:= nil;
        end
        else
            if( soc.nroSocio <= a^.dato.nroSocio) then
                agregarAlArbol(a^.HI, soc)
            else
                agregarAlArbol(a^.HD, soc);
    end;
    
    
var
    soc:socio;
begin
    a:=nil;
    leerSocio(soc);
    while(soc.nroSocio <> fin) do begin
        agregarAlArbol(a,soc);
        leerSocio(soc);
    end;
end;

function nroSocioMayor(a:arbol):integer;
begin
    if(a = nil) then //SI EL ÁRBOL ESTÁ VACÍO RETORNO -1
        nroSocioMayor:=-1
    else
        if(a^.HD = nil) then //como busco mayor me voy por la rama derecha, si llegué a nil no hay "nodo más grande"
        nroSocioMayor:= a^.dato.nroSocio //retorno su valor
    else
       nroSocioMayor:=nroSocioMayor(a^.HD); //como aun no llegué a la hoja más derecha, llamo recursivamente con el HD.
end;

function nroSocioMenor(a:arbol):arbol;
begin
    if(a = nil) then //Si el arbol esta vacio retorno nil
        nroSocioMenor:=nil
    else
        if(a^.HI = nil) then //como busco menor me voy por la rama izquierda, si llegué a nil no hay "nodo más chico"
            nroSocioMenor:= a //retorno su valor
    else
       nroSocioMenor:=nroSocioMenor(a^.HI); //como aun no llegué a la hoja más derecha, llamo recursivamente con el HI.
end;

procedure imprimirDatos(a:arbol);
begin
    if(a <> nil) then begin
        writeln('Nro. socio: ',a^.dato.nroSocio);
        writeln('Nombre: ',a^.dato.nombre);
        writeln('Edad: ',a^.dato.edad);
    end;
end;
procedure nroSocioViejo(a:arbol; var edadMax:integer;var socioViejo:integer); //acá debo recorrer TODO el arbol porque esta ordenado por nrosocio y no por edad!
    procedure calcularEdadMaxima(edad:integer; nroSocio:integer;var edadMax,socioViejo:integer);
    begin
        if(edad > edadMax) then begin
            edadMax:=edad;
             socioViejo:=nroSocio;
        end;
    end;

begin
    if(a <> nil) then begin 
        nroSocioViejo(a^.HI,edadMax,socioViejo);
        calcularEdadMaxima(a^.dato.edad,a^.dato.nroSocio,edadMax,socioViejo);
        nroSocioViejo(a^.HD,edadMax,socioViejo);
    end;
end;

procedure incrementarEdad(var a:arbol);
begin
    if(a <> nil) then begin 
        incrementarEdad(a^.HI);
        a^.dato.edad:= a^.dato.edad+1;
        incrementarEdad(a^.HD);
    end;
end;

procedure imprimirArbol(a:arbol);
begin
    if(a <> nil) then begin 
        imprimirArbol(a^.HI);
        imprimirDatos(a);
        imprimirArbol(a^.HD);
    end;
end;

function buscar(a:arbol; nro:integer):boolean;
begin
     if(a = nil) then 
        buscar:=false
    else
        if(a^.dato.nroSocio = nro) then 
            buscar:= true
        else begin
            if(nro < a^.dato.nroSocio) then 
                buscar :=buscar(a^.HI,nro)
            else
                buscar :=buscar(a^.HD,nro);
        end;
end;

procedure buscarNombre(a:arbol; nombre:cadena10; var ok:boolean);
begin
     if(a = nil) then 
        ok:=false
    else begin
        if(a^.dato.nombre = nombre) then 
            ok:= true
        else begin
            buscarNombre(a^.HI,nombre,ok);
            buscarNombre(a^.HD,nombre,ok);
        end;
    end;
end;

function contarSocios(a:arbol):integer;
begin
    if(a  =  nil) then
        contarSocios:=0
    else
            contarSocios:= contarSocios(a^.HI)+ 1 + contarSocios(a^.HD);
end;
procedure calcularEdadPromedio(a:arbol; var edadProm:integer);
    function sumaEdades(a:arbol):integer;
    begin
        if(a = nil) then
            sumaEdades:=0
        else
            sumaEdades:=sumaEdades(a^.HI)+a^.dato.edad+sumaEdades(a^.HD);
    end;
var
    cant:integer;
begin
    cant:= contarSocios(a);
        if(cant > 0) then
            edadProm:=sumaEdades(a) div cant;
end;

procedure imprimirSociosCreciente(a:arbol);
begin
    if(a <> nil) then begin 
        imprimirSociosCreciente(a^.HI);
        writeln('Nro. socio: ', a^.dato.nroSocio);
        imprimirSociosCreciente(a^.HD);
    end;
end;

procedure imprimirSociosParesCreciente(a:arbol);
begin
    if(a <> nil) then begin 
        imprimirSociosParesCreciente(a^.HI);
        if(a^.dato.nroSocio mod 2 = 0) then
            writeln('Nro. socio: ', a^.dato.nroSocio);
        imprimirSociosParesCreciente(a^.HD);
    end;
end;
{---------------Programa Principal----------------}
var
    a,socioNroMenor: arbol;
    edadMax,edadMin,socioViejo,nro,edadProm:integer;
    nombre:cadena10;
    ok:boolean;
begin
    randomize;
    edadMax:=-1;
    edadMin:=999;
    ok:=false;
	cargarArbol(a);
	writeln('Nro de socio mayor: ',nroSocioMayor(a));
	writeln('**DATOS SOCIO NRO. MENOR**');
	socioNroMenor := nroSocioMenor(a);
	imprimirDatos(socioNroMenor);
	writeln('-------------------');
	writeln('Nro de socio con mayor edad: ');
	nroSocioViejo(a,edadMax,socioViejo);
	writeln(socioViejo);
    incrementarEdad(a);
    imprimirArbol(a);
    writeln('.................');
    writeln('Ingrese el nro. a buscar: ');
    readln(nro);
    if(buscar(a,nro)) then writeln('ENCONTRADO!')
    else
        writeln('NO ENCONTRADO!');
    writeln('.................');
    writeln('Ingrese el nombre a buscar: ');
    readln(nombre);
    buscarNombre(a,nombre,ok);
    if(ok) then writeln('ENCONTRADO!')
    else
        writeln('NO ENCONTRADO!');
    writeln('Total de socios: ',contarSocios(a));
    calcularEdadPromedio(a,edadProm);
    writeln('Edad promedio: ',edadProm); //la puse integer porque las edades no son nros reales(?)
    writeln('........NRO DE SOCIO EN ORDEN CRECIENTE.........');
    imprimirSociosCreciente(a);
    writeln('........NRO DE SOCIO PAR EN ORDEN CRECIENTE.........');
    imprimirSociosParesCreciente(a);
end.

