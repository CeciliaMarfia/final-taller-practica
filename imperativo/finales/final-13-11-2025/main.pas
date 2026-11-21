{}
program final13_11_2025;
const
    fin = 0;
type
    cadena20 = string[20];
    rangoComision = 1..8;
    
    alumno = record
        nombre:cadena20;
        legajo:integer;
        nroComision: rangoComision;
        autoEvAprob:integer;
    end;
    
    arbol = ^nodo;
    
    nodo = record
        dato:alumno;
        HI:arbol;
        HD:arbol;
    end;
    
    lista = ^nodoLista;
    
    nodoLista = record
        dato:alumno;
        sig:lista;
    end;
    
    vector = array [rangoComision] of lista;
//_______fin del type______
procedure crearArbol(var a:arbol);

    procedure leerAlumno(var alu:alumno);
    begin
        with alu do begin
            //legajo:=random(5);
            //writeln('Legajo: ', legajo);
            write('Legajo: ');
            readln(legajo);
            if(legajo<>fin) then begin
                nroComision:=random(7)+1;
                writeln('Comisión: ', nroComision);
                write('Nombre del alumno: ');
                readln(nombre);
                //autoEvAprob:=0; son 0 pero lo ingreso a mano para probar
                //writeln('Autoevaluaciones aprobadas: ',autoEvAprob);
                writeln('Autoevaluaciones aprobadas: ');
                readln(autoEvAprob);
            end;
        end;
    end;
    
    procedure agregarAlArbol(var a:arbol; alu:alumno);
    begin
        if (a = nil) then begin
            new(a);
            a^.dato:=alu;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if(alu.legajo <= a^.dato.legajo) then
                agregarAlArbol(a^.HI,alu)
            else
                agregarAlArbol(a^.HD,alu)
    end;
    
var
    alu:alumno;
begin
    a:=nil;
    leerAlumno(alu);
    while (alu.legajo <> fin) do begin
        agregarAlArbol(a,alu);
        leerAlumno(alu);
    end;
end;

procedure incrementarAutoev(var a:arbol;legajo:integer);
begin
    if(a <>nil) then begin
        if(legajo = a^.dato.legajo) then
            a^.dato.autoEvAprob:= a^.dato.autoEvAprob+1
        else begin
            if(legajo < a^.dato.legajo) then
                incrementarAutoev(a^.HI,legajo)
            else
                incrementarAutoev(a^.HD,legajo)
        end;
    end;
end;

procedure imprimirArbol(a:arbol);
begin
    if(a <>nil) then begin
        imprimirArbol(a^.HI);
         writeln('Legajo: ', a^.dato.legajo);
         writeln('nombre Alumno: ', a^.dato.nombre);
         writeln('Nro. comisión: ', a^.dato.nroComision);
         writeln('Autoevaluaciones Aprobadas: ', a^.dato.autoEvAprob);
         writeln('__________________________');
         imprimirArbol(a^.HD);
    end;
end;
procedure inicializarVector(var v:vector);
var
    i:rangoComision;
begin
    for i:=1 to 8 do
        v[i]:= nil;
end;


procedure recorrerArbol(a:arbol; cantAutoEv:integer;var v:vector);
    procedure agregarAlumno(var pri:lista; dato:alumno);
    var
    aux, ant, act: lista;
    begin
        new(aux);   
        aux^.dato := dato;
        act := pri; // ubico act al inicio de la lista
    while (act <> nil) AND (act^.dato.nombre < dato.nombre) do begin
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
    if(a <>nil) then begin
        recorrerArbol(a^.HI,cantAutoEv,v);
        if(a^.dato.autoEvAprob >= cantAutoEv) then
            agregarAlumno(v[a^.dato.nroComision],a^.dato);
        recorrerArbol(a^.HD,cantAutoEv,v);
    end;
end;

procedure imprimirVector(vec:vector);
var
    i:integer;
begin
    for i:=1 to 8 do begin
        while(vec[i] <>nil) do begin
            writeln('Legajo: ', vec[i]^.dato.legajo);
            writeln('nombre Alumno: ', vec[i]^.dato.nombre);
            writeln('Nro. comisión: ', vec[i]^.dato.nroComision);
            writeln('Autoevaluaciones Aprobadas: ', vec[i]^.dato.autoEvAprob);
            writeln('__________________________');
            vec[i]:= vec[i]^.sig;
        end;
    end;
end;
//________pp_________
var
    a:arbol;
    legajo,cantAutoEv:integer;
    vec:vector;
begin
    randomize;
    crearArbol(a);
    writeln('**ARBOL EN ORDEN CRECIENTE**');
    imprimirArbol(a);
    write('Ingrese nro. de legajo:');
    readln(legajo);
    incrementarAutoev(a,legajo);
    writeln('**LEGAJO INCREMENTADO**');
    imprimirArbol(a);
    writeln('********************');
    write('Cantidad de autoev. requeridas: ');
    readln(cantAutoEv);
    inicializarVector(vec);
    recorrerArbol(a,cantAutoEv,vec);
    writeln('********************');
    imprimirVector(vec);
end.
