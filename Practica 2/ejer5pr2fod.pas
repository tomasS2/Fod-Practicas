{
5. A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de
toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha
información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas
en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro
reuniendo dicha información.
Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida
nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula
del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del
padre.
En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y
apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y
lugar.
Realizar un programa que cree el archivo maestro a partir de toda la información de los
archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre,
apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y
apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció,
además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se
deberá, además, listar en un archivo de texto la información recolectada de cada persona.
Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.
Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y
además puede no haber fallecido.
}
program ej5pr2fod;

	VALOR_ALTO=9999;
type

	cad15=String[15];
	cad30=String[30];
	cad8=String[8];
	rInfoDire=record
		calle:integer;
		nro:integer;
		piso:integer;
		depto:char;
		ciudad:cad30;
	end;
	rNacimiento=Record
		nro_partida:integer;
		nom:cad15;
		ape:cad15;
		direccion:rInfoDire;
		matricula_medico:integer;
		nom_mad:cad15;
		ape_mad:cad15;
		dni_mad:cad8;
		nom_pad:cad15;
		ape_pad:cad15;
		dni_pad:cad8;
	end;
	
	rFallecimiento=Record
		nro_partida:integer;
		nom:cad15;
		ape:cad15;	
		dni:cad8;
		matricula_med_deceso:integer;
		fecha:cad15;
		hora:cad8;
		lugar:cad30;
	end;
	
	rInfoArchivo=record//record del maestro.
		nacimiento=rNacimiento;
		fallecimiento=rFallecimiento;
	end;
	
	arch_mae=file of rInfoArchivo;
	arch_det_nacimiento= file of rNacimiento;
	arch_det_fallecimiento= file of rFallecimiento;
	
	aFallecimientos=array[1..50]of rFallecimiento;
	aNacimientos=array[1..50]of rNacimiento;
	
	arr_arch_nacimientos=array[1..50]of arch_det_nacimiento;
	arr_arch_fallecimientos=array[1..50]of arch_det_fallecimiento;

	procedure leerDetalleNacimiento (var det: arch_det_nacimiento; var r:rNacimiento);
	begin
		if not eof (det) then 
			read(det,r)
		else
			r.nro_partida:=VALOR_ALTO;
	end;
	procedure leerDetalleFallecimiento(var det: arch_det_fallecimiento; var r:rFallecimiento);
	begin
		if not eof (det) then 
			read(det,r)
		else
			r.nro_partida:=VALOR_ALTO;
	end;
	
	
	procedure minimoNac (var aNac:aNacimientos; var min: rNacimientos; var aDet:arr_arch_nacimiento);
	var
		minCod,i,indiMin:integer;
	begin
		minCod:=9999;
		for i:=1 to 30 do begin
			if (aNac[i].nro_partida<minCod)then begin
				minCod:=aNac[i].nro_partida;
				indiMin:=i;
			end
		end;
		min:=aNac[indiMin];
		leerDetalle(aDet[indiMin],aNac[indiMin]);
	end;
	procedure minimoFallec (var aFallec:aFallecimientos; var min: rFallecimiento; var aDet:arr_arch_fallecimiento);
	var
		minCod,i,indiMin:integer;
	begin
		minCod:=9999;
		for i:=1 to 30 do begin
			if (aFallec[i].nro_partida<minCod)then begin
				minCod:=aFallec[i].nro_partida;
				indiMin:=i;
			end
		end;
		min:=aFallec[indiMin];
		leerDetalle(aDet[indiMin],aFallec[indiMin]);
	end;

var
	minNac:rNacimiento;
	minFac:rFallecimiento;
	mae:arch_mae;
	arrNacim:aNacimientos;
	arrFallec:aFallecimientos;
	archDetNac:arch_det_nacimiento;
	archDetFal:arch_det_fallecimiento;
begin 
	assign(mae,'archMaeEj5pr2');
	rewrite(mae);
	for i:=1 to 50 do begin
		assign(arrNacim[i],'archDetNacim'+Chr(i+48));
		assign(arrFallec[i],'archDetFallec'+Chr(i+48));
		reset(arrNacim[i]);
		reset(arrFallec[i]);
		leerDetalleNacimiento(arrNacim[i],aNac[i]);
		leerDetalleFallecimiento(arrFallec[i],aFalle[i]);
	end;
	minimoNac(arrNacim,minNac,archDetNac);
	while (minNac.nro_partida)do begin
		
		
end.	
