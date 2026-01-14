{2.- Implementar un programa que procese información de propiedades que están a la venta
en una inmobiliaria.
Se pide:
a) Implementar un módulo para almacenar en una estructura adecuada, las propiedades
agrupadas por zona. Las propiedades de una misma zona deben quedar almacenadas
ordenadas por tipo de propiedad. Para cada propiedad debe almacenarse el código, el tipo de
propiedad y el precio total. De cada propiedad se lee: zona (1 a 5), código de propiedad, tipo
de propiedad, cantidad de metros cuadrados y precio del metro cuadrado. La lectura finaliza
cuando se ingresa el precio del metro cuadrado -1.
b) Implementar un módulo que reciba la estructura generada en a), un número de zona y un tipo de
propiedad y retorne los códigos de las propiedades de la zona recibida y del tipo recibido.
}
program Hello;
const
    fin = -1;
    dimF = 5;
type
    rangoZona = 1..5;
    cadena20 = string[20];
    infoPropiedad = record //esto es lo que debo almacenar
        cod: integer;
        tipo: cadena20;
        precio: real;
    end;
    
    propiedad = record
        zona: rangoZona;
        cod: integer;
        tipo: cadena20;
        cantMetros: real;
        precioXMetro: real;
    end;
    
    lista = ^nodo;
    nodo = record
        dato: infoPropiedad;
        sig: lista;
    end;
    
    infoARetornar = record
        cod:integer;
        tipo:cadena20;
    end;
    
    lista2 = ^nodo2;
    nodo2 = record
        dato: infoARetornar;
        sig: lista2;
    end;
    
    
    vecProp = array [rangoZona] of lista;
//---------FIN DEL TYPE----------
procedure crearVectorListas(var v: vecProp);
    procedure inicializarVectorListas(var v: vecProp);
    var
        i: rangoZona;
    begin
        for i := 1 to dimF do
            v[i] := nil;
    end;

    procedure cargarLista(var v: vecProp);
        procedure leerPropiedad(var prop: propiedad);
        begin
            with prop do begin
                write('Precio por metro cuadrado: ');
                readln(precioXMetro);
                if (precioXMetro <> fin) then begin
                    write('Zona: ');
                    readln(zona);
                    write('Codigo: ');
                    readln(cod);
                    write('Tipo: ');
                    readln(tipo);
                    write('Cantidad de metros: ');
                    readln(cantMetros);
                end;
            end;
        end;
        
        procedure cargarInfo(var info: infoPropiedad; prop: propiedad);
        begin
            info.cod := prop.cod;
            info.tipo := prop.tipo;
            info.precio := (prop.precioXMetro * prop.cantMetros);
        end;

        procedure insertarOrdenado(var pri: lista; dato: infoPropiedad);
        var
            aux, ant, act: lista;
        begin
            new(aux);   
            aux^.dato := dato;
            act := pri; // ubico act al inicio de la lista
            while (act <> nil) AND (act^.dato.tipo < dato.tipo) do begin
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
        prop: propiedad;
        info: infoPropiedad;
    begin
        leerPropiedad(prop);
        while (prop.precioXMetro <> fin) do begin
            cargarInfo(info, prop);
            insertarOrdenado(v[prop.zona], info);// aca le estoy indicando que ordene ordenado y en qué lista, cada lista corresponde a una zona
            leerPropiedad(prop);
        end;
    end;

begin
    inicializarVectorListas(v);
    cargarLista(v);
end;

procedure agregarAdelante(var l2: lista2; ret: infoARetornar);
var
    aux: lista2;
begin
    new(aux);
    aux^.dato := ret;
    aux^.sig := l2;
    l2 := aux;
end;

procedure recorrer(v:vecProp; numZona:rangoZona; tipoProp:cadena20; var l2:lista2);
var
    ret:infoARetornar; aux:lista;
begin
    l2:=nil;
    aux:= v[numZona];
    while (aux <> nil) do begin    //no tiene sentido hacer un for buscando la zona si ya me la dan
        if (aux^.dato.tipo = tipoProp) then begin
            ret.cod:=aux^.dato.cod;
            ret.tipo:=aux^.dato.tipo;
            agregarAdelante(l2,ret);
        end;
        aux:=aux^.sig;
    end;
end;
procedure informar (l2:lista2);
begin
    writeln('# códigos de las propiedades de la zona recibida y del tipo recibido:');
    while(l2 <> nil) do begin
        write('* CODIGO: ');
        writeln(l2^.dato.cod);
        write('* TIPO: ');
        writeln(l2^.dato.tipo);
        l2:=l2^.sig;
    end;
end;
//-------PROGRAMA PRINCIPAL----------
var
    v: vecProp;
    l2:lista2;
    numZona:rangoZona;
    tipoProp:cadena20;
begin
    crearVectorListas(v);
    write('Ingrese la zona a buscar (1 a 5): ');
    readln(numZona);
    write('Ingrese el tipo de propiedad a buscar: ');
    readln(tipoProp);
    recorrer(v,numZona,tipoProp,l2);
    informar(l2);
end.