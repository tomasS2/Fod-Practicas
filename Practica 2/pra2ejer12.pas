{
 12. La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio de
la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se
realizan al sitio.
La información que se almacena en el archivo es la siguiente: año, mes, dia, idUsuario y
tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado por los
siguientes criterios: año, mes, dia e idUsuario.
Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará
el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato
mostrado a continuación:
   
  Año : ---
	Mes:-- 1
		día:-- 1
		    idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
		    --------
		    idusuario N Tiempo total de acceso en el dia 1 mes 1
	    Tiempo total acceso dia 1 mes 1
	-------------
	día N
			idUsuario 1 Tiempo Total de acceso en el dia N mes 1
			--------
			idusuario N Tiempo total de acceso en el dia N mes 1
		Tiempo total acceso dia N mes 1
	Total tiempo de acceso mes 1
	------
	Mes 12
	día 1
			idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
			--------
			idusuario N Tiempo total de acceso en el dia 1 mes 12
		Tiempo total acceso dia 1 mes 12
	-------------
	día N
				idUsuario 1 Tiempo Total de acceso en el dia N mes 12
				--------
				idusuario N Tiempo total de acceso en el dia N mes 12
			Tiempo total acceso dia N mes 12
		Total tiempo de acceso mes 12
	Total tiempo de acceso año



Se deberá tener en cuenta las siguientes aclaraciones:
- El año sobre el cual realizará el informe de accesos debe leerse desde teclado.
- El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año
no encontrado”.
- Debe definir las estructuras de datos necesarias.
- El recorrido del archivo debe realizarse una única vez procesando sólo la información
necesaria.
}

program p2ej12fod;
const
	VALOR_ALTO = 9999;
type
	rAcceso = record
		ano:integer;
		mes:integer;
		dia:integer;
		id:integer;
		tiemp_acceso:integer;
	end;
	
	fileAccesos = file of rAcceso;
	
	
procedure informarArchivo (var mae: fileAccesos; anoBuscar: integer);

	procedure leer(var mae: fileAccesos; var rInfo: rAcceso);
	begin
		if not eof (mae) then
			read(mae, rInfo)
		else
			rInfo.ano:= VALOR_ALTO;
	end;

var
	mes_act,dia_act,id_act,tiemp_acceso_dia,tiemp_acceso_mes,tiemp_acceso_ano:integer;
	regm: rAcceso;
begin
	
	reset(mae);
	leer(mae,regm);

	while (regm.ano <> VALOR_ALTO) and (regm.ano <> anoBuscar) do 
			leer(mae,regm);
		while (regm.ano <> VALOR_ALTO) do begin
			tiemp_acceso_ano:=0;
			while (regm.ano = anoBuscar) do begin
				writeln(anoBuscar);
				mes_act:= regm.mes;
				tiemp_acceso_mes:=0;
				
				while (mes_act = regm.mes)and (regm.ano = anoBuscar) do begin
					writeln(mes_act);
					dia_act:= regm.dia;
					tiemp_acceso_dia:=0;
					
					while (dia_act = regm.dia)and (mes_act = regm.mes)and (regm.ano = anoBuscar)  do begin
						writeln(dia_act);
						id_act:= regm.id;
						
						while (id_act = regm.id)and(dia_act = regm.dia)and (mes_act = regm.mes)and (regm.ano = anoBuscar)  do begin
							write(id_act);
							tiemp_acceso_dia:=tiemp_acceso_dia+ regm.tiemp_acceso;
							leer(mae, regm);
						end;//dia_id = regm.id
						
					end;//dia_act = regm.dia
					writeln(tiemp_acceso_dia);
					tiemp_acceso_mes := tiemp_acceso_mes + tiemp_acceso_dia;
				end;//mes_act = regm.mes
				tiemp_acceso_ano:= tiemp_acceso_ano + tiemp_acceso_mes;
				writeln(tiemp_acceso_mes);
			end;//regm.ano = anoBuscar
			writeln(tiemp_acceso_ano);
		end;//regm.ano <> VALOR_ALTO
		if (regm.ano = VALOR_ALTO)then
			writeln('anio no encontrado');
		close(mae);
end;

var
	accesos : fileAccesos;
	ano : integer;
BEGIN
	assign(accesos, 'archivo_accesos');
	write('Ingrese el ano ');
	read(ano);
	informarArchivo(accesos, ano);
	
	
	
END.


	
