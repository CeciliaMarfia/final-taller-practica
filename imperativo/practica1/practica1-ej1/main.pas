{1.- Se desea procesar la información de las ventas de productos de un comercio (como máximo 50).
Implementar un programa que invoque los siguientes módulos:
a. Un módulo que retorne la información de las ventas en un vector. De cada venta se conoce el día de la venta, 
código del producto (entre 1 y 15) y cantidad vendida (como máximo 99 unidades). 
El código debe generarse automáticamente (random) y la cantidad se debe leer. 
El ingreso de las ventas finaliza con el día de venta 0 (no se procesa).
b. Un módulo que muestre el contenido del vector resultante del punto a).
c. Un módulo que ordene el vector de ventas por código.
d. Un módulo que muestre el contenido del vector resultante del punto c).
e. Un módulo que elimine, del vector ordenado, las ventas con código de producto entre 
dos valores que se ingresan como parámetros.
f. Un módulo que muestre el contenido del vector resultante del punto e).
g. Un módulo que retorne la información (ordenada por código de producto de menor a mayor) 
de cada código par de producto junto a la cantidad total de productos vendidos.
h. Un módulo que muestre la información obtenida en el punto g).
}

program Hello;
const
    dimF = 10;//--ES 50 PERO USO 10
    fin = 0;
    max = 99;
type
    rangoVentas = 1..dimF;
    rangoDia = 1..31;
    rangoProd = 1..15;
    rangoVenta = 0..max; 
    venta = record
        dia: rangoDia;
        codProd: rangoProd;
        cantVendida: integer;
    end;
    
    vecVentas = array [rangoVentas] of venta; //ordenado como se lee
    
    infoVenta = record
        codProducto: rangoProd;
        totalVendido: integer;
    end;
    vectorMenorAMayor = array [rangoVenta] of infoVenta; //ordenado de menor a mayor

// --------FIN DEL TYPE --------

procedure cargarVector(var vec: vecVentas; var dimL: rangoVentas);
    procedure leerVenta(var ven: venta);
    begin
        write('Ingrese el dia de venta: ');
        ven.dia := random(5); //debería ser 32 pero uso 5 para probar
        writeln(ven.dia);
        if (ven.dia <> fin) then begin
            write('Ingrese el código de producto: ');
            ven.codProd := random(14) + 1;
            writeln(ven.codProd);
            write('Cantidad vendida: ');
            readln(ven.cantVendida);
        end;
    end;
var
    ven: venta;
begin
    dimL := 0;
    leerVenta(ven);
    while (ven.dia <> fin) and (dimL < dimF) do begin
        dimL := dimL + 1;
        vec[dimL] := ven;
        leerVenta(ven);
    end;
end;

procedure imprimirVector(vec: vecVentas; dimL: rangoVentas);
var
    i: rangoVentas;
begin
    for i := 1 to dimL do begin
        writeln('***Venta #', i);
        writeln('DIA: ', vec[i].dia);
        writeln('COD. PROD.: ', vec[i].codProd);
        writeln('CANT. VENDIDA: ', vec[i].cantVendida);
        writeln('..................');
    end;
end;

{--------------------------------Ordenar por Selección----------------------------------------}
procedure ordenarSeleccion(var v: vecVentas; dimL: rangoVentas); // de mayor a menor
var
    i, j, min: integer;
    item: venta;
begin
    for i := 1 to dimL - 1 do begin
        min := i;
        for j := i + 1 to dimL do
            if (v[j].codProd < v[min].codProd) then
                min := j;
        item := v[min];
        v[min] := v[i];
        v[i] := item;
    end;
end;

{--------------------------------Ordenar por Inserción----------------------------------------}
procedure ordenInsercion(var v: vectorMenorAMayor; dimL2: rangoVenta);
var
    i, j: integer;
    actual: infoVenta;
begin
    for i := 2 to dimL2 do begin
        actual := v[i];
        j := i - 1;
        while (j > 0) and (v[j].codProducto > actual.codProducto) do begin
            v[j + 1] := v[j];
            j := j - 1;
        end;
        v[j + 1] := actual;
    end;
end;

procedure eliminarProducto(var vec: vecVentas; var dimL: rangoVentas; var ok: boolean);
var
    cod1, cod2: rangoProd;
    i, j: rangoVentas;
begin
    ok := false;
    i := 1;
    writeln('=============');
    write('Ingrese cod 1: ');
    readln(cod1);
    write('Ingrese cod 2: ');
    readln(cod2);
    while (i <= dimL) do begin
        if (vec[i].codProd >= cod1) and (vec[i].codProd <= cod2) then begin
            for j := i to dimL - 1 do
                vec[j] := vec[j + 1];
            dimL := dimL - 1;
            ok := true;
        end
        else
            i := i + 1;
    end;
end;

procedure crearVector2(var vec2: vectorMenorAMayor; vec: vecVentas; dimL: rangoVentas; var dimL2: rangoVenta);
var
    i: rangoVentas;
    j: rangoVenta;
begin
    dimL2 := 0;
    for i := 1 to dimL do begin
        if (vec[i].codProd mod 2 = 0) then begin
            dimL2 := dimL2 + 1;
            vec2[dimL2].codProducto := vec[i].codProd;
            vec2[dimL2].totalVendido := vec[i].cantVendida;
        end;
    end;
end;

procedure imprimirVectorResultante2(vec2: vectorMenorAMayor; dimL2: rangoVenta);
var
    i: rangoVenta;
begin
    writeln('** VECTOR RESULTANTE DE CÓDIGOS PARES **');
    if (dimL2 = 0) then
        writeln('** El vector está vacío **')
    else begin
        for i := 1 to dimL2 do begin
            writeln('Posición ', i, ' : ');
            writeln('Código del producto: ', vec2[i].codProducto);
            writeln('Cantidad total vendida del producto: ', vec2[i].totalVendido);
            writeln('-------------------------');
        end;
    end;
end;

//---------PROGRAMA PRINCIPAL ----------
var
    vec: vecVentas;
    vec2: vectorMenorAMayor;
    dimL: rangoVentas;
    dimL2: rangoVenta;
    ok: boolean;
begin
    randomize;
    cargarVector(vec, dimL);
    imprimirVector(vec, dimL);
    ordenarSeleccion(vec, dimL);
    writeln('---Vector ordenado:');
    imprimirVector(vec, dimL);
    eliminarProducto(vec, dimL, ok);
    if (ok) then 
        writeln('Se han eliminado las ventas.')
    else
        writeln('No se han eliminado las ventas');
    writeln('**VECTOR RESULTANTE**');
    imprimirVector(vec, dimL);
    crearVector2(vec2, vec, dimL, dimL2);
    ordenInsercion(vec2, dimL2);
    imprimirVectorResultante2(vec2, dimL2);
end.