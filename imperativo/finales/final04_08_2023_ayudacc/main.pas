{
}
program final04_08_2023;
const
    fin = 0;
type
    rangoCategoria = 1..6;
   
    domicilio = record
        calle:integer;
        nro:integer;
    end;
    
    rangoDia = 1..31;
    rangoMes = 1..12;
    
    regFecha = record
        dia:rangoDia;
        mes: rangoMes;
        hora:integer;
    end;
    
    denuncia = record
        categoria : rangoCategoria;
        dni:integer;
        direccion: domicilio;
        fecha: regFecha;
    end;
    
    lista = ^nodo;
    
    nodo = record
        dato: denuncia;
        sig:lista;
    end;
    
    vector = array [rangoCategoria] of lista;
    
    infoDenuncia = record
        nroCalle:integer;
        denunciasTotales:integer;
        cantidadJulio:integer;
    end;
    
    lista2 = ^nodo2;
    
    nodo2 = record
        dato: infoDenuncia;
        sig:lista2;
    end;
//----------FIN DEL TYPE--------------
procedure inicializarVector(var v:vector);
var
    i:rangoCategoria;
begin
    for i:=1 to 6 do
        v[i]:= nil;
end;
procedure cargarVector(var v:vector);
    procedure leerDenuncia(var den:denuncia);
    begin
        with den do begin
            dni:=random(10);
            writeln('DNI: ',dni);
            if(dni <> fin) then begin
                categoria := random(6)+1;
                writeln('Categoria: ',categoria);
                direccion.calle:= random(72)+1;
                direccion.nro:= random(500);
                writeln('Direccion: ',direccion.calle,' #',direccion.nro);
                fecha.dia:= random(31)+1;
                writeln('Dia: ',fecha.dia);
                fecha.mes:= random(12)+1;
                writeln('Mes: ',fecha.mes);
                fecha.hora:= random(2400);
                writeln('Hora: ',fecha.hora);
            end;
        end;
    end;
    
    procedure insertarOrdenado(var l:lista; dato:denuncia);
    var
        aux,ant,act:lista;
    begin
        new(aux);
        aux^.dato:=dato;
        act:=l;
        while(act <> nil) and (act^.dato.direccion.nro < dato.direccion.nro) do begin
            ant:=act;
            act:=act^.sig;
        end;
        if(act = l) then
            l:=aux
        else
            ant^.sig := aux; // actualizo puntero para insertar nuevo nodo
        aux^.sig := act; // inserto nuevo nodo

    end;
var
    den:denuncia;
begin
    leerDenuncia(den);
    while(den.dni <> fin) do begin
        insertarOrdenado(v[den.categoria],den);
        leerDenuncia(den);
    end;
end;

procedure listaContadora(v:vector;var l2:lista2);
    procedure agregarAdelante(var l:lista2; dato:infoDenuncia);
    var
        nue:lista2;
    begin
        new(nue);
        nue^.dato:=dato;
        nue^.sig:= l;
        l:=nue;
    end;
var
    i,actual, totalDenuncias,totalJulio:integer;
    info: infoDenuncia;
begin
    i:=1;
    while(v[i] <> nil) do begin
        actual := v[i]^.dato.direccion.nro;
        totalDenuncias:= 0;
        totalJulio:= 0;
        while(v[i] <> nil) and (actual = v[i]^.dato.direccion.nro) do begin
            totalDenuncias:=totalDenuncias + 1;
            if(v[i]^.dato.fecha.mes = 7) then
                totalJulio:= totalJulio+1;
        end;
        info.nroCalle:= v[i]^.dato.direccion.nro;
        info.denunciasTotales:=totalDenuncias;
        info.cantidadJulio:= totalJulio;
        agregarAdelante(l2,info);
    end;
end;

function calcularMaxDenuncias(l:lista2): integer;
var
    calleSig: integer;
begin
    if (l = nil) then
        calcularMaxDenuncias := -1   // caso base: lista vacía
    else begin
        // llamo recursivamente con la siguiente calle
        calleSig := calcularMaxDenuncias(l^.sig);

        // comparo el nodo actual con el resultado de la recursión
        if (calleSig = -1) or (l^.dato.denunciasTotales > l^.sig^.dato.denunciasTotales) then
            calcularMaxDenuncias := l^.dato.nroCalle
        else
            calcularMaxDenuncias := calleSig;
    end;
end;
//-----------PROGRAMA PRINCIPAL-------------
var
    v:vector;
    l2:lista2;
begin
    l2:= nil;
    randomize;
    inicializarVector(v);
    cargarVector(v);
    listaContadora(v,l2);
    writeln('Nro. de calle con mayor cantidad de denuncias totales: ',calcularMaxDenuncias(l2));
end.
