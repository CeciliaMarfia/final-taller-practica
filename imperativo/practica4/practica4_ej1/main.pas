{1. Implementar un programa modularizado para una librería que:
a. Almacene los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados la cantidad total de
unidades vendidas y el monto total. De cada venta se lee código de venta, código del
producto vendido, cantidad de unidades vendidas y precio unitario. El ingreso de las
ventas finaliza cuando se lee el código de venta -1.
b. Imprima el contenido del árbol ordenado por código de producto.
c. Contenga un módulo que reciba la estructura generada en el punto a y retorne el
código de producto con mayor cantidad de unidades vendidas.
d. Contenga un módulo que reciba la estructura generada en el punto a y un código de
producto y retorne la cantidad de códigos menores que él que hay en la estructura.
e. Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de
producto y retorne el monto total entre todos los códigos de productos comprendidos
entre los dos valores recibidos (sin incluir).

}program ejercicioPractica;
const
	fin =  -1;
type
	producto = record
	    codProd:integer;
	    unidadesVendidas:integer;
	    montoTotal:real;
	end;
	
	venta = record
	    codVenta:integer;
	    codProducto:integer;
	    cantVendidas:integer;
	    precioUnitario:real;
	end;


    arbol = ^nodoArbol;  /// ordenado por codigo de producto
    
    nodoArbol = record
        dato: producto;
        hi: arbol;
        hd: arbol;
    end;

{---------------Fin del type----------------}
procedure cargarArbol(var a:arbol);
    procedure leerVenta (var ven: venta);
    begin
    	with ven do begin
    	    codVenta:= random (10)-1;
    	    writeln('CODIGO DE VENTA : ',codVenta);
    		if( codVenta <> fin) then begin
    		    codProducto := random (10)+1;
    			writeln('CODIGO PRODUCTO : ',codProducto);
                cantVendidas:= random (50);
        		writeln('CANTIDADES VENDIDAS : ',cantVendidas);
        	    precioUnitario:= random (100);
        	    writeln('PRECIO UNITARIO: $',precioUnitario:2:2);
        	    writeln('............................')
    		end;
    	end;
    end;
    
    procedure agregarAlArbol(var a:arbol; ven:venta);
        procedure armarProducto(ven:venta; var prod:producto);
        begin
            prod.codProd:=ven.codProducto;
	        prod.unidadesVendidas:= ven.cantVendidas;
	        prod.montoTotal:= ven.cantVendidas+ ven.precioUnitario;
        end;
    var
        prod:producto;
    begin
        if(a = nil) then begin
            new(a);
            armarProducto(ven,prod);
            a^.dato:=prod;
            a^.HI:=nil;
            a^.HD:=nil;
        end
        else
            if (ven.codProducto = a^.dato.codProd) then begin //si el nodo ya está almacenado lo actualizo
                a^.dato.unidadesVendidas:= a^.dato.unidadesVendidas + ven.cantVendidas;
                a^.dato.montoTotal:= a^.dato.montoTotal + (ven.cantVendidas * ven.precioUnitario);
            end
            else if(ven.codProducto < a^.dato.codProd) then
                agregarAlArbol(a^.HI,ven)
            else
                agregarAlArbol(a^.HD,ven)
    end;
var
    ven:venta;
begin
    leerVenta(ven);
    while(ven.codVenta <> fin) do begin
        agregarAlArbol(a,ven);
        leerVenta(ven);
    end;
end;
procedure imprimirArbol(a:arbol);
begin
    if(a <> nil) then begin
        imprimirArbol(a^.HI);
        writeln('CODIGO PRODUCTO : ',a^.dato.codProd);
        writeln('UNIDADES VENDIDAS : ',a^.dato.unidadesVendidas);
        writeln('MONTO TOTAL : $',a^.dato.montoTotal:2:2);
        writeln('------------------------');
        imprimirArbol(a^.HD);
    end;
end;

procedure masVendido (a: arbol; var maxCant: integer; var maxCod: integer);
	procedure actualizarMaximo(a:arbol;var maxCant, maxCod:integer);
	begin
		if (a^.dato.unidadesVendidas>maxCant) then begin
			maxCant:=a^.dato.unidadesVendidas;
			maxCod:= a^.dato.codProd;
		end;
	end;
  begin
		if (a <> nil) then begin
			masVendido(a^.HI,maxCant,maxCod);
			actualizarMaximo(a,maxCant,maxCod);
			masVendido(a^.HD,maxCant,maxCod);
		end;
  end;
  
  function cantidadMenores (a: arbol; codigo:integer):integer;
  begin
		if (a = nil) then
			cantidadMenores:=0
		else begin
			if (a^.dato.codProd < codigo) then
            cantidadMenores := cantidadMenores(a^.HI, codigo) + 1 + cantidadMenores(a^.HD, codigo)
        else
            cantidadMenores := cantidadMenores(a^.HI, codigo);
    end;
end;
  
function entreValores(a:arbol; codigo1, codigo2:integer):real;
begin
    if (a = nil) then
        entreValores := 0
    else begin
        if (a^.dato.codProd > codigo1) and (a^.dato.codProd < codigo2) then
            entreValores := entreValores(a^.HI, codigo1, codigo2) + a^.dato.montoTotal + entreValores(a^.HD, codigo1, codigo2)
        else 
            if (a^.dato.codProd <= codigo1) then //si el actual es menor al codigo 1
                entreValores := entreValores(a^.HD, codigo1, codigo2) //tengo que buscar por la derecha
            else  { a^.dato.codProd >= codigo2 }
                entreValores := entreValores(a^.HI, codigo1, codigo2); //debo buscar por la izquierda
    end;
end;

{---------------Programa Principal----------------}

var
    a:arbol;
    maxCant,maxCod,codigo,codigo1,codigo2:integer;
    montoTotal:real;
begin
	randomize;
	maxCant:=-1;
	maxCod:=-1;
	cargarArbol(a);
	writeln('--------ARBOL---------');
    imprimirArbol(a);
    masVendido (a,maxCant,maxCod);
    writeln('Cod. Prod. con mayor cantidad de unidades vendidas:',maxCod);
    write('Ingrese un código: ');
    readln(codigo);
    writeln('Cantidad de productos menores al codigo elegido:',cantidadMenores(a,codigo));
    write('Ingrese un código: ');
    readln(codigo1);
    write('Ingrese otro código: ');
    readln(codigo2);
    montoTotal:= entreValores(a,codigo1,codigo2);
    writeln ('El monto total entre el codigo ', codigo1, ' y el codigo ', codigo2, ' es: ', montoTotal:4:2); 
end.
