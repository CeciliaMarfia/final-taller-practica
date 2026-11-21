{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}
program p1Ejercicio2;
const
    dimF = 300;
    fin = -1;
type

    oficina = record
        codIdentificacion: integer;
        DNI : integer;
        valorExpensa : real;
    end;
    
    vector = array[1..dimF] of oficina;
//----------fin del type ----------
procedure cargarVector(var v:vector; var dimL:integer);
    procedure leerOficina(var ofi:oficina);
    begin
        write('Ingrese cod de verificacion :');
        readln(ofi.codIdentificacion);
        if(ofi.codIdentificacion <> fin) then begin
            write('Ingrese DNI:');
            readln(ofi.DNI);
            write('Ingrese valor de expensa: $');
            readln(ofi.valorExpensa);
        end;
    end;
    
    procedure agregarAlVector(var v:vector; var dimL:integer; ofi:oficina);
    begin
        if(dimL< dimF) then begin
            dimL:=dimL+1;
            v[dimL]:= ofi;
            
        end;
    end;
var
    ofi:oficina;
begin
    leerOficina(ofi);
    while(ofi.codIdentificacion <> fin) do begin
        agregarAlVector(v,dimL,ofi);
        leerOficina(ofi);
    end;
end;

procedure imprimirVector(v:vector; dimL:integer);
var
    i:integer;
begin
    for i:=1 to dimL do begin
        writeln('-----------');
        writeln(v[i].codIdentificacion);
        writeln('-----------');
    end;
end;


{--------------------------------Ordenar por Inserción----------------------------------------}
procedure ordenInsercion(var v: vector; dimL: integer);
var
    i, j: integer;
    actual: oficina;
begin
    for i := 2 to dimL do begin
        actual := v[i];
        j := i - 1;
        while (j > 0) and (v[j].codIdentificacion > actual.codIdentificacion) do begin
            v[j + 1] := v[j];
            j := j - 1;
        end;
        v[j + 1] := actual;
    end;
end;


{--------------------------------Ordenar por Selección----------------------------------------}
procedure ordenarSeleccion(var v: vector; dimL: integer); // de mayor a menor
var
    i, j, min: integer;
    item: oficina;
begin
    for i := 1 to dimL - 1 do begin
        min := i;
        for j := i + 1 to dimL do
            if (v[j].codIdentificacion < v[min].codIdentificacion) then
                min := j;
        item := v[min];
        v[min] := v[i];
        v[i] := item;
    end;
end;

//-------programa principal--------
var
    v:vector;
    dimL:integer;
begin
    dimL:=0;
    cargarVector(v,dimL);
    imprimirVector(v,dimL);
    ordenInsercion(v, dimL);
    writeln('----INSERCION-------');
    imprimirVector(v,dimL);
    ordenarSeleccion(v, dimL);
    writeln('-----SELECCION------');
    imprimirVector(v,dimL);
end.