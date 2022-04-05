{
8. Se cuenta con un archivo que posee información de las ventas que realiza una empresa a
los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por
cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total
mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el
cliente.
Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la
empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año,
mes, día y monto de la venta.
El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron
compras.
}


program p2ej8fod;
const
	VALOR_ALTO=9999;

type	
	cad15 = string[15];
	rInfoMaestro = record
		cod_cli:integer;
		nom:cad15;
		ape:cad15;
		monto:real;
		anio:integeR;
		mes:integeR;
		dia:integer;
	end; 
	
	fileMaestro = file of rInfoMaestro;
		
procedure leer (var mae:fileMaestro; var rInfo: rInfoMaestro);
begin
	if not eof (mae) then
		read(mae,rInfo)
	else
		rInfo.cod_cli:=VALOR_ALTO;
end;



var
	cod_actual,mes_actual,anio_actual:integer;
	tot_mensual,monto_tot_ano,monto_tot_ventas_empresa:real;
	mae:fileMaestro;
	regm:rInfoMaestro;

begin
	assign(mae,'maestro');
	reset(mae);
	monto_tot_ventas_empresa:=0;
	leer(mae,regm);
	while (regm.cod_cli<>VALOR_ALTO)do begin
		writeln(regm.nom, regm.ape);
		cod_actual:=regm.cod_cli;
		while (cod_actual = regm.cod_cli)do begin
			monto_tot_ano:=0;
			anio_actual:=regm.anio;
			while (anio_actual = regm.anio)and(cod_actual = regm.cod_cli)do begin
				tot_mensual:=0;
				mes_actual:=regm.mes;
				while (mes_actual = regm.mes)and(cod_actual = regm.cod_cli)and(anio_actual = regm.anio)do begin
					tot_mensual:=regm.monto+tot_mensual;
					leer(mae,regm);
				end;
				writeln(tot_mensual);
				monto_tot_ano:=monto_tot_ano+tot_mensual;
			end;
			writeln(monto_tot_ano);
		end;
		monto_tot_ventas_empresa:=monto_tot_ventas_empresa+monto_tot_ano;
	end;
	writeln(monto_tot_ventas_empresa);
end.
		
		
		
		
		
		
		
		
		
		
