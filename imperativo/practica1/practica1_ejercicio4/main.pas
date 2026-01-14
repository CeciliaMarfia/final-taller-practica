{4.- Una librería requiere el procesamiento de la información de sus productos. De cada
producto se conoce el código del producto, código de rubro (del 1 al 8) y precio.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de los productos y los almacene ordenados por código de producto y
agrupados por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza
cuando se lee el precio 0.
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que
puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3
es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos
métodos vistos en la teoría.
e. Muestre los precios del vector resultante del punto d).
f. Calcule el promedio de los precios del vector resultante del punto d).
}
program Hello;
const
    fin = 0;
    dimF = 8;
    dimF2 = 5; //son 30 pongo 5 para probar;
TYPE
    rangoRubro = 1..dimF;
    producto = record
        codProd:integer;
        codRubro:rangoRubro;
        precio:real;
    end;
    
    lista = ^nodo;
    
    nodo = record
        dato:producto;
        sig:lista;
    end;
    
    vector = array[rangoRubro] of lista;
    vector2 = array [1..dimF2] of producto;
//--------FIN DEL TYPE--------
procedure cargarVector(var v:vector);
    procedure inicializarVectorDeListas(var v:vector);
    var
        i:integer;
    begin
        for i:=1 to dimF do
            v[i]:=nil;
    end;
    
    procedure leerProducto(var prod:producto);
    begin
        write('Ingrese el código del producto: ');
        readln(prod.codProd);
        if(prod.codProd <> fin) then begin
            write('Ingrese el codigo del rubro: ');
            readln(prod.codRubro);
            write('Ingrese el precio: $');
            readln(prod.precio);
        end;
    end;
    
    procedure insertarOrdenado (var pri: lista; dato: producto);
    var
        aux, ant, act: lista;
    begin
        new(aux);   
        aux^.dato := dato;
        act := pri; // ubico act al inicio de la lista
        while (act <> nil) AND (act^.dato.codProd < dato.codProd) do begin
                ant := act;
                act := act^.sig; // avanzo en la lista
        end;
        if (act = pri) then // si está vacía o hay que insertar al inicio
                pri := aux
        else // el nuevo nodo va en el medio o al final de la lista
                ant^.sig := aux; // actualizo puntero para insertar nuevo nodo
        aux^.sig := act; // inserto nuevo nodo
    end;

var
    prod:producto;
begin
    leerProducto(prod);
    while(prod.codProd <> fin) do begin
        insertarOrdenado(v[prod.codRubro],prod);
        leerProducto(prod);
    end;
end;

    procedure mostrarProductos(v:vector);
    var
        i:integer;
    begin
        for i:=1 to dimF do begin
            writeln('****RUBRO ',i,' **** ');
            while(v[i] <> nil) do begin
                writeln('CODIGO DE PRODUCTO: ',v[i]^.dato.codProd);
                writeln('PRECIO: $ ',v[i]^.dato.precio:4:2);
                writeln('---------------------');
                v[i] := v[i]^.sig;
            end;
        end;
    end;
    
    procedure crearVector2 (v:vector;var v2:vector2; var dimL:integer);
    begin
        while(v[3] <> nil) do begin
            if(dimL < dimF2) then begin
                dimL:= dimL+1;
                v2[dimL]:=v[3]^.dato;
            end;
            v[3] := v[3]^.sig;
        end;
    end;
    
    procedure ordenarSeleccion (var v: vector2; dimL: integer);
    var
        i, j, min: integer; {uso min en lugar de "p" xq es mas explicativo}
        item: producto;
    begin
        for i := 1 to dimL-1 do begin
            min := i; { necesito guardar la pos minima actual porque es el inicio }
            for j := i+1 to dimL do{para buscar el elemento mínimo en cada pasada}
                if (v[j].precio < v[min].precio) then {verifico si hay actualizar el min}
                      min := j;
            { intercambia v[i] con v[min], incluso si no es necesario }
            item := v[min];{guardo el elemento mínimo en una variable auxiliar}
            v[min] := v[i];{en la posición actual guardo el mínimo}
            v[i] := item;
        end;
    end;

    procedure imprimirPrecios(v:vector2; dimL:integer);
    var
        i:integer;
    begin
        for i:=1 to dimL do
            writeln('$ ',v[i].precio:2:2);
    end;
    
    function calcularPromedio(v:vector2; dimL:integer):real;
    var
        i:integer;
        total:real;
    begin
        for i:=1 to dimL do
            total:=total + v[i].precio;
        calcularPromedio:= total/dimL;
    end;
    
//--------PROGRAMA PRINCIPAL--------
var
    v:vector;
    v2:vector2;
    dimL:integer;
begin
    cargarVector(v);
    mostrarProductos(v);
    crearVector2(v,v2,dimL);
    ordenarSeleccion (v2, dimL);
    imprimirPrecios(v2,dimL);
    writeln('PROMEDIO DE PRECIOS: ',calcularPromedio(v2,dimL):2:2);
end.
