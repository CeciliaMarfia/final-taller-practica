program parcial04_08_2023;
const
    fin = 0;
type
    rangoCategoria = 1..6;
    rangoDia = 1..31;
    rangoMes = 1..12;
    
    fecha = record
        dia:rangoDia;
        mes:rangoMes;
        hora:integer;
    end;
    
    direccion = record
        calle:integer;
        nro:integer;
    end;
    
    denuncia = record
        categoria: rangoCategoria;
        DNI : integer;
        dir : direccion;
        fechaDenuncia : fecha;
    end;
    
    lista = ^nodo;
    
    nodo = record
        dato: denuncia;
        sig:lista;
    end;
    
    infoDenuncia = record
        nroCalle:integer;
        denunciasTotales:integer;
        denunciasJulio:integer;
    end;
    
    lista2 = ^nodo2;
    
    nodo2 = record
        dato: infoDenuncia;
        sig:lista2;
    end;
    vecCategoria = array [rangoCategoria] of lista;
//_________fin del type____________
procedure inicializarVector(var v:vecCategoria);
var
    i:rangoCategoria;
begin
    for i:=1 to 6 do
        v[i]:= nil;
end;

procedure cargarVector(var v:vecCategoria);
    procedure leerDenuncia(var den:denuncia);
    begin
        with den do begin
            DNI := random(10);
            writeln('DNI: ',DNI);
            if(DNI <> fin) then begin
                categoria:= random(5) + 1;
                writeln('Categoria: ',categoria);
                writeln('Direccion: ');
                dir.calle := random(3) + 1;
                writeln('calle: ',dir.calle);
                dir.nro := random(900)+1;
                writeln('nro: ',dir.nro);
                fechaDenuncia.dia := random(31) + 1;
                writeln('Dia: ',fechaDenuncia.dia);
                fechaDenuncia.mes := random(12) + 1;
                writeln('Mes: ',fechaDenuncia.mes);
                fechaDenuncia.hora := random(2400);
                writeln('Hora: ',fechaDenuncia.hora);
                writeln('------------------------');
            end;
        end;
    end;
    
    procedure agregarDenuncia (var pri: lista; dato: denuncia);
    var
        aux, ant, act: lista;
    begin
        new(aux);   
        aux^.dato := dato;
        act := pri; // ubico act al inicio de la lista
        while (act <> nil) AND (act^.dato.dir.calle < dato.dir.calle) do begin
                ant := act;
                act := act^.sig; // avanzo en la lista
        end;
        if (act = pri) then // si está vacía o hay que insertar al inicio
                pri := aux
        else // el nuevo nodo va en el medio o al final de la lista
                ant^.sig := aux; // actualizo puntero para insertar nuevo nodo
        aux^.sig := act; // inserto nuevo nodo
    end;

var
    den:denuncia;
begin
    leerDenuncia(den);
    while(den.DNI <> fin) do begin
        agregarDenuncia(v[den.categoria], den); //insertar ordenado
        leerDenuncia(den);
    end;
    
end;

procedure recorrerVector(v:vecCategoria; var l2:lista2);
    procedure agregarAdelante(var l:lista2; dato:infoDenuncia);
    var
        nue:lista2;
    begin
        new(nue);
        nue^.dato:= dato;
        nue^.sig:=l;
        l:=nue;
    end;
var
    i:integer;
    actual,total,julio:integer;
    info: infoDenuncia;
    aux:lista;
begin
    for i:=1 to 6 do begin
        aux:=v[i];
        while(aux <> nil) do begin
            actual:=aux^.dato.dir.calle;
            total:=0; //debo reiniciar los contadores para cada nro!!!!
            julio:=0;
            while(aux<> nil) and (actual= aux^.dato.dir.calle) do begin
                total:=total+ 1;
                if(aux^.dato.fechaDenuncia.mes = 7) then
                    julio:=julio+1;
                aux:=aux^.sig;
            end;
                info.nroCalle:= actual; //VA ACTUAL PORQUE YA AVANCÉ EN LA LISTA
                info.denunciasTotales:= total;
                info.denunciasJulio:= julio;
                agregarAdelante(l2,info);
        end;
    end;
    
end;
procedure calcularMaximo(l2:lista2; var maxDenuncias, calleMayor:integer);
begin
    if(l2 <> nil) then begin
        if(l2^.dato.denunciasTotales > maxDenuncias) then begin
            maxDenuncias:= l2^.dato.denunciasTotales;
            calleMayor:=l2^.dato.nroCalle;
        end;
        calcularMaximo(l2^.sig,maxDenuncias,calleMayor);
    end;
end;

//__________Programa principal___________
var
    v:vecCategoria;
    l2:lista2;
    maxTotal,calleMayor:integer;
begin
    randomize;
    l2 := nil; 
    maxTotal:=-1;
    calleMayor:=-1;
    inicializarVector(v);
    cargarVector(v);
    recorrerVector(v,l2);
    calcularMaximo(l2,maxTotal,calleMayor);
    writeln('Calle con mayor cant. denuncias totales: ', calleMayor);
end.
