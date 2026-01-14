{3. Una facultad nos ha encargado procesar la información de sus alumnos de la carrera XXX.
Esta carrera tiene 30 materias. Implementar un programa con:
a. Un módulo que lea la información de los finales rendidos por los alumnos y los
almacene en dos estructuras de datos.
i. Una estructura que para cada alumno se almacenen sólo código y nota de las
materias aprobadas (4 a 10). De cada final rendido se lee el código del alumno, el
código de materia y la nota (valor entre 1 y 10). La lectura de los finales finaliza con
nota -1. La estructura debe ser eficiente para buscar por código de alumno.
ii. Otra estructura que almacene para cada materia, su código y todos los finales
rendidos en esa materia (código de alumno y nota).
b. Un módulo que reciba la estructura generada en i. y un código de alumno y retorne los
códigos y promedios de los alumnos cuyos códigos sean mayor al ingresado.
c. Un módulo que reciba la estructura generada en i., dos códigos de alumnos y un valor
entero, y retorne la cantidad de alumnos con cantidad de finales aprobados igual al
valor ingresado para aquellos alumnos cuyos códigos están comprendidos entre los dos
códigos de alumnos ingresados.
}program ejercicioPractica;
const
	dimF =  30;
	fin =  -1;
type
	rango = 1..dimF;
    rangoNota= 1..10;
    rangoAprobado= 4..10;
    
	alumno = record
	    codMateria:integer;
	    nota:rangoAprobado;
	end;
    
    final = record
        codAlumno: integer;
        codMateria:;
        nota:rangoNota;
    end;
    vector = array [rango] of alumno;  // ordenada por ...

    arbol = ^nodoArbol;  /// ordenado por ...
    
    nodoArbol = record
        dato: final;
        hi: arbol;
        hd: arbol;
    end;

    lista = ^nodo;  // ordenada por ...

    nodo = record                    //SI HAY MAS DE UNA LISTA O UN ARBOL CAMBIAR NOMBRE
    	dato: ;
    	sig: lista;
    end;
{---------------Fin del type----------------}

procedure leerDato (var x: tipoDato);
begin
	with “x” do begin
		xxx := random ();
		if( “xxx” <> fin) then begin
			
		end;
	end;
end;

{---------------Programa Principal----------------}
var

begin
	randomize;
	lalista:=nil;
end.
