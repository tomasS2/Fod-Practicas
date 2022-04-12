{
14. Una compañía aérea dispone de un archivo maestro donde guarda información sobre
sus próximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida
y la cantidad de asientos disponibles. La empresa recibe todos los días dos archivos detalles
para actualizar el archivo maestro. En dichos archivos se tiene destino, fecha, hora de salida
y cantidad de asientos comprados. Se sabe que los archivos están ordenados por destino
más fecha y hora de salida, y que en los detalles pueden venir 0, 1 ó más registros por cada
uno del maestro. Se pide realizar los módulos necesarios para:
	
	c. Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje
	sin asiento disponible.
	d. Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que
	tengan menos de una cantidad específica de asientos disponibles. La misma debe
	ser ingresada por teclado.
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.
}
program p2ej14fod;
const
	VALOR_ALTO = 'ZZZZ';
type
	cad20 = string[20];
	//cad8 = string[8];

	rFecha = record
		dia : integeR;
		mes : integeR;
		ano : integeR;
	end;

	rInfoMaestro = record
		destino : cad20;
		fecha : rFecha;
		hora_salida: integer;
		cant_asientos_disponibles: integer;
	end;
	
	rInfoDetalle = record
		destino : cad20;
		fecha : rFecha;
		hora_salida: integer;
		cant_asientos_comprados: integer;
	end;
	
	rInfoLista = record
		destino : cad20;
		fecha : rFecha;
		hora_salida : integer;
	end;
	
	lista = ^nodo;
	nodo = record
		datos:rInfoLista;
		sig:lista;
	end;
	
	fileMaestro = file of rInfoMaestro;
	fileDetalle = file of rInfoDetalle;
	
	arr_det = array [1..2] of fileDetalle;
	arr_info_det = array [1..2] of rInfoDetalle;
	
	
	
procedure actualizarYcrearLista (var mae:fileMaestro;var aDet: arr_det; var l:lista; cant_espe:integer); 

	procedure agrAdelante (var l:lista; r:rInfoLista);
	var
		nue:lista;
	begin
		new(nue);
		nue^.datos:=r;
		nue^.sig:=l;
		l:=nue;
	end;
	
	
	procedure leerDetalle (var det:fileDetalle; var rInfo: rInfoDetalle);
	begin
		if not eof (mae) then
			read(det,rInfo)
		else
			rInfo.destino:=VALOR_ALTO;
	end;

	{
	procedure minimo (var d1,d2: fileDetalle; var  rDet1,rDet2: rInfoDetalle; var min: rInfoDetalle);
	begin
		if (d1.destino <= d2.destino) then  begin
			if (d1.fecha <= d2.fecha) then  begin
				if (d1.hora_salida <= d2.hora_salida) then  begin
					min:=d1;
					leer(d1,rDet1);
		end
		else
			min:=d2;
			leer(d2,rDet2);
	end;
	}

	procedure minimo (var aInfoDet:arr_info_det; var min:rInfoDetalle ;var aDet:arr_det);
	var
		i,indiMin:integer;
	begin
		min.destino:=VALOR_ALTO;
		min.fecha.dia:=9999;
		min.fecha.mes:=9999;
		min.hora_salida:=9999;
		min.fecha.ano:=9999;
		for i:=1 to 2 do begin
			if (aInfoDet[i].destino<min.destino)and (aInfoDet[i].fecha.ano<min.fecha.ano) and (aInfoDet[i].fecha.dia<min.fecha.dia) and (aInfoDet[i].fecha.mes<min.fecha.mes)and(aInfoDet[i].hora_salida<min.hora_salida) then begin
				min:=aInfoDet[i];
				indiMin:=i;
			end;
		end;
		min:=aInfoDet[indiMin];
		leerDetalle(aDet[indiMin],aInfoDet[indiMin]);
	end;		

var
	i:integer;
	rInfLista: rInfoLista;
	aInfoDet: arr_info_det;
	min : rInfoDetalle;
	regm : rInfoMaestro;
begin

	for i:=1 to 2 do begin	
		assign(aDet[i],'archDetalle'+Chr(i+48));
		reset(aDet[i]);
		leerDetalle(aDet[i],aInfoDet[i]);
	end;
	
	
	minimo(aInfoDet,min,aDet);
	while (min.destino <> VALOR_ALTO) do begin
		read (mae, regm) ;
		while (min.destino <> regm.destino) do begin
			if (regm.cant_asientos_disponibles<cant_espe) then begin
				rInfLista.destino:= regm.destino;
				rInfLista.fecha:= regm.fecha;
				rInfLista.hora_salida:= regm.hora_salida;
				agrAdelante(l,rInfLista);
			end;
			read (mae, regm) ;
		end;
		while (min.destino = regm.destino) and (min.fecha.ano = regm.fecha.ano) and  (min.fecha.mes = regm.fecha.mes) and  (min.fecha.dia = regm.fecha.dia)and (min.hora_salida = regm.hora_salida)do begin 
			regm.cant_asientos_disponibles:= regm.cant_asientos_disponibles - min.cant_asientos_comprados;
			minimo(aInfoDet,min,aDet);
		end;
		if (regm.cant_asientos_disponibles<cant_espe) then begin
			rInfLista.destino:= regm.destino;
			rInfLista.fecha:= regm.fecha;
			rInfLista.hora_salida:= regm.hora_salida;
			agrAdelante(l,rInfLista);
		end;
		seek(mae, filepos(mae)-1);
		write(mae, regm);
	end;
	for i:=1 to 2 do
		close(aDet[i]);
	close(mae);
end;
	

var
	cant_espe,i:integer;
	mae: fileMaestro;
	aDet: arr_det;
	l:lista;
begin
	read(cant_espe);
	l:=nil;
	assign(mae, 'maestro');
	for i:=1 to 2 do 
		assign(aDet[i],'archDetalle'+Chr(i+48));
	actualizarYcrearLista(mae,aDet,l,cant_espe);
end.








	
	
