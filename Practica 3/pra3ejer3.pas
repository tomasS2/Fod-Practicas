{
3. Realizar un programa que genere un archivo de novelas filmadas durante el presente
año. De cada novela se registra: código, género, nombre, duración, director y precio.
El programa debe presentar un menú con las siguientes opciones:
	a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
	utiliza la técnica de lista invertida para recuperar espacio libre en el
	archivo. Para ello, durante la creación del archivo, en el primer registro del
	mismo se debe almacenar la cabecera de la lista. Es decir un registro
	ficticio, inicializando con el valor cero (0) el campo correspondiente al
	código de novela, el cual indica que no hay espacio libre dentro del
	archivo.


	b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
	inciso a., se utiliza lista invertida para recuperación de espacio. En
	particular, para el campo de ´enlace´ de la lista, se debe especificar los
	números de registro referenciados con signo negativo, (utilice el código de
	novela como enlace).Una vez abierto el archivo, brindar operaciones para: 

	
		i. Dar de alta una novela leyendo la información desde teclado. Para
		esta operación, en caso de ser posible, deberá recuperarse el
		espacio libre. Es decir, si en el campo correspondiente al código de
		novela del registro cabecera hay un valor negativo, por ejemplo -5,
		se debe leer el registro en la posición 5, copiarlo en la posición 0
		(actualizar la lista de espacio libre) y grabar el nuevo registro en la
		posición 5. Con el valor 0 (cero) en el registro cabecera se indica
		que no hay espacio libre.
		
		ii. Modificar los datos de una novela leyendo la información desde
		teclado. El código de novela no puede ser modificado.
		
		iii. Eliminar una novela cuyo código es ingresado por teclado. Por
		ejemplo, si se da de baja un registro en la posición 8, en el campo
		código de novela del registro cabecera deberá figurar -8, y en el
		registro en la posición 8 debe copiarse el antiguo registro cabecera.
	
	
	 c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
		representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.

NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario.
		
 }
program ej3P3;
type
	cadena = string[20];
	novela = record
		cod : integer;
		gen : cadena;
		nom : cadena;
		director : cadena;
		duracion : integer;
		precio : real;
		
	end;
	
	archivo = file of novela;
	
procedure leerReg (var r: novela);
begin
	read(r.cod);
	if(r.cod <>-1)then begin
		read(r.nom);
		read(r.gen);
		read(r.director);
		read(r.duracion);
		read(r.precio);
	end;		
end;

procedure crearArch(var a: archivo);	

var	
	arch: archivo;
	nomArch: string[15];
	nov: novela;
begin
	writeln('nom archivo');
	read(nomArch);
	assign (arch,nomArch);
	rewrite(arch);
	writeln('ingre num');
	nov.cod := 0;
	while (nov.cod<>-1)do begin
		write(arch, nov); 
		leerReg(nov);
	end;
	close(arch);
end;

procedure mantenimiento(var arch: archivo);
	procedure darAltaNovela(var arch: archivo);
	var
		nov, cabecera: novela;
	begin
		reset(arch);
		leerReg(nov);
		if not eof (arch) then
			read(arch, cabecera);//leo el primer reg para saber si hay algun espacio libre
		if (cabecera.cod = 0) then begin
			seek(arch, filesize(arch));
			write(arch,nov);
		end
		else begin
			seek (arch, (cabecera.cod * -1));//me muevo a la pos libre
			read(arch,cabecera);
			seek (arch, filepos(arch)-1);
			write(arch,nov);
			seek (arch, 0);
			write(arch, cabecera);
		end;
		close(arch);
	end;

	
	procedure modifNovela(var arch: archivo);
	var
		
		x,cod: integer;
		nov: novela;
		encontre: boolean;
	begin
		encontre:= false;
		read(cod);
		reset (arch);
		read(arch,nov);
		while not eof (arch) and (not encontre)do begin
			read(arch, nov);
			if (nov.cod = cod)then begin
				encontre:= true;
				read(x);
				repeat 
					writeln('1. modif nombre');
					writeln('2. modif genero');
					writeln('3. modif director');
					writeln('4. modif duracion');
					writeln('5. modif precio');
					writeln('0. salir');
					case x of
						1:read(nov.nom);
						2:read(nov.gen);
						3:read(nov.director);
						4:read(nov.duracion);
						5:read(nov.precio);
					end;
				until (x = 0);
				seek (arch, filePos(arch)-1);
				write(arch,nov);
			end;
		end;
		close(arch)
	end;
			
	procedure eliminarNov (var arch:archivo);
	var
		encontre: boolean;
		aux,indice:novela;
		codBorr:integer;
	begin
		reset(arch);
		encontre:= false;
		read(codBorr);
		if not eof then 
			read(arch,indice);
		
		
		while not eof (arch) and (not encontre)do begin
			read(arch, aux);
			if (aux.cod = codBorr)then begin //si encuentro el codigo
				encontre:= true;
				aux.cod:=indice.cod;
				seek(arch, filePos(arch)-1);
				indice.cod := filePos(arch) * -1;
				write(arch,aux);
				seek(arch , 0);
				write(arch,indice);
				
{
				posBorrar:= filePos(arch)-1;
				if (aux.cod = 0) then begin //si no hay reg borrados
					seek(arch, 0);
					aux2.cod:= posBorrar * -1;
					write(arch, aux2);//escribo en la pos 0, la posicion de donde va a estar el lugar vacío.
					seek(arch, posBorrar);
					aux2.cod := 0;
					write(arch,aux2);//escribo el '0' en la nueva pos borrada.
				end
				else begin//si ya hay lugar ocupados
					seek(arch, posBorrar);
					write(arch, aux);
					seek(arch, 0);
					aux.cod:= posBorrar*-1;
					write(arch, aux);
				end;
}
				
				
			end;
		end;
		close(arch);
	end;

var
	n: integer;
begin
	repeat
		writeln('1. Dar de alta una novela leyendo la información desde teclado');
		writeln('2.  Modificar los datos de una novela leyendo la información desde teclado. El código de novela no puede ser modificado');
		writeln('3. Eliminar una novela cuyo código es ingresado por teclado.');
		writeln('0. Salir.');
		read(n);
		case n of
			1: darAltaNovela(arch);
			2:	modifNovela(arch);
			3:	eliminarNov(arch);
		end;
	until(n = 0)

end;

procedure listarEnTxt (var arch: archivo);
var
	txt: text;
	nov: novela;
begin
	reset(arch);
	rewrite(txt);
	assign(txt,'novelas.txt');
	while not eof (arch) do begin
		read(arch, nov);
		writeln(txt, nov.nom);
		writeln(txt, nov.gen);
		writeln(txt, nov.director);
		write(txt, nov.cod, nov.duracion, nov.precio);
	end;
	close(txt);
	close(arch);
end;

var
	arch:archivo;
begin
	assign(arch, 'archivo');
	crearArch(arch);
	mantenimiento(arch);
	listarEnTxt(arch);
	
end.

