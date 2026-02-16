program final09_08_2022;
const
    fin = 'zzz';
type
    cadena30 = string[30];
    
    pedido = record
        nroRep:integer;
        dirRetiro:cadena30;
        dirEntrega:cadena30;
        montoACobrar:real;
    end;
    
    infoPedido =record
        nroRep:integer;
        cantPedidos:integer;
        montoTotal:real;
    end;
    
    arbol= ^nodoArbol;
    
    nodoArbol = record
        dato:infoPedido;
        HI:arbol;
        HD:arbol;
    end;
//------fin del type------
procedure cargarArbol(var a:arbol);
    procedure leerPedido(var ped:pedido);
    begin
        with ped do begin
            write('ENTREGA:');
            readln(dirEntrega);
            if (dirEntrega <> fin) then begin
                nroRep:=random(7);
                writeln('NRO. REPARTIDOR: ',nroRep);
                write('RETIRO:');
                readln(dirRetiro);
                montoACobrar:=random(5000);
                writeln('MONTO A COBRAR: $',montoACobrar:2:2);
                writeln('----------');
            end;
        end;
    end;
    
    procedure agregarAlArbol(var a:arbol; dato:pedido);
    begin
        if(a = nil) then begin
            new(a);
            a^.dato.nroRep:= dato.nroRep;
            a^.dato.cantPedidos:=1;
            a^.dato.montoTotal:=dato.montoACobrar;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if( dato.nroRep = a^.dato.nroRep) then begin
                a^.dato.cantPedidos:=a^.dato.cantPedidos+1;
                a^.dato.montoTotal:=a^.dato.montoTotal+ dato.montoACobrar;
            end
            else
                if(dato.nroRep < a^.dato.nroRep)then 
                    agregarAlArbol(a^.HI,dato)
                else
                    agregarAlArbol(a^.HD,dato);
    end;
var
    ped:pedido;
begin
    a:=nil;
    leerPedido(ped);
    while(ped.dirEntrega <> fin ) do begin
        agregarAlArbol(a,ped);
        leerPedido(ped);
    end;
end;

procedure imprimirArbol(a:arbol);
begin
    if(a <> nil) then begin
        imprimirArbol(a^.HI);
        writeln('NRO. REPARTIDOR: ', a^.dato.nroRep);
        writeln('CANT. PEDIDOS:', a^.dato.cantPedidos);
        writeln('MONTO TOTAL: $', a^.dato.montoTotal:2:2);
        writeln('-------------------');
        imprimirArbol(a^.HD);
    end;
end;
procedure calcularCantidad(a:arbol;inf,sup:integer; var cantidad:integer);
begin
    if(a <> nil) then begin
            calcularCantidad(a^.HI,inf,sup,cantidad);
            if (a^.dato.montoTotal >= inf )  and (a^.dato.montoTotal <= sup)then
                cantidad:=cantidad+1;
            calcularCantidad(a^.HD,inf,sup,cantidad);
    end;
end;
//----programa principal------
var
    a:arbol;
    inf,sup,cantidad:integer;
begin
    cantidad:=0;
    randomize;
    cargarArbol(a);
    writeln('**ARBOL CARGADO**');
    imprimirArbol(a);
    write('INFERIOR: ');
    readln(inf);
    write('SUPERIOR: ');
    readln(sup);
    calcularCantidad(a,inf,sup,cantidad);
    writeln('cantidad en el rango: ',cantidad);
end.
