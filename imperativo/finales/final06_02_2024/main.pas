program final06_02_2024;
const
    fin = 0;
type
    cadena20=string[20];
    alumno = record
        nombre:cadena20;
        dni:integer;
        tiempo:real;
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
//--------fin del type--------
procedure cargarArbol(var a:arbol);
    procedure leerAlumno(var alu:alumno);
    begin
        with alu do begin
            dni:=random(10);
            writeln('DNI: ',dni);
            if (dni <> fin) then begin
                writeln('NOMBRE: ');
                readln(nombre);
                tiempo:=random(3600)+1;
                writeln('TIEMPO: ',tiempo:2:2);
                writeln('-------------------');
            end;
        end;
    end;
    
    procedure agregarAlArbol(var a:arbol; alu:alumno);
    begin
        if(a=nil) then begin
            new(a);
            a^.dato:=alu;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
                if(alu.tiempo <= a^.dato.tiempo) then
                    agregarAlArbol(a^.HI,alu)
                else
                    agregarAlArbol(a^.HD,alu);
    end;

var
    alu:alumno;
begin
    a:=nil;
    leerAlumno(alu);
    while(alu.dni <> fin) do begin
        agregarAlArbol(a,alu);
        leerAlumno(alu);
    end;
end;


procedure imprimirArbol(a: arbol);
begin
    if(a <> nil) then begin
        imprimirArbol(a^.HI);
        writeln('DNI: ',a^.dato.dni);
        writeln('NOMBRE: ',a^.dato.nombre);
        writeln('TIEMPO: ',a^.dato.tiempo:2:2);
        writeln('-------------------');
        imprimirArbol(a^.HD);
    end;
end;

procedure recorrerArbol(a:arbol; var l:lista; inf,sup:real);
    procedure agregarAdelante(var l:lista; dato:alumno);
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
        if(a^.dato.tiempo > inf) then
            recorrerArbol(a^.HI,l,inf,sup);
            
        if(a^.dato.tiempo >= inf) and (a^.dato.tiempo <= sup) then
            agregarAdelante(l,a^.dato);
            
        if(a^.dato.tiempo < sup) then
            recorrerArbol(a^.HD,l,inf,sup);

    end;
end;

procedure imprimirLista(l:lista);
begin
    while(l <> nil) do begin
        writeln('DNI: ',l^.dato.dni);
        writeln('NOMBRE: ',l^.dato.nombre);
        writeln('TIEMPO: ',l^.dato.tiempo:2:2);
        writeln('-------------------');
        l:=l^.sig;
    end;
end;

procedure calcularMin(a:arbol;var min:real; var nomMin:cadena20; var dniMin:integer);
begin
     if(a <> nil) then begin
        if(a^.HI = nil) then begin
            min:=a^.dato.tiempo;
            nomMin:=a^.dato.nombre;
            dniMin:=a^.dato.dni;
        end
        else
            calcularMin(a^.HI,min,nomMin,dniMin);
    end;
end;
//------programa principal------
var
    a:arbol;
    l:lista;
    min,inf,sup:real;
    nomMin:cadena20;
    dniMin:integer;
begin
    l:=nil;
    cargarArbol(a);
    nomMin:='';
    dniMin:=-1;
    writeln('--arbol cargado--');
    imprimirArbol(a);
    write('Lim. inferior: ');
    readln(inf);
    write('Lim. superior: ');
    readln(sup);
    recorrerArbol(a,l,inf,sup);
    writeln('--lista cargada--');
    imprimirLista(l);
    calcularMin(a,min,nomMin,dniMin);
    writeln('El alumno que menos tiempo tardó fue: ',nomMin, ' con DNI: ',dniMin);
end.
