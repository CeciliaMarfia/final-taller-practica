{
}
program final22_08_25;
const
    fin = 0;
type
    cadena30 = string[30];
    
    encomienda = record
        dniEmisor:integer;
        dniReceptor:integer;
        ciudadDestino:cadena30;
        peso:real;
    end;
    
    infoCiudad = record
         ciudadDestino:cadena30;
         sumaPeso:real;
         totalEncomiendas:integer;
    end;
    
    arbol = ^nodoArbol;
    
    nodoArbol = record
        dato: infoCiudad;
        HI:arbol;
        HD:arbol;
    end;
    
    lista = ^nodo;
    
    nodo = record
        dato:infoCiudad;
        sig:lista;
    end;
//__________fin del type_______________
procedure cargarArbol(var a:arbol);
    procedure leerEncomienda(var enc:encomienda);
    begin
        with enc do begin
            peso:= random(10);
            writeln('Peso: ',peso:2:2);
            if (peso <> fin) then begin
               dniReceptor := random(100);
                writeln('DNI receptor: ',dniReceptor);
                dniEmisor:= random(100);
                writeln('DNI emisor: ',dniEmisor);
                write('Ciudad destino: ');
                readln(ciudadDestino);
                writeln('-------------------');
            end;
        end;
    end;
    
    procedure cargarInfo(enc:encomienda; var info:infoCiudad);
    begin
        info.ciudadDestino:= enc.ciudadDestino;
        info.sumaPeso:= info.sumaPeso + enc.peso;
        info.totalEncomiendas:=info.totalEncomiendas + 1;
    end;
    
    procedure agregarAlArbol(var a:arbol; enc:encomienda);
    begin
        if(a=nil) then begin
            new(a);
            a^.dato.ciudadDestino:= enc.ciudadDestino;
            a^.dato.sumaPeso:=  enc.peso;
            a^.dato.totalEncomiendas:= 1;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if(enc.ciudadDestino = a^.dato.ciudadDestino) then begin
                a^.dato.sumaPeso:=  a^.dato.sumaPeso + enc.peso;
                a^.dato.totalEncomiendas:=a^.dato.totalEncomiendas + 1;
            end
            else 
                if(enc.ciudadDestino < a^.dato.ciudadDestino) then
                    agregarAlArbol(a^.HI,enc)
                else
                    agregarAlArbol(a^.HD,enc);
    end;
var
    enc:encomienda;
begin
    a:=nil;
    leerEncomienda(enc);
    while(enc.peso <> fin) do begin
        agregarAlArbol(a,enc);
        leerEncomienda(enc);
    end;
end;

procedure imprimirArbol(a:arbol);
begin
    if(a <> nil) then begin
        imprimirArbol (a^.HI);
        writeln('CIUDAD: ',a^.dato.ciudadDestino);
        writeln('Suma peso: ',a^.dato.sumaPeso:2:2);
        writeln('Total encomiendas: ',a^.dato.totalEncomiendas);
        writeln('---------------------');
        imprimirArbol (a^.HD);
    end;
end;

procedure generarLista(a:Arbol; num:integer;var l:lista);

    procedure insertarOrdenado (var pri: lista; dato: infoCiudad);
    var
         aux,ant,act: lista;
    begin
        new(aux);   
    aux^.dato := dato;
    act := pri; // ubico act al inicio de la lista
    while (act <> nil) AND (act^.dato.sumaPeso < dato.sumaPeso)  do begin
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
    if (a <> nil) then begin
        generarLista(a^.HI,num,l);
        if(a^.dato.totalEncomiendas > num) then
            insertarOrdenado(l,a^.dato);
        generarLista(a^.HD,num,l);
    end;
end;

procedure imprimirLista(l:lista);
begin
    while(l <> nil) do begin
        writeln('CIUDAD: ',l^.dato.ciudadDestino);
        writeln('Suma peso: ',l^.dato.sumaPeso:2:2);
        writeln('Total encomiendas: ',l^.dato.totalEncomiendas);
        writeln('---------------------');
        l:=l^.sig;
    end;
end;

procedure buscarCiudad(a:arbol; nombre:cadena30; var ciu:infoCiudad);
begin
    if(a <> nil) then
        if(nombre = a^.dato.ciudadDestino) then
            ciu := a^.dato
        else if(nombre < a^.dato.ciudadDestino) then
            buscarCiudad(a^.HI,nombre,ciu)
        else
            buscarCiudad(a^.HD,nombre,ciu);
end;

{function buscarCiudadF(a:arbol; nombre:cadena30): infoCiudad;
begin
    if(a <> nil) then
        if(nombre = a^.dato.ciudadDestino) then
            buscarCiudad := a^.dato
        else if(nombre < a^.dato.ciudadDestino) then
            buscarCiudad := buscarCiudad(a^.HI,nombre)
        else
            buscarCiudad := buscarCiudad(a^.HD,nombre);
end;
}

procedure imprimirNodo(ciu:infoCiudad);
begin
        writeln('CIUDAD: ',ciu.ciudadDestino);
        writeln('Suma peso: ',ciu.sumaPeso:2:2);
        writeln('Total encomiendas: ',ciu.totalEncomiendas);
end;
//___________programa principal______________
var 
    a:arbol;
    l:lista;
    num:integer;
    ciu:infoCiudad;
    nombre:cadena30;
begin
    l:=nil;
    randomize;
    cargarArbol(a);
    imprimirArbol(a);
    write('Ingrese un valor: ');
    readln(num);
    generarLista(a,num,l);
    imprimirLista(l);
    write('Ingrese un nombre: ');
    readln(nombre);
    buscarCiudad(a, nombre,ciu);
    imprimirNodo(ciu);
end.