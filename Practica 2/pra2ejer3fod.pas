{
3. Una empresa de electrodomésticos posee un archivo conteniendo información sobre los
productos que tiene a la venta. De cada producto se registra: código de producto,
descripción, precio, stock actual y stock mínimo. Diariamente se efectuan envios a cada uno
de las 4 sucursales que posee. Para esto, cada sucursal envía un archivo con los pedidos
de productos. Cada pedido contiene código de producto y cantidad pedida. Se pide realizar
el proceso de actualización del archivo maestro con los cuatro archivos detalle, obteniendo
un informe de aquellos productos que quedaron debajo del stock mínimo y de aquellos
pedidos que no pudieron satisfacerse totalmente por falta de elementos, informando: la
sucursal, el producto y la cantidad que no pudo ser enviada (diferencia entre lo que pidió y lo
que se tiene en stock) .
NOTA 1: Todos los archivos están ordenados por código de producto y el archivo maestro
debe ser recorrido sólo una vez y en forma simultánea con los detalle.
NOTA 2: En los archivos detalle puede no aparecer algún producto del maestro. Además,
tenga en cuenta que puede aparecer el mismo producto en varios detalles. Sin embargo, en
un mismo detalle cada producto aparece a lo sumo una vez.
}

program p2ej3fod;
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
		sucursalQuePide:integer;
		codProd:integer;
		cantPed:integer;
	end;
	
	archProd= file of rProducto;//mae
	archCarga = file of rPedido;//det
	
	aArchCarga= array [1..4]of archCarga;
	aPedidos= array [1..4]of rPedido;
	
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
		for i:=1 to 4 do begin
			if (aPedi[i].codProd<minCod)then begin
				minCod:=aPedi[i].codProd;
				indiMin:=i;
			end
		end;
		min:=aPedi[indiMin];
		leerDetalle(aDet[indiMin],aPedi[indiMin]);
	end;
	
var
	informeProdDebajoDeStock:text;
	informeNoSatisfacen:text;
	min:rPedido;
	aPedi:aPedidos;
	i,falta:integer;
	regm:rProducto;
begin
	assign(informeProdDebajoDeStock,'debajoDeStockMinimo.txt');
	rewrite(informeProdDebajoDeStock);
	assign(informeNoSatisfacen,'prodNoSatisfacen.txt');
	rewrite(informeNoSatisfacen);
	assign(mae,'archMaestroEj3Pr2');
	reset(mae);
	for i:=1 to 4 do begin
		assign(aDet[i],'archDetalleEj3pr2_'+Chr(i+48));
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
			if (regm.stockActual-min.cantPed<0)then//b 
				falta:=min.cantPed-regm.stockActual;
				write(informeNoSatisfacen,falta,regm.codProd,min.sucursalQuePide);
			minimo(aPedi,min,aDet);
		end;
		if (regm.stockActual<regm.stockMinimo)then//a
			write(informeProdDebajoDeStock,regm.codProd);
	end;
	close (mae);
	close (informeProdDebajoDeStock);
	close (informeNoSatisfacen);
	for i:=1 to 4 do 
		close(aDet[i]);
end;
	
	
var
	mae:archProd;
	aDet:aArchCarga;
begin
	cargarArchivoMaestro(mae,aDet);
end.
	
	
