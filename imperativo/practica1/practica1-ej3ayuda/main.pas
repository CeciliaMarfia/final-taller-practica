{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
diciembre de 2022. De cada película se conoce: código de película, código de género (1: acción,
2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje
promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1.
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c).
}
program p1Ejercicio3;
const
    fin = -1;
    dimF = 8;
type
    rangoGenero = 1..dimF;
    pelicula = record
        codPelicula:integer;
        codGenero:rangoGenero;
        puntajeProm:real;
    end;
    
    lista = ^nodo;
    
    nodo = record
        dato:pelicula;
        sig:lista;
    end;
    
    vector = array[rangoGenero] of lista;
    
    mayorPuntaje = record
        codPelicula:integer;
        puntaje:real;
    end;
    
    vectorPuntajes = array[rangoGenero] of pelicula;
//_________fin del type_________
procedure inicializarVector(var v:vector);
var
    i:integer;
begin
    for i:=1 to 8 do
        v[i]:=nil;
end;

procedure cargarVector(var v:vector);
    procedure leerPelicula(var peli:pelicula);
    begin
        write('Ingrese el código de pelicula: ');
        readln(peli.codPelicula);
        if(peli.codPelicula <> fin) then begin
            write('Ingrese el código de género: ');
            readln(peli.codGenero);
            write('Ingrese puntaje promedio: ');
            readln(peli.puntajeProm);
        end;
    end;
    
    procedure agregarAtras (var pri, ult: lista; dato: pelicula);
    var
        aux: lista; 
    begin
        new(aux);
        aux^.dato := dato;
        aux^.sig := nil;
        if (pri = nil) then // si esta vacia
            pri := aux
        else // si no esta vacia
            ult^.sig := aux;
        ult := aux;
    end;

var
    peli:pelicula;
    ult:lista;
begin
    ult:=nil;
    leerPelicula(peli);
    while(peli.codPelicula <> fin) do begin
        agregarAtras(v[peli.codGenero],ult,peli);
        leerPelicula(peli);
    end;
end;

procedure generarVecPuntajes(v:vector; var vPuntajes);
    procedure calcularMaximo(peli:pelicula;var puntajeMax:real; var maxP);
    begin
        if(peli.puntajeProm >puntajeMax) then
            puntajeMax:=peli.puntajeProm;
            maxP.codPelicula = peli.codPelicula;
            maxP.puntajeProm = peli.puntajeProm;
    end;
var
    i:integer;
    puntajeMax:real;
    maxP: pelicula;
begin
    for i:=1 to 8 do begin
        puntajeMax:=-1;
        while(v[i] <> nil) do begin
            calcularMaximo(v[i]^.dato,puntajeMax),maxP;
            v[i]:= v[i]^.sig;
        end;
        vPuntajes[i]:=puntajeMax;
    end;
end;

procedure ordenarSeleccion(var v: vector); // de mayor a menor
var
    i, j, min: integer;
    item: real;
begin
    for i := 1 to 7 do begin
        min := i;
        for j := i + 1 to 7 do
            if (v[j]< v[min]) then
                min := j;
        item := v[min];
        v[min] := v[i];
        v[i] := item;
    end;
end;

//_________programa principal_________
var
    l:lista;
    v:vector;
    vPuntajes:vectorPuntajes;
begin
    inicializarVector(v);
    cargarVector(v,l);
    generarVecPuntajes(v,vPuntajes);
    ordenarSeleccion(vPuntajes);
    writeln('Mayor Puntaje:',vPuntajes[1]:2:2, ' Menor Puntaje:', vPuntajes[1]:2:2);
end.
