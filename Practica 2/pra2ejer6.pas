{
6- Se desea modelar la información necesaria para un sistema de recuentos de casos de
covid para el ministerio de salud de la provincia de buenos aires.
Diariamente se reciben archivos provenientes de los distintos municipios, la información
contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad casos
activos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos
fallecidos.
El ministerio cuenta con un archivo maestro con la siguiente información: código localidad,
nombre localidad, código cepa, nombre cepa, cantidad casos activos, cantidad casos
nuevos, cantidad recuperados y cantidad de fallecidos.
Se debe realizar el procedimiento que permita actualizar el maestro con los detalles
recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de
localidad y código de cepa.
Para la actualización se debe proceder de la siguiente manera:
1. Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
2. Idem anterior para los recuperados.
3. Los casos activos se actualizan con el valor recibido en el detalle.
4. Idem anterior para los casos nuevos hallados.
Realice las declaraciones necesarias, el programa principal y los procedimientos que
requiera para la actualización solicitada e informe cantidad de localidades con más de 50
casos activos (las localidades pueden o no haber sido actualizadas).

TA MAL.


}
program p2ej6fod;
const
	VALOR_ALTO= 9999;
type
	rInfoCasos = record
		cant_casos_activos:integer;
		cant_casos_nuevos:integer;
		cant_casos_recuperados:integer;
		cant_casos_fallecidos : integer;
	end;
	rInfoMunicipio = record
		cod_localidad:integer;
		cod_cepa: integer;
		rInCasos:rInfoCasos;
	end;
	rInfoMinisterio = record
		nom_localidad: String[20];
		nom_cepa: String[20];
		rInfoMuni: rInfoMunicipio;
	end;
	
	fileMunicipio = file of rInfoMunicipio;//det
	fileMinisterio = file of rInfoMinisterio;
	
	arr_det_muni = array [1..10] of fileMunicipio;
	arr_info_muni = array [1..10] of rInfoMunicipio;
	
	
	
	
	
procedure leerDetalle(var det: fileMunicipio; var rInfoDet:rInfoMunicipio);
begin
	if not eof (det) then
		read(det,rInfoDet)
	else
		rInfoDet.cod_localidad:=VALOR_ALTO;
end;
	
		
procedure minimo (var aInfoDet:arr_info_muni; var min:rInfoMunicipio ;var aDet: arr_det_muni );
var
	i,indiMin:integer;
begin
	min.cod_localidad:=9999;
	for i:=1 to 10 do begin
		if (aInfoDet[i].cod_localidad<min.cod_localidad)then begin
			if (aInfoDet[i].cod_cepa<min.cod_cepa)then begin	
				min:=aInfoDet[i];
				indiMin:=i;
			end;
		end;
	end;
	min:=aInfoDet[indiMin];
	leerDetalle(aDet[indiMin],aInfoDet[indiMin]);
end;		

	

var

	i,cant_casos_activos,cant_loc_50,codCepa:integer;
	aDet:arr_det_muni;
	aInfoDet:arr_info_muni;
	min:rInfoMunicipio;
	regm:rInfoMinisterio;
	mae:fileMinisterio;
	rCasos:rInfoCasos;

begin
	assign(mae, 'archMaestro');
	reset(mae);
	for i:=1 to 10 do begin	
		assign(aDet[i],'archDetalle'+Chr(i+48));
		reset(aDet[i]);
		leerDetalle(aDet[i],aInfoDet[i]);
	end;
	cant_loc_50:=0;
	minimo(aInfoDet,min,aDet);
	while (min.cod_localidad <> VALOR_ALTO) do begin
		read(mae, regm);
		cant_casos_activos:=0;
		
		while (min.cod_localidad <> regm.rInfoMuni.cod_localidad) do begin
			if (regm.rInfoMuni.rInCasos.cant_casos_activos>50)  then //suma en el contador, en el caso que no haya sido actualizada, la localidad que tenga mas de 50 casos activos.
				cant_loc_50:=cant_loc_50+1;
			read(mae, regm);
		end;
				
		while (min.cod_localidad = regm.rInfoMuni.cod_localidad)do begin
			codCepa:= min.cod_cepa;
			
			rCasos.cant_casos_fallecidos:=0;
			rCasos.cant_casos_recuperados:=0;
			while (min.cod_localidad = regm.rInfoMuni.cod_localidad)and(min.cod_cepa = codCepa)do begin
			
				rCasos.cant_casos_activos:=min.rInCasos.cant_casos_activos;
				rCasos.cant_casos_nuevos:=min.rInCasos.cant_casos_nuevos ;
				rCasos.cant_casos_recuperados:=min.rInCasos.cant_casos_recuperados + rCasos.cant_casos_recuperados;
				rCasos.cant_casos_fallecidos:=min.rInCasos.cant_casos_fallecidos + rCasos.cant_casos_fallecidos;
				
				cant_casos_activos:=regm.rInfoMuni.rInCasos.cant_casos_activos+cant_casos_activos;
				
				minimo(aInfoDet,min,aDet);
			end;
			regm.rInfoMuni.rInCasos.cant_casos_activos:=rCasos.cant_casos_activos ;
			regm.rInfoMuni.rInCasos.cant_casos_nuevos:=rCasos.cant_casos_nuevos ;
			regm.rInfoMuni.rInCasos.cant_casos_recuperados:=rCasos.cant_casos_recuperados + regm.rInfoMuni.rInCasos.cant_casos_recuperados;
			regm.rInfoMuni.rInCasos.cant_casos_fallecidos:=rCasos.cant_casos_fallecidos + regm.rInfoMuni.rInCasos.cant_casos_fallecidos;
			seek(mae,filepos(mae)-1);
			write(mae,regm);
		end;
		if (cant_casos_activos>50) then //localidad que tuvo que ser actualzada. informa si la cant activos es may a 50 
				cant_loc_50:=cant_loc_50+1;
	end;	
	close(mae);
	for i:=1 to 10 do
		close(aDet[i]);
	writeln('cant localidades con mas de 50 casos activos: ',cant_loc_50);	
end.








