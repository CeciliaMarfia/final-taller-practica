program final01_04_2025;
const
    fin = 'ZZZ';
type
    cadena10 = string[10];
    
    vehiculo = record
        patente:cadena10;
        marca:cadena10;
        anioFab:integer;
        valorFiscal:integer;
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
//__________fin del type__________

procedure cargarArbol(var a:arbol);
    procedure leerVehiculo(var veh:vehiculo);
    begin
        with veh do begin
            write('PATENTE: ');
            readln(patente);
            if(patente <> fin) then begin
                anioFab:=random(6)+2000;
                writeln('AÑO FABRICACION: ',anioFab);
                write('MARCA: ');
                readln(marca);
                valorFiscal:=random(50)+1;
                writeln('VALOR FISCAL: $',valorFiscal);
                dni:=random(10)+1;
                writeln('DNI: ',dni);
                writeln('-------------------------');
            end;
        end;
    end;
    
    procedure agregarAlArbol(var a:arbol; veh:vehiculo);
    begin
        if(a = nil) then begin
            new(a);
            a^.dato:=veh;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if(veh.valorFiscal <= a^.dato.valorFiscal) then
                agregarAlArbol(a^.HI,veh)
            else
                agregarAlArbol(a^.HD,veh);
        
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
    if(a <>nil) then begin
        imprimirArbol(a^.HI);
        writeln('VALOR FISCAL: $',a^.dato.valorFiscal);
        writeln('PATENTE: ',a^.dato.patente);
        writeln('AÑO FABRICACION: ',a^.dato.anioFab);
        writeln('MARCA: ',a^.dato.marca);
        writeln('DNI: ',a^.dato.dni);
        writeln('-------------------------');
        imprimirArbol(a^.HD);
    end;
end;

procedure entreValores(a:arbol; num1,num2:integer; var total:integer);
begin
    if(a <> nil) then begin
        
        if (a^.dato.valorFiscal >= num1) then
            entreValores(a^.HI,num1,num2,total);

        if (a^.dato.valorFiscal >= num1) and (a^.dato.valorFiscal <= num2) then
            total:= total + 1;

        if (a^.dato.valorFiscal <= num2) then
            entreValores(a^.HD,num1,num2,total);
    end;
end;
procedure recorrerArbol(a:arbol; var l:lista;anio:integer);
    procedure insertarOrdenado (var pri: lista; dato: vehiculo);
    var
        aux, ant, act: lista;
    begin
        new(aux);   
        aux^.dato := dato;
        act := pri; // ubico act al inicio de la lista
        while (act <> nil) AND (act^.dato.dni < dato.dni) do begin
                ant := act;
                act := act^.sig; // avanzo en la lista
        end;
        if (act = pri) then // si está vacía o hay que insertar al inicio
                pri := aux
        else // el nuevo nodo va en el medio o al final de la lista
                ant^.sig := aux; // actualizo puntero para insertar nuevo nodo
        aux^.sig := act; // inserto nuevo nodo
    end;

begin
    if(a <> nil) then begin
        recorrerArbol(a^.HI,l,anio);
        
        if (a^.dato.anioFab < anio) then
            insertarOrdenado(l,a^.dato);
        
        recorrerArbol(a^.HD,l,anio);
    end;
end;

procedure imprimirLista(l:lista);
begin
    while(l <> nil) do begin
        writeln('VALOR FISCAL: $',l^.dato.valorFiscal);
        writeln('PATENTE: ',l^.dato.patente);
        writeln('AÑO FABRICACION: ',l^.dato.anioFab);
        writeln('MARCA: ',l^.dato.marca);
        writeln('DNI: ',l^.dato.dni);
        writeln('-------------------------');
        l:= l^.sig;
    end;
end;
//_________programa principal_______
var
    a:arbol;
    num1,num2,total,anio:integer;
    l:lista;
begin
    l:=nil;
    total:=0;
    randomize;
    cargarArbol(a);
    writeln('-----------ARBOL CARGADO--------------');
    imprimirArbol(a);
    writeln('Ingrese el valor inf: ');
    readln(num1);
    writeln('Ingrese el valor sup: ');
    readln(num2);
    entreValores(a,num1,num2,total);
    writeln('Cantidad de vehiculo entre valores recibidos: ', total);
    writeln('Ingrese el año de fabricación: ');
    readln(anio);
    recorrerArbol(a,l,anio);
    writeln('-----------LISTA--------------');
    imprimirLista(l);
end.
