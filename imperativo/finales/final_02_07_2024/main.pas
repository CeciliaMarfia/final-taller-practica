
program final_02_07_2024;

type
    rangoImportancia = 1..5;
    rangoSector = 1..50;
    
    llamada = record
        nivelImportancia:rangoImportancia;
        sectorEmpresa:rangoSector;
        nroEmpleadosAfectados:integer;
    end;
    
    lista = ^nodo;
    
    nodo = record
        dato:llamada;
        sig:lista;
    end;
    
    vectorLlamados = array [rangoImportancia] of lista;
    
    arbol = ^nodoArbol;
    
    nodoArbol = record
        dato:llamada;
        HI:arbol;
        HD:arbol;
    end;
//_________fin del type_____________
procedure inicializarVector(var v:vectorLlamados);
var
    i:rangoImportancia;
begin
    for i:=1 to 5 do
        v[i]:=nil;
end;

procedure recibirLlamada(var v:vectorLlamados);
    procedure leerLlamado(var tel:llamada);
    begin
        with tel do begin
            nivelImportancia:= random (5)+1;
            writeln('Nivel de importancia: ', nivelImportancia);
            sectorEmpresa:= random (50)+1;
            writeln('Sector de la empresa afectado: ',sectorEmpresa);
            nroEmpleadosAfectados:= random(200);
            writeln('Nro. de empleados afectado: ',nroEmpleadosAfectados);
            writeln('------------------------------');
        end;
    end;
    
    procedure insertarOrdenado(var l:lista; dato:llamada);
    var
       aux,ant,act:lista;
    begin
        new(aux);
        aux^.dato:= dato;
        act:=l; //ubico al actual al inicio de la lista
        while(act <> nil) and (act^.dato.sectorEmpresa < dato.sectorEmpresa) do begin
            ant:=act;
            act:=act^.sig;// avanzo en la lista
        end;
        if(act = l) then  // si está vacía o hay que insertar al inicio
            l :=aux
        else // el nuevo nodo va en el medio o al final de la lista
            ant^.sig := aux; // actualizo puntero para insertar nuevo nodo
        aux^.sig := act; // inserto nuevo nodo
    end;


var
    tel:llamada;
    i:integer;
begin
    for i:=1 to 100 do begin
        leerLlamado(tel);
        insertarOrdenado(v[tel.nivelImportancia], tel);
    end;
end;

procedure imprimirVector(v:vectorLlamados);
var
    i:rangoImportancia;
begin
    for i:=1 to 5 do begin
         writeln('Nivel de importancia: ', i);
        if(v[i] = nil) then
            writeln('- VACIO -')
        else
        while(v[i] <> nil) do begin
            writeln('Sector de la empresa afectado: ',v[i]^.dato.sectorEmpresa);
             writeln('Nro. de empleados afectado: ',v[i]^.dato.nroEmpleadosAfectados);
            writeln('------------------------------');
            v[i]:=v[i]^.sig;
        end;
    end;
end;
procedure insertarAlArbol(var a:arbol; dato: llamada );
begin
    if(a = nil) then begin
        new(a);
        a^.dato:= dato;
        a^.HI:=nil;
        a^.HD:=nil;
    end
    else
        if(dato.nroEmpleadosAfectados < a^.dato.nroEmpleadosAfectados) then 
            insertarAlArbol(a^.HI,dato)
        else
            insertarAlArbol(a^.HD,dato)
end;

procedure cargarArbol(var a:arbol; v:vectorLlamados; n:rangoImportancia);
var
    aux:lista;
begin
    a:=nil;
    aux := v[n];       // tomo SOLO la lista del nivel n porque el enunciado me pide que reciba la estructura y el nro ingresado
    while (aux <> nil) do begin
        insertarAlArbol(a, aux^.dato);  // inserto la llamada en el árbol
        aux := aux^.sig;              // avanzo en la lista
    end;
end;
procedure imprimirArbol(a:arbol);
begin
    if (a <> nil) then begin
        imprimirArbol(a^.HI);
        writeln('Nivel de importancia: ', a^.dato.nivelImportancia);
        writeln('Sector de la empresa afectado: ',a^.dato.sectorEmpresa);
        writeln('Nro. de empleados afectado: ',a^.dato.nroEmpleadosAfectados);
        writeln('------------------------------');
        imprimirArbol(a^.HD);
    END;
end;

function calcularMaximo(a:arbol):integer;
begin
    if (a^.HD = nil) then //si ya llegué a la hoja derecha más grande
        calcularMaximo := a^.dato.sectorEmpresa
    else
        calcularMaximo:= calcularMaximo(a^.HD);
end;
//________programa principal______________
var
    v:vectorLlamados;
    n:rangoImportancia;
    a:arbol;
begin
    randomize;
    inicializarVector(v);
    recibirLlamada(v);  
    writeln('** VECTOR CARGADO **');
    imprimirVector(v);
    write('Ingrese un nivel de importancia: ');
    readln(n);
    cargarArbol(a,v,n);
    writeln('******* ARBOL CARGADO *******');
    imprimirArbol(a);
    writeln('SECTOR CON MAYOR CANTIDAD DE EMPLEADOS AFECTADOS: ',calcularMaximo(a));
end.
