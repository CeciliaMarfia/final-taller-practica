{3. Implementar un programa que contenga:
a. Un módulo que lea información de alumnos de Taller de Programación y los almacene en una estructura de datos. 
De cada alumno se lee legajo, DNI, año de ingreso y 
los códigos y notas de los finales rendidos. 
La estructura generada debe ser eficiente para la búsqueda por número de legajo. 
La lectura de los alumnos finaliza con legajo 0 y 
para cada alumno el ingreso de las materias finaliza con el código de materia -1.
b. Un módulo que reciba la estructura generada en a. y retorne los DNI y año de ingreso 
de aquellos alumnos cuyo legajo sea inferior a un valor ingresado como parámetro.
c. Un módulo que reciba la estructura generada en a. y retorne el legajo más grande.
d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.
e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.
e. Un módulo que reciba la estructura generada en a. y retorne el legajo y el promedio del alumno con mayor promedio.
f. Un módulo que reciba la estructura generada en a. y un valor entero. Este módulo debe retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}
program ejercicioPractica;
const
	fin =  0;
	finMateria = -1;
	valorAlto= 999;
type
	final = record
        codigo:integer;
        nota:integer;
    end;

    lista = ^nodo;  // ordenada por codigo

    nodo = record                    
    	dato: final;
    	sig: lista;
    end;
	
	rangoAnio = 1900..2050;
    
	alumno = record
	    legajo:integer;
	    DNI:integer;
	    anioIngreso:rangoAnio;
	    materia:lista;
	end;
	
    arbol = ^nodoArbol;  /// ordenado por legajo
    
    nodoArbol = record
        dato: alumno;
        hi: arbol;
        hd: arbol;
    end;
    
    infoAlumno = record
        dni:integer;
        ingreso:rangoAnio;
    end;
    
    lista2 = ^nodo2;
    
    nodo2 = record
        dato:infoAlumno;
        sig: lista2;
    end;
{---------------Fin del type----------------}
procedure crearArbol(var a:arbol);
    procedure leerAlumno(var alu: alumno);
        procedure leerMateria(var mat:final);
        begin
            with mat do begin
                write('Codigo de materia: ');
                readln(codigo);
                if(codigo<> finMateria) then begin
                    nota:= random (10)+1;
                    writeln('Nota: ',nota);
                end;
            end;
        end;
        
        procedure agregarAdelante(var l:lista; dato: final);
        var
            aux:lista;
        begin
            new(aux);
            aux^.dato:=dato;
            aux^.sig:=l;
            l:=aux;
        end;
    var
        mat:final;
    begin
    	with alu do begin
    		legajo := random (10);
    		writeln('Legajo: ',legajo);
    		if( legajo <> fin) then begin
    		    anioIngreso := random (5)+2020;
    		    writeln('Año ingreso: ',anioIngreso);
    		    DNI := random (100);
    		    writeln('DNI: ',DNI);
    		    materia:=nil; //inicializo la lista para ESTE nodo
    		    leerMateria(mat);
    			while(mat.codigo <> finMateria) do begin
                    agregarAdelante(materia,mat);
                    leerMateria(mat);
                end;
                writeln('----------------');
            end;
    	end;
    end;
    
    procedure agregarAlArbol(var a: arbol;alu:alumno);
    begin
        if(a=nil) then begin
            new(a);
            a^.dato:=alu;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if(alu.legajo < a^.dato.legajo) then
                agregarAlArbol(a^.HI,alu)
            else
                agregarAlArbol(a^.HD,alu)
    end;
var
    alu:alumno;
begin
    leerAlumno(alu);
    while(alu.legajo <> fin) do begin
        agregarAlArbol(a,alu);
        leerAlumno(alu);
    end;
end;

procedure recorrerArbol(a:arbol; var l:lista2; legajo:integer);
    procedure agregarAdelante2(var l:lista2; dato: infoAlumno);
    var
        aux:lista2;
    begin
        new(aux);
        aux^.dato:=dato;
        aux^.sig:=l;
        l:=aux;
    end;
var
    info:infoAlumno;
begin
    if(a <> nil) then begin //si el arbol no está vacío
        recorrerArbol(a^.HI,l,legajo);
        if(a^.dato.legajo < legajo ) then begin //como cumple lo agrego a la lista, primero cargando el registro
            info.DNI:=a^.dato.DNI;
            info.ingreso:=a^.dato.anioIngreso;
            agregarAdelante2(l,info);
        end;
        recorrerArbol(a^.HD,l,legajo)
    end;
end;

procedure imprimirLista2(l:lista2);
begin
    while(l <> nil) do begin
        writeln('DNI: ',l^.dato.dni);
        writeln('Año de ingreso: ',l^.dato.ingreso);
        writeln('.....................');
        l:=l^.sig;
    end;
end;

function buscarLegajoMayor(a:arbol):integer;
begin
    if(a^.HD = nil) then //legué al H más D
        buscarLegajoMayor:=a^.dato.legajo
    else buscarLegajoMayor(a^.HD); //sigo buscando a la derecha
end;

function buscarDNIMayor(a: arbol): integer; //preguntar, no lo hice yo :(
var
    maxHI, maxHD, maxActual: integer;
begin
    if (a = nil) then
        buscarDNIMayor := -1
    else begin
        maxActual := a^.dato.DNI;
        maxHI := buscarDNIMayor(a^.HI);
        maxHD := buscarDNIMayor(a^.HD);

        buscarDNIMayor := maxActual;

        if (maxHI > buscarDNIMayor) then
            buscarDNIMayor := maxHI;
        if (maxHD > buscarDNIMayor) then
            buscarDNIMayor := maxHD;
    end;
end;
function impares(a:arbol):integer;
begin
    if(a = nil) then
        impares:=0
    else begin
        impares:=impares(a^.HI)+impares(a^.HD);
        if (a^.dato.legajo mod 2 = 1) then
            impares := impares + 1;
    end;
end;

procedure calcularAlumno(a:arbol;var legajoMejor:integer; var promedioMejor:real);
    procedure calcularPromedio(legajo:integer;l:lista; var legajoMejor:integer; var promedioMejor:real);
    var
        totalFinales, totalNota:integer; 
        promedio:real;
        aux:lista;
    begin
        totalFinales:=0;
        totalNota:=0;
        aux := l;   // no toco la lista original
         while(aux <> nil) do begin
            totalFinales:=totalFinales+1;
            totalNota:=totalNota + aux^.dato.nota;
            aux:=aux^.sig;
        end;
        if (totalFinales > 0) then begin //evito división por cero
            promedio:= totalNota / totalFinales;
            if(promedio > promedioMejor) then begin
                legajoMejor:=legajo;
                promedioMejor:=promedio;
            end;
        end;
    end;
begin
    if(a <> nil) then begin
        calcularAlumno(a^.HI,legajoMejor,promedioMejor);
        calcularPromedio(a^.dato.legajo, a^.dato.materia, legajoMejor,promedioMejor);
        calcularAlumno(a^.HD,legajoMejor,promedioMejor);
    end;
end;
{---------------Programa Principal----------------}
var
    a:arbol;
    l:lista2;
    legajo, legajoMejor:integer;
    promedioMejor:real;
begin
	randomize;
	crearArbol(a);
	write('LEGAJO A BUSCAR:');
	readln(legajo);
    recorrerArbol(a,l,legajo);
    writeln('==================');
    imprimirLista2(l);
    writeln('Legajo más grande: ',buscarLegajoMayor(a));
    writeln('DNI más grande: ',buscarDNIMayor(a));
    writeln('# Alumnos con legajo impar: ',impares(a));
    calcularAlumno(a,legajoMejor,promedioMejor);
end.
