{
9. Se necesita contabilizar los votos de las diferentes mesas electorales registradas por
provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de
provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa.
Presentar en pantalla un listado como se muestra a continuación:

Código de Provincia

Código de Localidad	 Total de Votos
................................ ......................
................................ ......................
Total de Votos Provincia: ____
 

Código de Provincia

Código de Localidad Total de Votos
................................ ......................
Total de Votos Provincia: ___
…………………………………………………………..
Total General de Votos: ___
 

NOTA: La información se encuentra ordenada por código de provincia y código de
localidad
}

program p2ej9fod;
const 
	VALOR_ALTO = 9999;

type
	rInfoMaestro=record
		cod_pro:integer;
		cod_loc:integer;
		num_mes:integer;
		cant_votos_mesa:integer;
	end;
	fileMaestro = file of rInfoMaestro;



procedure leer (var mae:fileMaestro; var rInfo: rInfoMaestro);
begin
	if not eof (mae) then
		read(mae,rInfo)
	else
		rInfo.cod_pro:=VALOR_ALTO;
end;
	
var
	tot_vot_localidad,tot_vot_prov,tot_vot_general,cod_loc_actual,cod_prov_act: integer;
	mae:fileMaestro;
	regm:rInfoMaestro;
begin
	assign(mae,'archivo');
	reset(mae);
	tot_vot_general:=0;
	leer(mae,regm);
	while (regm.cod_pro<>VALOR_ALTO) do begin
		
		cod_prov_act:= regm.cod_pro;
		writeln(cod_prov_act);
		tot_vot_prov:=0;
		while (cod_prov_act = regm.cod_pro)do begin
			cod_loc_actual:=regm.cod_loc;
			tot_vot_localidad:=0;
			while (cod_loc_actual = regm.cod_loc)do begin
				tot_vot_localidad:=tot_vot_localidad+regm.cant_votos_mesa;
				leer(mae,regm);
			end;
			write(cod_loc_actual,tot_vot_localidad);
			tot_vot_prov:=tot_vot_prov+tot_vot_localidad;
		end;
		write(tot_vot_prov);
		tot_vot_general:=tot_vot_general+tot_vot_prov;
	end;
	write(tot_vot_general);
end.
	
	
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
