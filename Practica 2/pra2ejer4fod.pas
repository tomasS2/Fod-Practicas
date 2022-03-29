{4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
tiempo_total_de_sesiones_abiertas.
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo dia en la misma o en diferentes
máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.


}
program p2ej4fod;
const
	VALOR_ALTO=9999;

type
{
	rFecha=record
		dia:1..31;
		mes:1..12;
		ano:2000..2022;
	end;
}
	rInfoDetalle=record
		cod_usuario:integer;
		fecha:string;
		tiempo_sesion:integer;
	end;
	
	archMaestro=file of rInfoDetalle;//misma estructura q el detalle.
	archDetalle=file of rInfoDetalle;
	
	
	aDetalles=array[1..5]of archDetalle;
	aInfoDetalles=array[1..5]of rInfoDetalle;
	
	
	

procedure generarArchMaestro(var mae:archMaestro; var aDet:aDetalles);
	procedure leerDetalle(var det: archDetalle; var rInfoDet:rInfoDetalle);
	begin
		if not eof (det) then
			read(det,rInfoDet)
		else
			rInfoDet.cod_usuario:=VALOR_ALTO;
	end;

	procedure minimo (var aDet: aDetalles; var min:rInfoDetalle ;var aInfoDet:aInfoDetalles );
	var
		i,minCod,indiMin:integer;
	begin
		minCod:=9999;
		for i:=1 to 5 do begin
			if (aInfoDet[i].cod_usuario<minCod)then begin
				minCod:=aInfoDet[i].cod_usuario;
				indiMin:=i;
			end;
		end;
		min:=aInfoDet[indiMin];
		leerDetalle(aDet[indiMin],aInfoDet[indiMin]);
	end;
	

var
	aInfoDet:aInfoDetalles;
	min:rInfoDetalle;
	regm:rInfoDetalle;//mae y det comparten reg de informacion.
	i:integer;
begin
	assign(mae,'archivoMaestroEj4Pr2');
	rewrite(mae);
	
	for i:=1 to 5 do begin
		assign(aDet[i],'archivoMaestroEj4Pr2_'+Chr(i+48));	
		reset(aDet[i]);
		leerDetalle(aDet[i],aInfoDet[i]);
	end;
	minimo(aDet,min,aInfoDet);
	while (min.cod_usuario<>VALOR_ALTO)do begin
		regm.cod_usuario:=min.cod_usuario;
		regm.tiempo_sesion:=0;
		while (regm.cod_usuario=min.cod_usuario)do begin
			regm.fecha:=min.fecha;
			while(regm.cod_usuario=min.cod_usuario) and  (regm.fecha=min.fecha)do begin
				regm.tiempo_sesion:=regm.tiempo_sesion+min.tiempo_sesion;
				minimo(aDet,min,aInfoDet);
			end;
		end;
		write(mae,regm);//en el campo fecha va a quedar la ultima que se ingresó.
	end;
	close(mae);
	for i:=1 to 5 do 
		close(aDet[i]);	
end;

var
	mae:archMaestro;
	aDet:aDetalles;
begin
	generarArchMaestro(mae,aDet);
end.
	
