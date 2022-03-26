{
3. Realizar un programa que presente un menú con opciones para:
a. Crear un archivo de registros no ordenados de empleados y completarlo con
datos ingresados desde teclado. De cada empleado se registra: número de
empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.

b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario una
única vez.
}

program p1ej3fod;

type 
	cad15=String[15];
	rEmpleado = record
		nEmple:integer;
		ape:cad15;
		nom:cad15;
		edad:integer;
		dni:string[8];
	end;
	archEmple=file of rEmpleado;
	

procedure cargarArchivo (var archLogEmple:archEmple);
	procedure leerEmpleado(var r:rEmpleado);
	begin
		writeln('ape: '); 
		readln(r.ape);
		if (r.ape<>'fin')then begin	
			writeln('nEmple: '); 
			readln(r.nEmple);
			writeln('nom: '); 
			readln(r.nom);
			writeln('edad: '); 
			readln(r.edad);
			writeln('dni: '); 
			readln(r.dni);
		end;
	end;
var
	archFisEm:string;
	r:rEmpleado;
begin
	writeln('ingre nom archivo: ');
	readln(archFisEm);
	assign (archLogEmple,archFisEm);
	rewrite(archLogEmple);
	leerEmpleado(r);
	while (r.ape<>'fin') do begin
		write(archLogEmple,r);
		leerEmpleado(r);
	end;
	close(archLogEmple);
end;


{
b. Abrir el archivo anteriormente generado y
i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.
ii. Listar en pantalla los empleados de a uno por línea.
iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.
}
procedure imprimirDatosReg(r:rEmpleado);
begin
	writeln('nom: ',r.nom);
	writeln('ape: ',r.ape);
	writeln('nEmple: ',r.nEmple);
	writeln('edad: ',r.edad);
	writeln('dni: ',r.dni);
end;
{
* i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
determinado.}
procedure listarDatosNomApeDeterminado (var archLogEmple:archEmple);
var
	nom,ape:cad15;
	r:rEmpleado;
begin
	writeln('nom determinado: ');
	readln(nom);
	writeln('ape determinado: ');
	readln(ape);
	reset(archLogEmple);//abro para lec/escr.
	while not eof (archLogEmple) do begin
		read(archLogEmple,r);//obtengo un elemento y avanzo en el archivo.
		if (r.nom=nom) or (r.ape=ape) then begin //a
			writeln('datos empleado que cumple con nombre o apellido: ');
			imprimirDatosReg(r);//a
		end;
	end;
	close(archLogEmple);
end;

{ii. Listar en pantalla los empleados de a uno por línea.}
procedure listarDatosEmpleados (var archLogEmple:archEmple);
var
	r:rEmpleado;
begin
	reset(archLogEmple);
	while not eof (archLogEmple) do begin
		read(archLogEmple,r);
		imprimirDatosReg(r);
		writeln('------------');	
	end;
	close (archLogEmple);
end;

{iii. Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.}
procedure listarDatosEmpleadosMas70 (var archLogEmple:archEmple);
var
	r:rEmpleado;
begin
	reset(archLogEmple);
	writeln('empleados mayores a 70: ');
	while not eof (archLogEmple) do begin
		read(archLogEmple,r);
		if (r.edad>70)then 
			imprimirDatosReg(r);			
	end;
	close (archLogEmple);
end;

procedure opcionesModificar(var y:integer);
begin
	
	writeln ('Numero 1 para listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.');
	writeln('Numero 2 para listar en pantalla los empleados de a uno por linea. ');
	writeln('Numero 3 para listar en pantalla empleados mayores de 70 años, próximos a jubilarse.');
	writeln('Numero 0 para cerrar ');
	readln(y);
end;

var 	
	x,y:integeR;//se va a usar para el case.
	archLogEmple:archEmple;
begin	
	repeat
		writeln ('Numero 1 para crear archivo.')  ;
		writeln('Numero 2 para abrir el archivo anteriormente generado.');
		writeln('Numero 0 para terminar la operacion.');
		readln(x);
		case x of 
			1: cargarArchivo(archLogEmple);
			2: 
			begin
					opcionesModificar(y);
					case y of
						1: listarDatosNomApeDeterminado(archLogEmple);
						2:	listarDatosEmpleados(archLogEmple);
						3: listarDatosEmpleadosMas70(archLogEmple);
					end;
			end;
		end;
	until (x=0)
end.	
	

	


