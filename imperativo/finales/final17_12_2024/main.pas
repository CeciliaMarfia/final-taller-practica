program final17_12_2024;
const
    fin = 'zzz';
type
    cadena20 = string[20];
    
    vehiculo = record
        patente:cadena20;
        marca:cadena20;
        anioFab:integer;
        color:cadena20;
        dni:integer;
    end;
    
    arbol = ^nodoArbol;
    
    nodoArbol = record
        dato:vehiculo;
        HI:arbol;
        HD:arbol;
    end;
    
     lista = ^nodo;
    
    nodo = record
        dato:vehiculo;
        sig:lista;
    end;
//_________fin del type________
procedure cargarArbol(var a:arbol);
    procedure leerVehiculo(var veh:vehiculo);
    begin
        with veh do begin
            write('PATENTE: ');
            readln(patente);
            if(patente <> fin) then begin
                write('MARCA: ');
                readln(marca);
                anioFab:=random(26)+2000;
                writeln('AÑO FABRICACION :',anioFab);
                write('COLOR: ');
                readln(color);
                dni:=random(1000);
                writeln('DNI :',dni);
                writeln('----------------');
            end;
        end;
    end;
    
    procedure agregarAlArbol(var a:arbol; dato:vehiculo);
    begin
        if(a = nil) then begin
            new(a);
            a^.dato:=dato;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if(dato.dni<= a^.dato.dni) then
                agregarAlArbol(a^.HI,dato)
            else
                agregarAlArbol(a^.HD,dato);
    end;
var
    veh:vehiculo;
begin
    a:=nil;
    leerVehiculo(veh);
    while(veh.patente <> fin) do begin
        agregarAlArbol(a,veh);
         leerVehiculo(veh);
    end;
end;

procedure imprimirArbol(a:arbol);
begin
     if(a <> nil) then begin
        imprimirArbol(a^.HI);
        writeln('PATENTE: ',a^.dato.patente);
        writeln('MARCA: ',a^.dato.marca);
        writeln('AÑO FABRICACION :',a^.dato.anioFab);
        writeln('COLOR: ',a^.dato.color);
        writeln('DNI :',a^.dato.dni);
        writeln('----------------');
        imprimirArbol(a^.HD);
    end;
end;

procedure entreValores(a:arbol;inf,sup:integer; var contador:integer);//como no es el criterio de orden NO HAY PODA
begin
    if(a <> nil) then begin
        
        entreValores(a^.HI,inf,sup,contador);
        
        if (a^.dato.anioFab >= inf) and (a^.dato.anioFab <= sup) then
            contador:=contador+1;
            
        entreValores(a^.HD,inf,sup,contador);
        
    end;
end;

procedure  generarLista(a:arbol;var l,ult:lista; dni:integer);
    procedure agregarAtras(var l,ult:lista; dato:vehiculo);
    var
        aux:lista;
    begin
        new(aux);
        aux^.dato:=dato;
        aux^.sig:=nil;
        if(l=nil) then
            l:=aux
        else
            ult^.sig:=aux;
        ult:=aux;
    end;

begin
    if(a <> nil) then begin
        if(a^.dato.dni < dni) then begin
            generarLista(a^.HI,l,ult,dni);
            agregarAtras(l,ult,a^.dato);
            generarLista(a^.HD,l,ult,dni);
        end
        else
            generarLista(a^.HI,l,ult,dni);
    end;
end;

procedure imprimirLista(l:lista);
begin
    while (l <> nil) do begin
        writeln('PATENTE: ',l^.dato.patente);
        writeln('MARCA: ',l^.dato.marca);
        writeln('AÑO FABRICACION :',l^.dato.anioFab);
        writeln('COLOR: ',l^.dato.color);
        writeln('DNI :',l^.dato.dni);
        writeln('----------------');
        l:=l^.sig;
    end;
end;
//___________programa principal_______
var
    a:arbol;
    inf,sup,contador,dni:integer;
    l,ult:lista;
begin
    l:=nil;
    ult:=nil;
    randomize;
    contador:=0;
    cargarArbol(a);
    writeln('---ARBOL CARGADO--');
    imprimirArbol(a);
    write('LIM. INF:');
    readln(inf);
    write('LIM. SUP:');
    readln(sup);
    entreValores(a,inf,sup,contador);
    writeln('TOTAL PARA ESE RANGO: ', contador);
    write('INGRESE DNI:');
    readln(dni);
    generarLista(a,l,ult,dni);
    writeln('---LISTA CARGADA--');
    imprimirLista(l);
end.
