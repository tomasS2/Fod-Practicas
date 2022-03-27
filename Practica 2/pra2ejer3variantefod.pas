{

3. Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
stock mínimo y precio del producto.
Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
maestro. La información que se recibe en los detalles es: código de producto y cantidad
vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
debajo del stock mínimo.
Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
puede venir 0 o N registros de un determinado producto.}


program p2ej3variantefod;
const	
	VALOR_ALTO=9999;
type
	cad30=string[30];
	rProducto=record
		codProd:integer;
		descripcion:cad30;
		precio:real;
		stockActual:integer;
		stockMinimo:integer;
	end;
	
	rPedido=record
		codProd:integer;
		cantPed:integer;
	end;
	
	archProd= file of rProducto;//mae
	archCarga = file of rPedido;//det
	
	aArchCarga= array [1..30]of archCarga;
	aPedidos= array [1..30]of rPedido;
	
procedure cargarArchivoMaestro (var mae:archProd; var aDet:aArchCarga);
	procedure leerDetalle (var det:archCarga; var rPed:rPedido);
	begin
		if not eof (det) then 
			read(det,rPed)
		else
			rPed.codProd:=VALOR_ALTO;
	end;
	
	procedure minimo (var aPedi:aPedidos; var min: rPedido; var aDet:aArchCarga);
	var
		minCod,i,indiMin:integer;
	begin
		minCod:=9999;
		for i:=1 to 30 do begin
			if (aPedi[i].codProd<minCod)then begin
				minCod:=aPedi[i].codProd;
				indiMin:=i;
			end
		end;
		leerDetalle(aDet[indiMin],aPedi[indiMin]);
	end;
	
var
	informeProdDebajoDeStock:text;
	min:rPedido;
	aPedi:aPedidos;
	i:integer;
	regm:rProducto;
begin
	assign(informeProdDebajoDeStock,'debajoDeStockMinimo.txt');
	rewrite(informeProdDebajoDeStock);
	assign(mae,'archMaestroEj3Pr2');
	reset(mae);
	for i:=1 to 30 do begin
		assign(aDet[i],'archDetalleEj3pr2modif_'+Chr(i+48));
		reset(aDet[i]);
		leerDetalle(aDet[i],aPedi[i]);
	end;
	minimo(aPedi,min,aDet);
	while (min.codProd<>VALOR_ALTO) do begin
		read(mae,regm);
		while (regm.codProd<>min.codProd) do 
			read(mae,regm);
		while (regm.codProd=min.codProd) do begin 
			regm.stockActual:=regm.stockActual-min.cantPed;
			minimo(aPedi,min,aDet);
		end;
		if (regm.stockActual<regm.stockMinimo)then//a
			write(informeProdDebajoDeStock,regm.codProd);
	end;
	close (mae);
	close (informeProdDebajoDeStock);
	for i:=1 to 30 do 
		close(aDet[i]);
end;
	
	
var
	mae:archProd;
	aDet:aArchCarga;
begin
	
	cargarArchivoMaestro(mae,aDet);
end.
