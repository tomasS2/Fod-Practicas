{
7- El encargado de ventas de un negocio de productos de limpieza desea administrar el
stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los productos que comercializa. 
De cada producto se maneja la siguiente información:
código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
Diariamente se genera un archivo detalle donde se registran todas las ventas de productos
realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas.
Se pide realizar un programa con opciones para:
	a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
		●Ambos archivos están ordenados por código de producto.
		● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo detalle.
		● El archivo detalle sólo contiene registros que están en el archivo maestro.
	b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
		stock actual esté por debajo del stock mínimo permitido.
} 

program p2ej7fod;
const 
	VALOR_ALTO = 9999;

type
	rProducto = record//mae
		cod_prod:integer;
		nom_comercial:string[15];
		precio_venta:real;
		stock_actual:integer;
		stock_minimo:integer;
	end;
	
	rVenta = record //det
		cod_prod:integer;
		cant_uni_vendidas:integer;
	end;
	
	fileProducto = file of rProducto;//maestro
	fileVenta = file of rVenta; //det
	
procedure actualizarMaestro(var mae: fileProducto;var det: fileVenta);
var
	regm:rProducto;
	regd:rVenta;
begin
	while (not eof (det))do begin
		read(mae, regm);
		read(det, regd);
		while (regd.cod_prod <> regm.cod_prod) do 
			read(mae, regm);
		regm.stock_actual:=regm.stock_actual - regd.cant_uni_vendidas;
		seek(mae,filepos(mae)-1);
		write(mae, regm);
	end;
	close (det);
	close (mae);
end;

procedure crearTxt (var mae:fileProducto);
var
	txt:text;
	regm:rProducto;
begin
	assign(txt,'stock_minimo.txt');
	rewrite(txt);
	reset(mae);
	while not eof (mae) do begin
		read(mae,regm);
		if (regm.stock_actual < regm.stock_minimo) then
			write(txt, regm.cod_prod,regm.stock_minimo,regm.precio_venta,regm.stock_actual,regm.nom_comercial);
	end;
	close (txt);
	close (mae);
end;

var
	mae: fileProducto;
	det: fileVenta;
	x:integer;
begin
	assign(mae,'maestro');
	reset(mae);
	assign(det,'detalle');
	reset(det);
	writeln ('Numero 1 para actualizar maestro.')  ;
	writeln('Numero 2 para Listar en un archivo de texto llamado "stock_minimo.txt" aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido.');
	readln(x);
	case x of
		1: actualizarMaestro(mae,det);
		2: crearTxt(mae);
	end;
end.
		
	
	
	
	
	
