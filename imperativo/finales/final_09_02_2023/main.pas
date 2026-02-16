{

}
program Hello;
const
    fin = 0;
type

    cadena10 = string[10];

    alumno = record
        nombre:cadena10;
        dni:integer;
        puntajeFoto:real;
    end;
    
    arbol = ^nodoArbol;
    
    nodoArbol = record
        dato:alumno;
        HI:arbol;
        HD:arbol;
    end;
    
    lista = ^nodo;
    
    nodo= record
        dato:alumno;
        sig:lista;
    end;
//-----------fin del type------
procedure cargarArbol(var a:arbol);
    procedure leerAlumno(var alu:alumno);
    begin
        with alu do begin
            dni:= random(10);
            writeln('DNI: ',dni);
            if(dni <> fin) then begin
                write('NOMBRE: ');
                readln(nombre);
                puntajeFoto:=random(100);
                writeln('Puntaje obtenido: ',puntajeFoto:2:2);
                writeln('--------------------');
            end;
        end;
    end;
    procedure agregarAlArbol(var a:arbol; dato:alumno);
    begin
        if(a = nil) then begin
            new(a);
            a^.dato:= dato;
            a^.HI:= nil;
            a^.HD:= nil;
        end
        else
            if(dato.puntajeFoto < a^.dato.puntajeFoto) then
                agregarAlArbol(a^.HI,dato)
            else
                agregarAlArbol(a^.HD,dato)
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

procedure entreRango(a:arbol; num1,num2:real; var l:lista);

    procedure agregarAdelante(var l:lista; alu:alumno);
    var
        nue:lista;
    begin
        new(nue);
        nue^.dato:= alu;
        nue^.sig:= l;
        l:=nue;
    end;

begin //aca pide eficiencia, como el arbol ya está ordenado el árbol ya está ordenado por puntaje, la forma más eficiente es recorrerlo en orden
    if(a <> nil) then begin //empiezo el recorrido
    
        if (a^.dato.puntajeFoto > num1) then// voy a la izquierda solo si puede haber valores >= num1 
            entreRango(a^.HI, num1,num2,l);
            
             { proceso el nodo actual }
        if( (a^.dato.puntajeFoto >= num1) and (a^.dato.puntajeFoto <= num2) ) then
            agregarAdelante(l,a^.dato);
            
          { voy a la derecha solo si puede haber valores <= num2 }
        if(a^.dato.puntajeFoto < num2) then
            entreRango(a^.HD,num1,num2,l);
    end;
end;
procedure calcularDNIChico(a:arbol;var min:integer);
begin
    if(a <> nil) then begin
        if(a^.dato.dni < min) then
            min:= a^.dato.dni;

        calcularDNIChico(a^.HI,min);
        calcularDNIChico(a^.HD,min);
    end;
end;

//------programa principal------
var
    a:arbol;
    num1,num2:real;
    l:lista;
    min:integer;
begin
    l:=nil;
    min:=999;
    randomize;
    cargarArbol(a);
    write('LIMITE INFERIOR: ');
    readln(num1);
    write('LIMITE SUPERIOR: ');
    readln(num2);
    entreRango(a,num1,num2,l);
    calcularDNIChico(a,min);
    write('alumno con DNI más chico: ',min); 
end.
