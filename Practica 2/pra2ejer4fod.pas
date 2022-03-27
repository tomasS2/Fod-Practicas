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


como dice "genere un archivo maestro" asumo que es un merge 
}
program p2ej3fod;


type
	rFecha=record
		dia:1..31;
		mes:1..12;
		ano:2000..2022;
	end;
	rInfoDetalle=record
		cod_usuario:integer;
		fecha:rFecha;
		tiempo_sesion:integer;
	end;
	
	rInfoMaestro=record
		cod_usuario:integer;
		fecha:rFecha;
		tiempo_tot_sesiones:integer;
	end;
	
