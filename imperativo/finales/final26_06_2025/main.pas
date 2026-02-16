program final27_06_2025;
const
    fin = 0;
type
    paquete = record
        codEnvio:integer;
        dniEmisor:integer;
        dniReceptor:integer;
        cantObjetos:integer;
        peso:real;
        
    end;
    
    infoPaquete = record
         dniEmisor:integer;
         sumaPeso:real;
         totalEnviados:integer;
    end;
    
    arbol = ^nodoArbol;
    
    nodoArbol = record
        dato:infoPaquete;
        HI:arbol;
        HD:arbol;
    end;
    
    lista = ^nodo;
    
    nodo = record
        dato:infoPaquete;
        sig:lista;
    end;
//-------fin del type------
procedure cargarArbol(var a:arbol);
    procedure leerPaquete(var paq:paquete);
    begin
        with paq do begin
            codEnvio:=random(10);
            writeln('CODIGO DE ENVIO: ',codEnvio);
            if(codEnvio <> fin) then begin
                dniEmisor:=random(10);
                writeln('DNI EMISOR: ',dniEmisor);
                dniReceptor:=random(1000);
                writeln('DNI RECEPTOR: ',dniReceptor);
                cantObjetos:=random(50)+1;
                writeln('CANT. OBJETOS: ',cantObjetos);
                peso:=random(5000)+1;
                writeln('PESO: ',peso:2:2);
                writeln('-------------------');
            end;
        end;
    end;

    procedure agregarAlArbol(var a:arbol; paq:paquete);
    begin
        if(a=nil) then begin
            new(a);
            a^.dato.dniEmisor:=paq.dniEmisor;
            a^.dato.sumaPeso:= paq.peso;
            a^.dato.totalEnviados:= 1;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if(paq.dniEmisor = a^.dato.dniEmisor) then begin
                 a^.dato.sumaPeso:= a^.dato.sumaPeso + paq.peso;
                 a^.dato.totalEnviados:= a^.dato.totalEnviados+1;
            end
            else
                if(paq.dniEmisor < a^.dato.dniEmisor) then
                    agregarAlArbol(a^.HI,paq)
                else
                    agregarAlArbol(a^.HD,paq);
    end;
var
    paq:paquete;
begin
    a:=nil;
    leerPaquete(paq);
    while(paq.codEnvio <> fin) do begin
        agregarAlArbol(a,paq);
        leerPaquete(paq);
    end;
end;

procedure imprimirArbol(a: arbol);
begin
    if(a <> nil) then begin
        imprimirArbol(a^.HI);
        writeln('DNI EMISOR: ',a^.dato.dniEmisor);
        writeln('TOTAL ENVIADOS: ',a^.dato.totalEnviados);
        writeln('SUMA PESO: ',a^.dato.sumaPeso:2:2);
        writeln('-------------------');
        imprimirArbol(a^.HD);
    end;
end;

procedure generarLista(a:arbol; var l,ult:lista; x:integer);
    procedure agregarAtras(var l,ult:lista;info:infoPaquete);
    var
        aux:lista;
    begin
        new(aux);
        aux^.dato:=info;
        aux^.sig:=nil;
        if(l = nil) then
            l:=aux
        else
            ult^.sig:=aux;
        ult:=aux;
    end;
begin
    if(a <> nil) then begin
        generarLista(a^.HI,l,ult,x);
        if(a^.dato.totalEnviados < x) then
            agregarAtras(l,ult,a^.dato);
        generarLista(a^.HD,l,ult,x);
    end;
end;

procedure imprimirLista(l:lista);
begin
    while(l <> nil) do begin
        writeln('DNI EMISOR: ',l^.dato.dniEmisor);
        writeln('TOTAL ENVIADOS: ',l^.dato.totalEnviados);
        writeln('SUMA PESO: ',l^.dato.sumaPeso:2:2);
        writeln('-------------------');
        l:=l^.sig;
    end;
end;

procedure buscarDNI(a:arbol; dni:integer; var info:infoPaquete; var ok:boolean);
begin
    if(a <> nil) then begin
        if(a^.dato.dniEmisor = dni) then begin
            info.dniEmisor:=dni;
            info.totalEnviados:=a^.dato.totalEnviados;
            info.sumaPeso:= a^.dato.sumaPeso;
            ok:=true;
        end
        else
            if(dni < a^.dato.dniEmisor) then
                buscarDNI(a^.HI,dni,info,ok)
            else
                buscarDNI(a^.HD,dni,info,ok)
    end
end;

procedure imprimirInfo(info:infoPaquete);
begin
     writeln('DNI EMISOR: ',info.dniEmisor);
     writeln('TOTAL ENVIADOS: ',info.totalEnviados);
     writeln('SUMA PESO: ',info.sumaPeso:2:2);
end;
//-----programa principal------
var
    a:arbol;
    x,dni:integer;
    l,ult:lista;
    ok:boolean;
    info:infoPaquete;
begin
    l:=nil;
    ult:=nil;
    ok:=false;
    randomize;
    cargarArbol(a);
    writeln('--------ARBOL CARGADO-----------');
    imprimirArbol(a);
    write('Ingrese un valor: ');
    readln(x);
    generarLista(a,l,ult,x);
    
     writeln('--------LISTA CARGADO-----------');
    imprimirLista(l);
    write('Ingrese un DNI: ');
    readln(dni);
    buscarDNI(a,dni,info,ok);
    if(ok) then
        imprimirInfo(info)
    else
        writeln('NO ENCONTRADO!');
end.
