{
10. Se tiene información en un archivo de las horas extras realizadas por los empleados de
una empresa en un mes. Para cada empleado se tiene la siguiente información:
departamento, división, número de empleado, categoría y cantidad de horas extras
realizadas por el empleado. Se sabe que el archivo se encuentra ordenado por
departamento, luego por división, y por último, por número de empleados. Presentar en
pantalla un listado con el siguiente formato:

Departamento

División

Número de Empleado 			Total de Hs.			 Importe a cobrar
		...... 										..........							 .........
		...... 										.......... 							.........
Total de horas división: ____
Monto total por división: ____

División
.................


Total horas departamento: ____
Monto total departamento: ____


Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al
iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía
de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número
de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la
posición del valor coincidente con el número de categoría.
}


program p2ej10fod;
const
	VALOR_ALTO = 9999;
type
	rEmpleadoInfo = record
		departamento: integer;
		division:integeR;
		nro_emple:integer;
		cat:integer;
		cant_hora_extra:integer;
	end;
	
	fileEmpleadoInfo = file of rEmpleadoInfo;	
	arr_horas = array [1..15]of real;

procedure leer (var mae:fileEmpleadoInfo; var rInfo: rEmpleadoInfo);
begin
	if not eof (mae) then
		read(mae,rInfo)
	else
		rInfo.departamento:=VALOR_ALTO;
end;


var
	mae: fileEmpleadoInfo;
	a: arr_horas;
	arch_horas: text;
	rInfoEmple:rEmpleadoInfo;
	monto_tot_division,monto_tot_departamento,monto_emple:real;
	depart_actual,division_actual,nro_emple_actual,tot_horas_division,tot_horas_departamento,i:integer;
begin
	assign(mae,'maestro');
	assign(arch_horas,'arc_horas');
	reset(mae);
	reset(arch_horas);
	i:=1;
	while not eof (arch_horas) do begin
		read(arch_horas, a[i]);
		i:= i +1;
	end;
	leer(mae, rInfoEmple);
	while (rInfoEmple.departamento <> VALOR_ALTO) do begin	
		depart_actual := rInfoEmple.departamento;
		writeln(depart_actual);
		tot_horas_departamento:=0;
		monto_tot_departamento:=0;
		while (depart_actual = rInfoEmple.departamento)do begin
			division_actual := rInfoEmple.division;
			writeln(division_actual);
			monto_tot_division:=0;
			tot_horas_division:=0;
			while (division_actual = rInfoEmple.division)do begin
				nro_emple_actual := rInfoEmple.nro_emple;
				write(nro_emple_actual);
				while (nro_emple_actual = rInfoEmple.nro_emple)do begin
					write(rInfoEmple.cant_hora_extra);
					monto_emple:=a[rInfoEmple.cat ]* rInfoEmple.cant_hora_extra;
					write(monto_emple);
					leer(mae, rInfoEmple);
				end;//end del nro_emple.
				tot_horas_division := tot_horas_division + rInfoEmple.cant_hora_extra;
				monto_tot_division:= monto_emple + monto_tot_division;
			end;//end de la division.
			tot_horas_departamento := tot_horas_departamento + tot_horas_division;
			monto_tot_departamento:= monto_tot_departamento + monto_tot_division;
			writeln(tot_horas_division);
			writeln(monto_tot_division);
		end;//end del departamento.
		writeln(tot_horas_departamento);
		writeln(monto_tot_departamento);
	end;
end.
			
 					
		
		












	

