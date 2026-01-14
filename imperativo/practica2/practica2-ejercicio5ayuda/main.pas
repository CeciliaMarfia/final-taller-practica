{5.- Implementar un módulo que realice una búsqueda dicotómica en un vector, utilizando el
siguiente encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
en el vector

}
program ejercicio5Practica2;
const
	dimF = 5;
type
	indice = 1..dimF;
	vector = array [indice] of integer;
{---------------Fin del type----------------}

procedure leerDato (var x: tipoDato);
begin
	with “x” do begin
		xxx := random ();
		if( “xxx” <> fin) then begin
			
		end;
	end;
end;


procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);

{---------------Programa Principal----------------}
var
	v:vector;
	ini,fin,dato,pos:integer;
begin
	randomize;
end.

