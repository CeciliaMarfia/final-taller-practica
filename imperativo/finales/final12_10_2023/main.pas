program final12_10_2023;
const
    fin = 'zzz';
type
    cadena20 = string [20];
    
    recital = record
        nombreBanda:cadena20;
        fechaRecital:cadena20;
        cantCancionesTocadas:integer;
        montoRecaudado:real;
    end;
    arbol = ^nodoArbol;
    
    nodoArbol = record
        dato:recital;
        HI:arbol;
        HD:arbol;
    end;
    
    lista = ^nodo;
    
    nodo= record
        dato:recital;
        sig:lista;
    end;
//_______fin del type_______
procedure cargarArbol(var a:arbol);
    procedure leerRecital(var rec:recital);
    begin
        with rec do begin
            write('NOMBRE BANDA: ');
            readln(nombreBanda);
            if(nombreBanda <> fin) then begin
                write('FECHA: ');
                readln(fechaRecital);
                cantCancionesTocadas:=random(20)+1;
                writeln('CANT. CANCIONES: ', cantCancionesTocadas);
                montoRecaudado:=random(20)+1;
                writeln('MONTO RECAUDADO: $', montoRecaudado:2:2);
                writeln('-------------');
            end;
        end;
    end;
    
    procedure agregarAlArbol(var a:arbol; dato:recital);
    begin
        if(a = nil) then begin
            new(a);
            a^.dato:=dato;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if(dato.montoRecaudado <= a^.dato.montoRecaudado) then
                agregarAlArbol(a^.HI,dato)
            else
                agregarAlArbol(a^.HD,dato);
        
    end;
var
    rec:recital;
begin
    a:=nil;
    leerRecital(rec);
    while(rec.nombreBanda <> fin) do begin
        agregarAlArbol(a,rec);
        leerRecital(rec);
    end;
end;

procedure imprimirArbol(a:arbol);
begin
     if(a <> nil) then begin
        imprimirArbol(a^.HI);
        writeln('MONTO RECAUDADO: $', a^.dato.montoRecaudado:2:2);
        writeln('NOMBRE BANDA: ',a^.dato.nombreBanda);
        writeln('FECHA: ',a^.dato.fechaRecital);
        writeln('CANT. CANCIONES: ', a^.dato.cantCancionesTocadas);
        writeln('-------------');
        imprimirArbol(a^.HD);
     end;
end;

procedure cargarlista(a:Arbol; var l:lista;inf,sup:integer);
    procedure agregarAdelante(var l:lista;dato:recital);
    var
        aux:lista;
    begin
        new(aux);
        aux^.dato:=dato;
        aux^.sig:=l;
        l:=aux;
    end;
    
begin
    if(a <> nil) then begin
        if(a^.dato.montoRecaudado > inf ) then
            cargarLista(a^.HI,l,inf,sup);
        if (a^.dato.montoRecaudado >= inf )  and (a^.dato.montoRecaudado <= sup)then
            agregarAdelante(l,a^.dato);
        if(a^.dato.montoRecaudado < sup) then 
            cargarLista(a^.HD,l,inf,sup);
    end;
end;

procedure imprimirlista(l:lista);
begin
     while(l <> nil) do begin
        writeln('MONTO RECAUDADO: $',l^.dato.montoRecaudado:2:2);
        writeln('NOMBRE BANDA: ',l^.dato.nombreBanda);
        writeln('FECHA: ',l^.dato.fechaRecital);
        writeln('CANT. CANCIONES: ', l^.dato.cantCancionesTocadas);
        writeln('-------------');
        l:=l^.sig;
     end;
end;

function masDeDoce(l:lista):integer;
begin
    if(l=nil) then
        masDeDoce:=0
    else
        if(l^.dato.cantCancionesTocadas >12) then
            masDeDoce:=masDeDoce(l^.sig)+1
        else
            masDeDoce:=masDeDoce(l^.sig);
end;
//--------programa principal------
var
    a:arbol;
    l:lista;
    inf,sup:integer;
begin
    l:=nil;
    randomize;
    cargarArbol(a);
    writeln(':::ARBOL CARGADO:::');
    imprimirArbol(a);
    write('INFERIOR: ');
    readln(inf);
    write('SUPERIOR: ');
    readln(sup);
    cargarLista(a,l,inf,sup);
    writeln(':::LISTA CARGADA:::');
    imprimirLista(l);
    writeln('cant. tocaron más de 12 canciones:', masDeDoce(l));
end.
