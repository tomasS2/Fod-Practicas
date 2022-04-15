program p3ej1fod;

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
procedure cargarArchivo (var archLogEmple:archEmple);

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

procedure anadirUnoOMasEmpleados(var archLogEmple:archEmple);
var
	r:rEmpleado;
begin	
	reset(archLogEmple);
	seek(archLogEmple,filesize(archLogEmple));//me paro al final para poder seguir agregando a la izq.
	leerEmpleado(r);
	while (r.ape<>'fin')do begin
		write(archLogEmple,r);
		leerEmpleado(r);
	end;
	close(archLogEmple);
end;






procedure modificarEdad(var archLogEmple:archEmple);
	procedure cambiarEdad (var edad:integer);
	begin
		writeln('ingrese numero que para poner como edad: ');
		readln(edad);
	end;

	procedure menuSeguir (var seguir:boolean);
	var
		x:char;
	begin
		writeln ('Modificar edad de otro empleado? (digite "s" o "n")');//ingre "s" para si; "n" para no.
		readln(x);
		case x of
			's' :seguir:=true;
			'n' :seguir:=false;
		end;
	end;
	procedure menuEdad (var x:integer);
	begin
		writeln('Numero de empleado al que le quiere modificar la edad: ');
		readln(x);
	end;
var
	encontre,seguir:boolean;
	r:rEmpleado;
	x,n:integer;
begin
	seguir:=true;
	reset(archLogEmple);
	while (seguir)do begin
		encontre:=false;
		menuEdad(x);
		while not eof (archLogEmple) and (not encontre)do begin
			read(archLogEmple,r);
			if (r.nEmple=x)then begin
				cambiarEdad(n);
				r.edad:=n;
				encontre:=true;
				seek(archLogEmple,filePos(archLogEmple)-1);
				write(archLogEmple,r);
			end;
		end;
		menuSeguir (seguir);
		if (seguir)then	
		    seek (archLogEmple,0);
	end;
	close(archLogEmple);
end;



procedure exportarContenido(var archLogEmple:archEmple);
var
	rEmpl:rEmpleado;
	archivoTextoEmpleados:text;
begin	
	reset(archLogEmple);
	assign(archivoTextoEmpleados,'todos_empleados');
	rewrite(archivoTextoEmpleados);
	while not eof(archLogEmple) do begin
		read(archLogEmple,rEmpl );
		write(archivoTextoEmpleados,'Apellido: '+ rEmpl.ape + ' Nombre: '+ rEmpl.nom+ ' Numero de empleado: ', rEmpl.nEmple ,' Edad: ',rEmpl.edad,' Dni: '+ rEmpl.dni);
	
	end;
	close(archLogEmple);
	close(archivoTextoEmpleados);
end;

procedure exportarContenidoEmpleSinDni (var archLogEmple:archEmple);
var
	archiNoDni:text;
	rEmpl:rEmpleado;
begin
	reset(archLogEmple);
	assign(archiNoDni,'faltaDNIEmpleado.txt');
	rewrite(archiNoDni);
	while not eof(archLogEmple)do begin
		read (archLogEmple,rEmpl);
		if (rEmpl.dni = '00')then
			write(archiNoDni,'Apellido: '+ rEmpl.ape + ' Nombre: '+ rEmpl.nom+ ' Numero de empleado: ', rEmpl.nEmple ,' Edad: ',rEmpl.edad,' Dni: '+ rEmpl.dni);
	end;
	close(archLogEmple);
	close(archiNoDni);
end;
procedure mostrarMenu(var y:integer);
begin
	writeln('Ingresar: ');
	writeln('Numero 1 para listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.');
	writeln('Numero 2 para listar en pantalla los empleados de a uno por linea.');
	writeln('Numero 3 para listar en pantalla empleados mayores de 70 años, próximos a jubilarse.');
	writeln('Numero 4 para añadir uno o más empleados al final del archivo con sus datos ingresados por teclado');
	writeln('Numero 5 para modificar edad a una o más empleados.');
	writeln('Numero 6 para exportar el contenido del archivo a un archivo de texto llamado: todos_empleados.txt.');
	writeln('Numero 7 para exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados que no tengan cargado el DNI (DNI en 00).');
	writeln('Numero 0 para cerrar ');
	readln(y);
end;

procedure bajarArchivo (var mae: archEmple; cod_borrar: integer);
var
	n:integer;
	regm,aux:rEmpleado;
	encontre: boolean;
begin
	encontre:= false;
	reset (mae);
	while not eof (mae) and (not encontre) do begin
		read(mae, regm);
		if (regm.nEmple = cod_borrar) then begin
			n:= filepos(mae)-1;
			if (n <> filesize(mae)-1) then begin
				seek (mae,filesize(mae)-1);
				read(mae,aux);			
				seek(mae, n);
				write(mae, aux);	
			end
			seek (mae,filesize(mae)-1);
			truncate(mae);
			
		end;	
	end;		
	
end;


var 
	x,y,cod_borrar:integeR;//se va a usar para el case.
	archLogEmple:archEmple;

begin	
	repeat
		cod_borrar:= 2;
		writeln ('Numero 1 para crear archivo.') ;
		writeln('Numero 2 para abrir el archivo anteriormente generado.');
		writeln('Numero 0 para terminar la operacion.');
		readln(x);
		case x of 
			1: cargarArchivo(archLogEmple);
			2:
		    begin
				mostrarMenu(y);
				case y of	
					1: listarDatosNomApeDeterminado(archLogEmple);
					2:	listarDatosEmpleados(archLogEmple);
					3: listarDatosEmpleadosMas70(archLogEmple);
					4: anadirUnoOMasEmpleados(archLogEmple);
					5: modificarEdad(archLogEmple);
					6: exportarContenido(archLogEmple);
					7: exportarContenidoEmpleSinDni(archLogEmple);
					8: bajarArchivo(archLogEmple, cod_borrar);
				end;
			end;
		end;
	until (x=0)
end.
	
