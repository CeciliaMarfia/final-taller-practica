{3.- Implementar un programa que procese las ventas de un supermercado. El supermercado
dispone de una tabla con los precios y stocks de los 1000 productos que tiene a la venta.
a) Implementar un módulo que retorne, en una estructura de datos adecuada, los tickets de las ventas.
De cada venta se lee código de venta y los productos vendidos. Las ventas finalizan con el código de
venta -1. De cada producto se lee código y cantidad de unidades solicitadas. Para cada venta, la lectura
de los productos a vender finaliza con cantidad de unidades vendidas igual a 0. El ticket debe contener:
- Código de venta
- Detalle (código de producto, cantidad y precio unitario) de los productos que se pudieron vender. En
caso de no haber stock suficiente, se venderá la máxima cantidad posible.
- Monto total de la venta.
c) Implementar un módulo que reciba la estructura generada en el inciso a) y un código de
producto y retorne la cantidad de unidades vendidas de ese código de producto.}
program Hello;
const
	dimF = 1000;
	finVenta =  -1;
	fin0 =  0;
	valorAlto= 999;
type
	rango = 1..dimF;

	infoProducto = record
		precio:real;
		stock:integer;
	end;
	
	producto = record
		codProducto:integer;
		cantProd:integer;
	end;
	
	listaProducto = ^nodoProducto;
	
	nodoProducto = record             
    	dato: producto;
    	sig: listaProducto;
    end;

	venta = record
		codVenta:integer;
		prod:listaProducto;
	end;
	
	listaDeVentas = ^nodoVentas;
	
	nodoVentas = record
		dato: venta;
    	sig: listaDeVentas;
    end;
	
	detalle = record
		codigoProducto:integer;
		cantidad:integer;
		precioUnitario:real;
	end;
	
	ticket = record
		codigoVenta:integer;
		det:detalle;
		montoTotal:real;
	end;
	
	
    lista = ^nodo;  // ordenada por ...
    nodo = record             
    	dato: ticket;
    	sig: lista;
    end;

    tablaProductos = array [rango] of infoProducto;  // se dispone
//------- FIN DEL TYPE-----
procedure cargarListaVentas(var l:lista);
        procedure agregarAdelante (var pri: listaDeVentas; dato: venta);
    		var
    			 aux: listaDeVentas;
    		begin
    			new (aux);
    			aux^.dato := dato;
    			aux^.sig := pri;
    			pri := aux;
    		end;
    	procedure leerVenta(var ven:venta);
    	begin
    	    write('ingrese el código de venta: ');
    	    readln(ven.codVenta);
    	    if (ven.codVenta <> finVenta) then 
    	        leerProducto(prod);
    	        while (cantProd <> fin0) do begin
    	            
    	            leerProducto(prod);
    	end;
    	procedure leerProducto(var prod:producto);
    	begin
    	    with prod do begin
    	        write('ingrese la cantidad de productos: ');
    	        readln(cantProd);
    	        if (cantProd <> fin0) then begin
    	            write('ingrese el codigo de producto: ');
    	            readln(codProducto);
    	        end;
    	    end;
    	end;
    	
    	procedure cargarVenta(var ven:venta; prod:producto);
    	begin
    	    ven.codigoProducto:= prod.codProducto;
    		ven.cantidad:= prod.cantProd;
    		ven.precioUnitario:= ;
    	end;
    var
        prod:producto;
        ven:venta;
    begin
        l:=nil;
        leerProducto(prod);
        while (prod.cantProd <> fin0) do begin
            cargarVenta(ven,prod);
            agregarAdelante(l,ven);
            leerProducto(prod);
        end;
var
    ven:venta;
begin
    l:=nil;
    leerVenta(ven);
    while (ven.codVenta <> finVenta) do begin
        agregarAdelante(l,ven);
        leerVenta(ven);
    end;

end;
//------- PROGRAMA PRINCIPAL-----
var
    l:lista;
begin
    cargarTabla(tablaProd);//se dispone
    cargarListaVentas(l);
end.
