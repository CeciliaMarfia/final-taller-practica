{1.- Implementar un programa que procese la información de los alumnos de la Facultad de
Informática.
a) Implementar un módulo que lea y retorne, en una estructura adecuada, la información de
todos los alumnos. De cada alumno se lee su apellido, número de alumno, año de ingreso,
cantidad de materias aprobadas (a lo sumo 36) y nota obtenida (sin contar los aplazos) en cada
una de las materias aprobadas. La lectura finaliza cuando se ingresa el número de alumno
11111, el cual debe procesarse.
b) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne número
de alumno y promedio de cada alumno.
c) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de
materias aprobadas de cada alumno, y si además se desean registrar los aplazos? ¿cómo
puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?
}
program Hello;
const
    fin = 11111;
    dimF = 36;
type
    cadena30 = string[30];
    rango = 1..dimF;
    vecNotas = array [rango] of integer;
    alumno = record
        ape:cadena30;
        nroAlu:integer;
        ingreso:integer;
        cantAprob:integer;
        notas: vecNotas;
    end;
    
    lista = ^nodo;
    nodo = record
        dato:alumno;
        sig:lista;
    end;
//-------------------FIN DEL TYPE-----------------------    
procedure cargarListado(var l:lista);
    procedure crearVecNotas (var v: vecNotas; var dimL: integer);
    var
        i, nota:integer;
    begin
        writeln('==========carga de notas==========');
        for i:=1 to dimL do begin
		    write('Ingrese nota:');
            readln(nota);
		    v[dimL] := nota;
	    end;
	    writeln('==========fin de carga==========');
    end;

    procedure leerAlumno(var alu:alumno);
    begin
        write('Ingrese nro. de alumno:');
        readln(alu.nroAlu);
        if (alu.nroAlu <> fin) then begin
            write('Ingrese apellido:');
            readln(alu.ape);
            write('Ingrese año de ingreso:');
            readln(alu.ingreso);
            write('Ingrese cantidad de materias aprobadas:');
            readln(alu.cantAprob);
            crearVecNotas(alu.notas,alu.cantAprob);
        end;
    end;
    procedure agregarAdelante (var pri: lista; dato: alumno);
    var
         aux: lista;
    begin
        new (aux); //reservo memoria para el nuevo nodo
        aux^.dato := dato; //guardo el registro del alumno en el nodo
        aux^.sig := pri; //hago que el puntero al siguiente apunte a pri
        pri := aux; //reasigno el puntero
    end;

var
    alu:alumno;
begin
    l:=nil;
    leerAlumno(alu);
    while(alu.nroAlu <> fin) do begin
        agregarAdelante(l, alu);
        leerAlumno(alu);
    end;
end;
//---------------Programa principal-----------------------
var
l:lista;
begin
  cargarListado(l);
  //recorrerListado(l,)
end.
