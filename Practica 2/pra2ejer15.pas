{
15. Se desea modelar la información de una ONG dedicada a la asistencia de personas con
carencias habitacionales. La ONG cuenta con un archivo maestro conteniendo información
como se indica a continuación: Código pcia, nombre provincia, código de localidad, nombre
de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin
agua,# viviendas sin sanitarios.
Mensualmente reciben detalles de las diferentes provincias indicando avances en las obras
de ayuda en la edificación y equipamientos de viviendas en cada provincia. La información
de los detalles es la siguiente: Código pcia, código localidad, #viviendas con luz, #viviendas
construidas, #viviendas con agua, #viviendas con gas, #entrega sanitarios.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
provincia y código de localidad.
Para la actualización se debe proceder de la siguiente manera:

1. Al valor de vivienda con luz se le resta el valor recibido en el detalle.
2. Idem para viviendas con agua, gas y entrega de sanitarios.
3. A las viviendas de chapa se le resta el valor recibido de viviendas construidas
* 
La misma combinación de provincia y localidad aparecen a lo sumo una única vez.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades sin viviendas de
chapa (las localidades pueden o no haber sido actualizadas).
}
program p2ej15fod;
const	
	VALOR_ALTO = 9999;

type
	cad20 = string[20];
	
		
	rInfoMaestro = record
		cod_pcia: integer;
		cod_loc: integer;
		nom_prov: cad20;
		nom_loc: cad20;
		c_viv_sin_luz: integer;
		c_viv_sin_gas: integer;
		c_viv_de_chapa: integer;
		c_viv_sin_agua: integer;
		c_viv_sin_sanitarios: integer;
	end;
	rInfoDetalle = record
		cod_pcia: integer;
		cod_loc: integer;
		c_viv_luz: integer;
		c_viv_constru: integer;
		c_viv_agua: integer;
		c_viv_gas: integer;
		c_sanitarios:integer;
	end;
		
	fileMaestro = file of rInfoMaestro;	
	fileDetalle = file of rInfoDetalle;	
		
	arr_det = array [1..10] of fileDetalle;
	arr_info_detalle = array [1..10] of rInfoDetalle;
	
procedure leer (var det: fileDetalle; VAR r:rInfoDetalle);
begin
	if not eof (det) then 
		read(det, r)
	else
		r.cod_pcia:=VALOR_ALTO;
end;
	
procedure minimo (var aDet: arr_det;var min: rInfoDetalle; var aInfo:arr_info_detalle);
var
	i,indiMin:integer;
begin
	min.cod_pcia:=9999;
	min.cod_loc:=9999;
	for i:=1 to 10 do begin
		if (aInfo[i].cod_pcia<min.cod_pcia)then begin
			if (aInfo[i].cod_loc<min.cod_loc)then begin
				min:= aInfo[i];
				indiMin:= i;
			end;
		end;
	end;
	min:=aInfo[indiMin];
	leer(aDet[indiMin],aInfo[indiMin]);
end;

var
	i:integer;
	min: rInfoDetalle;
	aInfoDet: arr_info_detalle;
	aDet: arr_det;
	mae: fileMaestro;
	regm: rInfoMaestro;
begin
	for i:=1 to 10 do begin
		assign(aDet[i],'detalle'+Chr(i));
		reset(aDet[i]);
		leer(aDet[i],aInfoDet[i]);
	end;
	assign(mae, 'maestro');
	reset(mae);
	minimo(aDet,min,aInfoDet);
	while (min.cod_pcia<>VALOR_ALTO) do begin
		read(mae,regm);
		while (min.cod_pcia<>regm.cod_pcia) do 
			read(mae,regm);
		while (min.cod_pcia = regm.cod_pcia) do begin
			while(min.cod_pcia = regm.cod_pcia)and (min.cod_loc = regm.cod_loc) do begin 
				regm.c_viv_sin_luz := regm.c_viv_sin_luz - min.c_viv_luz;
				regm.c_viv_sin_gas := regm.c_viv_sin_gas - min.c_viv_gas;
				regm.c_viv_sin_agua := regm.c_viv_sin_agua - min.c_viv_gas;
				regm.c_viv_sin_sanitarios := regm.c_viv_sin_sanitarios - min.c_sanitarios;
				regm.c_viv_de_chapa := regm.c_viv_de_chapa - min.c_viv_constru;
				minimo(aDet,min,aInfoDet);
			end;
		end;
		seek(mae, filepos(mae)-1);
		write(mae, regm);
	end;
	for i:=1 to 10 do 
		close(aDet[i]);
	close(mae);
end.

		
		
		
		
		
		
		
		
		
		
		
		
		
