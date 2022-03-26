{
2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
un archivo detalle con el código de alumno e información correspondiente a una materia
(esta información indica si aprobó la cursada o aprobó el final).
Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
programa con opciones para:

a. Crear el archivo maestro a partir de un archivo de texto llamado “alumnos.txt”.
b. Crear el archivo detalle a partir de en un archivo de texto llamado “detalle.txt”.
c. Listar el contenido del archivo maestro en un archivo de texto llamado
“reporteAlumnos.txt”.
d. Listar el contenido del archivo detalle en un archivo de texto llamado
“reporteDetalle.txt”.
e. Actualizar el archivo maestro de la siguiente manera:
	i. Si aprobó el final se incrementa en uno la cantidad de materias con final
	aprobado.
	ii. Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas
	sin final.
f. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.

NOTA: Para la actualización del inciso e) los archivos deben ser recorridos sólo una vez.
}

program p2ej2fod;
const
	VALOR_ALTO=9999;
type
	cad15=String[15];
	rAlumno=record
		codAlu:integer;
		nom:cad15;
		ape:cad15;
		cantMatAproSinFinal:integer;
		cantMatAproConFinal:integer;
	end;
	
	rInfoAlu=Record
		codAlu:integer;
		matAproSinFinal:integer;
		matAproConFinal:integer;
	end;
	
	archCarga=file of rInfoAlu;
	
	archAlumnos=file of rAlumno;

	
//a
procedure crearMaestroDesdeTxt (var mae:archAlumnos);
var
	txtAlu:text;
	nom:string;
	rAl:rAlumno;
begin
	assign (txtAlu,'alumnos.txt');
	reset(txtAlu);
	writeln('ingrese nombre del arch maestro: ');
	readln(nom);
	assign(mae,nom);
	rewrite(mae);
	while not eof (txtAlu) do begin
		read(txtAlu,rAl.codAlu, rAl.nom);
		read(txtAlu,rAl.cantMatAproConFinal, rAl.cantMatAproSinFinal, rAl.ape);
		write(mae,rAl);
	end;
	close (mae);
	close (txtAlu);
end;
	
//b
procedure crearDetalleDesdeTxt (var det:archCarga);
var
	txtDet:text;
	nom:string;
	rIa:rInfoAlu;
begin
	assign (txtDet,'detalle.txt');
	reset(txtDet);
	writeln('ingrese nombre del arch detalle: ');
	readln(nom);
	assign(det,nom);
	rewrite(det);
	while not eof (txtDet) do begin
		read(txtDet,rIa.codAlu,rIa.matAproSinFinal,rIa.matAproConFinal);
		write(det,rIa);
	end;
	close (det);
	close (txtDet);
end;
	
//c
procedure listarContMaeEnTxt (var mae:archAlumnos);
var
	rAl:rAlumno;
	txtInfoMae:text;
begin
	assign (txtInfoMae,'reporteAlumnos.txt');
	rewrite(txtInfoMae);
	reset(mae);
	while not eof (mae) do begin
		read(mae,rAl);
		writeln(txtInfoMae,rAl.codAlu, rAl.nom);
		write(txtInfoMae,rAl.cantMatAproConFinal, rAl.cantMatAproSinFinal, rAl.ape);
	end;
	close(mae);
	close(txtInfoMae);
end;
	
//d
procedure listarContDetEnTxt (var det:archCarga);
var
	rIa:rInfoAlu;
	txtInfoDet:text;
begin
	assign (txtInfoDet,'reporteDetalle.txt');
	rewrite(txtInfoDet);
	reset(det);
	while not eof (det) do begin
		read(det,rIa);
		write(txtInfoDet,rIa.codAlu,rIa.matAproSinFinal, rIa.matAproConFinal);
	end;
	close(det);
	close(txtInfoDet);
end;
	
{
e. Actualizar el archivo maestro de la siguiente manera:
	i. Si aprobó el final se incrementa en uno la cantidad de materias con final
	aprobado.
	ii. Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas
	sin final.	
}
procedure actualizarMaestroMaterias (var mae:archAlumnos;var det:archCarga);
	procedure leerDetalle (var det:archCarga; var r:rInfoAlu);
	begin
		if not eof (det)then
			read(det,r)
		else
			r.codAlu:=VALOR_ALTO;
	end;
var
	rAl:rAlumno;
	rIa:rInfoAlu;
begin
	reset(det);
	reset(mae);
	leerDetalle(det,rIa);
	while (rIa.codAlu<>VALOR_ALTO)do begin
		read(mae,rAl);
		while (rAl.codAlu<>rIa.codAlu)do 
			read(mae,rAl);	
		while (rAl.codAlu=rIa.codAlu)do begin
			if (rIa.matAproConFinal=1)then
				rAl.cantMatAproConFinal:=rAl.cantMatAproConFinal+1;
			if (rIa.matAproSinFinal=1)then
				rAl.cantMatAproSinFinal:=rAl.cantMatAproSinFinal+1;
			leerDetalle(det,rIa);
		end;
		seek(mae,filepos(mae)-1);
		write(mae,rAl);
	end;
	close(mae);
	close(det);
end;

		
procedure listarEnTxtInfoEspecifica(var mae:archAlumnos);
var
	txtInfoEspecifica:text;
	rAl:rAlumno;
begin
	assign (txtInfoEspecifica,'InfoEspecifica.txt');
	rewrite(txtInfoEspecifica);
	reset (mae);
	while not eof (mae)do begin
		read(mae,rAl);
		if ((rAl.cantMatAproSinFinal-rAl.cantMatAproConFinal)>4)then begin
			writeln(txtInfoEspecifica,rAl.codAlu, rAl.nom);
			write(txtInfoEspecifica,rAl.cantMatAproConFinal, rAl.cantMatAproSinFinal, rAl.ape);
		end;
	end;
	close (mae);
	close (txtInfoEspecifica);
end;
	
	
var
	det:archCarga;
	mae:archAlumnos;
	x:integer;
begin
	repeat 
		writeln('1. Crear el archivo maestro a partir de un archivo de texto llamado: alumnos.txt.');
		writeln('2. Crear el archivo detalle a partir de en un archivo de texto llamado: detalle.txt.');
		writeln('3. Listar el contenido del archivo maestro en un archivo de texto llamado: reporteAlumnos.txt.');
		writeln('4. Listar el contenido del archivo detalle en un archivo de texto llamado: reporteDetalle.txt.');
		writeln('5. Actualizar el archivo maestro.');
		writeln('6. Listar en un archivo de texto los alumnos que tengan más de cuatro materias con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.');
		writeln('0. Salir');
		readln(x);
		case x of 
			1: crearMaestroDesdeTxt(mae);
			2: crearDetalleDesdeTxt(det);
			3: listarContMaeEnTxt(mae);
			4: listarContDetEnTxt(det);
			5: actualizarMaestroMaterias(mae,det);
			6: listarEnTxtInfoEspecifica(mae);
		end;
	until(x=0)
end.
	





