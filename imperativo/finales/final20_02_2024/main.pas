program final20_02_2024;
const   
    fin = 0;
type
    cadena30= string[30];
    
    alumno = record
        nombre:cadena30;
        legajo:integer;
        autoevaluaciones:integer;
    end;
    
    arbol = ^nodoArbol;
    
    nodoArbol = record
        dato:alumno;
        HI:arbol;
        HD:arbol;
    end;

    lista= ^nodo;
    
    nodo = record
        dato:alumno;
        sig:lista;
    end;
//_________fin del type________
procedure cargarArbol(var a:arbol);
    procedure leerAlumno(var alu:alumno);
    begin
        with alu do begin
            legajo:=random(10);
            writeln('LEGAJO: ',legajo);
            if(legajo <> fin) then begin
                write('NOMBRE: ');
                readln(nombre);
                //autoevaluaciones:=0;
                autoevaluaciones:=random(5);
                writeln('CANT. AUTOEVALUACIONES: ',autoevaluaciones);
                writeln('------------------------');
            end;
        end;
    end;
    procedure agregarAlArbol(var a:arbol; dato:alumno);
    begin
        if(a = nil) then begin
            new(a);
            a^.dato:=dato;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if(dato.legajo <= a^.dato.legajo) then
                agregarAlArbol(a^.HI,dato)
            else
                agregarAlArbol(a^.HD,dato)
    end;
var
    alu:alumno;
begin
    a:=nil;
    leerAlumno(alu);
    while(alu.legajo <> fin) do begin
        agregarAlArbol(a,alu);
        leerAlumno(alu);
        
    end;
end;

procedure recorrerArbol(a:arbol; leg:integer; var ok:boolean);
begin
    if(a <>nil) then begin
        if(a^.dato.legajo = leg) then begin
            a^.dato.autoevaluaciones:=a^.dato.autoevaluaciones+1;
            ok:=true;
        end
        else 
            if(a^.dato.legajo > leg) then       
                recorrerArbol(a^.HI,leg,ok)
            else
                recorrerArbol(a^.HD,leg,ok);
    end;
end;

procedure generarLista(a:arbol; var l:lista);
    procedure insertarOrdenado(var l:lista; dato:alumno);
    var
        aux,ant,act:lista;
    begin
        new(aux);
        aux^.dato:=dato;
        act:=l;
        while(act <>nil) and (act^.dato.nombre < dato.nombre) do begin
            ant:=act;
            act:=act^.sig;
        end;
        if(act = l) then
            l:=aux
        else
            ant^.sig:= aux;
        aux^.sig:= act;
    end;
begin
     if(a <> nil) then begin
        generarLista(a^.HI,l);
        
        if(a^.dato.autoevaluaciones >=3) then 
            insertarOrdenado(l,a^.dato);
        
        generarLista(a^.HD,l);
     end;
end;
procedure imprimirlista(l:lista);
begin
    while(l <> nil) do begin
        writeln('LEGAJO: ',l^.dato.legajo);
        write('NOMBRE: ',l^.dato.nombre);
        writeln('CANT. AUTOEVALUACIONES: ',l^.dato.autoevaluaciones);
        writeln('------------------------');
        l:=l^.sig;
    end;
end;
//_________programa principal________
var
    a:arbol;
    leg:integer;
    ok:boolean;
    l:lista;
begin
    ok:=false;
    l:=nil;
    cargarArbol(a);
    write('INGRESE NRO. LEGAJO: ');
    readln(leg);
    recorrerArbol(a,leg,ok);
    if(ok ) then writeln('MODIFICADO!')
    else
        writeln('NO EXISTE ESE LEGAJO!');
    generarLista(a,l);
    writeln('---lista generada------');
    imprimirlista(l);
end.
