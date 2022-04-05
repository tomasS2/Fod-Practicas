{
11. A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un
archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas
alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos
agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de
localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos
necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.
NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle
pueden venir 0, 1 ó más registros por cada provincia.
}

program p2ej11fod;
const	
	VALOR_ALTO = 'ZZZ';
type
	cad15=string[15];
	rInfoMae = record
		nom_prov: cad15;
		cant_per_alfabetizadas: integer;
		total_encuestados: integer;
	end;
	
	rInfoDet = record
		nom_prov: cad15;
		cod_loc: integeR;
		cant_per_alfabetizadas: integer;
		cant_per_encuestados: integer;
	end;
	fileMae = file of rInfoMae;
	fileDet = file of rInfoDet;

procedure leer (var det:fileDet; var rInfo: rInfoMae);
begin
	if not eof (det) then
		read(mae, rInfo)
	else
		rInfo.nom_prov:=VALOR_ALTO;
end;
	

procedure minimo (var d1,d2: fileDet; var  rDet1,rDet2: rInfoDet; var min: rInfoDet);
begin
	if (d1.nom_prov <= d2.nom_prov) then  begin
		min:=d1;
		leer(d1,rDet1);
	end
	else
		min:=d2;
		leer(d2,rDet2);
end;



var
	min,rDet1,rDet2: rInfoDet;
	det1,det2: fileDet;
	mae: fileMae;
	regm:rInfoMae;
begin
	assign(det1,'det1');
	assign(det2,'det2');
	assign(mae,'mae');
	reset(det1);
	reset(det2);
	reset(mae);
	leer(det1);
	leer(det2);
	minimo(det1,det2,rDet1,rDet2,min);
	while (min.nom_prov <> VALOR_ALTO) do begin
		read(mae,regm);
		while (regm.nom_prov <> min.nom_prov)do 
			read(mae,regm);
		while (regm.nom_prov = min.nom_prov)do begin
			regm.cant_per_alfabetizadas:= regm.cant_per_alfabetizadas + min.cant_per_alfabetizadas;
			regm.total_encuestados:= regm.cant_per_alfabetizadas + min.cant_per_encuestados;
			minimo(det1,det2,rDet1,rDet2,min);
		end;
		seek (mae, filepos(mae)-1);
		write(mae, regm);
	end;
end.
