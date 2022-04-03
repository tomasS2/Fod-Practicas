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
const
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
		nacimiento:rNacimiento;
		fallecimiento:rFallecimiento;
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

	procedure minimoNac (var aNac:aNacimientos; var min: rNacimiento; var aDet:arr_arch_nacimientos);
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
		leerDetalleNacimiento(aDet[indiMin],aNac[indiMin]);
	end;


	procedure minimoFallec (var aFallec:aFallecimientos; var min: rFallecimiento; var aDet:arr_arch_fallecimientos);
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
		leerDetalleFallecimiento(aDet[indiMin],aFallec[indiMin]);
	end;

var
	i:integer;
	rInfoTotal:rInfoArchivo;
	minNac:rNacimiento;
	minFac:rFallecimiento;
	mae:arch_mae;
	arrFallec:aFallecimientos;
	arrNacim:aNacimientos;
	arrDetNac:arr_arch_nacimientos;
	arrDetFal:arr_arch_fallecimientos;
	
begin 
	assign(mae,'archMaeEj5pr2');
	rewrite(mae);
	for i:=1 to 50 do begin
		assign(arrDetNac[i],'archDetNacim'+Chr(i+48));
		assign(arrDetFal[i],'archDetFallec'+Chr(i+48));
		reset(arrDetNac[i]);
		reset(arrDetFal[i]);
		leerDetalleNacimiento(arrDetNac[i],arrNacim[i]);
		leerDetalleFallecimiento(arrDetFal[i],arrFallec[i]);
	end;
	minimoFallec(arrFallec,minFac,arrDetFal);
	while (minFac.nro_partida <> VALOR_ALTO)do begin
		minimoNac(arrNacim, minNac,arrDetNac);
		while (minFac.nro_partida <> minNac.nro_partida)do begin	
			rInfoTotal.nacimiento:=minNac;
			write(mae, rInfoTotal);
			minimoNac(arrNacim, minNac,arrDetNac);
		end;
		while (minFac.nro_partida = minNac.nro_partida) do begin
			rInfoTotal.nacimiento:=minNac;
			rInfoTotal.fallecimiento:=minFac;
			write(mae, rInfoTotal);
			minimoFallec(arrFallec,minFac,arrDetFal);
		end;
	end;
	close (mae);
	for i:=1 to 50 do begin	
		close(arrDetNac[i]);
		close(arrDetFal[i]);
	end;
end.
