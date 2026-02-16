program final26_02_2025;
const
    fin = 0;
type
    rango = 1..17;
    cadena20 = string[20];
    
    egresado = record
        nombre:cadena20;
        legajo:integer;
        facu:rango;
        prom:real;
    end;
    
    arbol = ^nodoArbol;
    
    nodoArbol = record
        dato:egresado;
        HI:arbol;
        HD:arbol;
    end;
    
    vector = array [rango] of arbol;
    
//_______fin del type______
procedure cargarArbol(var a:arbol);
    procedure leerEgresado(var egr:egresado);
    begin
        with egr do begin
            prom:=random(10)-1;
            writeln('PROMEDIO: ',prom:2:2);
            if(prom > fin) then begin
                legajo:=random(1000)+1;
                writeln('LEGAJO: ',legajo);
                facu:=random(17)+1;
                writeln('FACULTAD: ',facu);
                write('NOMBRE: ');
                readln(nombre);
                writeln('----------------');
            end;
        end;
    end;
    
    procedure agregarAlArbol(var a:arbol; dato:egresado);
    begin
        if(a = nil) then begin
            new(a);
            a^.dato:=dato;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if(dato.legajo <= a^.dato.legajo) then
                agregarAlArbol(a^.HI,dato)
            else
                agregarAlArbol(a^.HD,dato);
    end;
var
    egr:egresado;
begin
    a:=nil;
    leerEgresado(egr);
    while(egr.prom > fin) do begin
        agregarAlArbol(a,egr);
        leerEgresado(egr);
    end;
end;

procedure imprimirArbol(a:arbol);
begin
    if(a <>nil) then begin
        imprimirArbol(a^.HI);
        writeln('LEGAJO: ',a^.dato.legajo);
        writeln('NOMBRE: ',a^.dato.nombre);
        writeln('PROMEDIO: ',a^.dato.prom:2:2);
        writeln('FACULTAD: ',a^.dato.facu);
        writeln('----------------');
        imprimirArbol(a^.HD);
    end;
end;

procedure inicializarVecArboles(var v:vector);
var
    i:rango;
begin
    for i:=1 to 17 do
        v[i]:=nil;
end;

procedure cargarVector(a:arbol; var v:vector);
    procedure agregarNodo(var a:arbol;dato:egresado);
    begin
        if(a = nil) then begin
            new(a);
            a^.dato:=dato;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if(dato.prom <= a^.dato.prom) then
                agregarNodo(a^.HI,dato)
            else
                agregarNodo(a^.HD,dato);
    end;
begin
    if(a <>nil) then begin
        cargarVector(a^.HI,v);
        agregarNodo(v[a^.dato.facu],a^.dato);
        cargarVector(a^.HD,v);
    end;
end;

procedure imprimirVector(v:vector);
var
    i:rango;
begin
    for i:=1 to 17 do begin
        writeln('---FACULTAD:  ',i);
        imprimirArbol(v[i]);
    end;
end;

procedure mejorPromedio(a:arbol;var max:real; var nombre:cadena20);
begin
    if(a <>nil) then begin
        if(a^.HD = nil) then begin
                max:= a^.dato.prom;
                nombre:=a^.dato.nombre;
            end
            else
                mejorPromedio(a^.HD,max,nombre);
    end;
end;
//_______pp_______
var
    a:arbol;
    v:vector;
    fac:integer;
    max:real;
    nombre:cadena20;
begin
    nombre:=' ';
    max:=-1;
    randomize;
    cargarArbol(a);
    writeln('*****ARBOL POR LEGAJO*****');
    imprimirArbol(a);
    inicializarVecArboles(v);
    cargarVector(a,v);
    writeln('*****VECTOR POR FACU X PROM*****');
    imprimirVector(v);
    write('Ingrese facultad:');
    readln(fac);
    mejorPromedio(v[fac],max,nombre);
    write('MEJOR PROMEDIO PARA FACULTAD: ',fac,' es: ',nombre);
end.
