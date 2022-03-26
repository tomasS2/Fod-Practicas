{
7. Realizar un programa que permita:
a. Crear un archivo binario a partir de la información almacenada en un archivo de texto.
El nombre del archivo de texto es: “novelas.txt”
b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
una novela y modificar una existente. Las búsquedas se realizan por código de novela.
NOTA: La información en el archivo de texto consiste en: código de novela,
nombre,género y precio de diferentes novelas argentinas. De cada novela se almacena la
información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente
información: código novela, precio, y género, y la segunda línea almacenará el nombre
de la novela.
}
program p1ej7fod;
type
	rInfoArchivo=record
		codNovela:integer;
		genero:String;
		nombre:String;
		precio:Real;
	end;
	
	fileBinario=file of rInfoArchivo;
	
	
procedure crearArchivo(var archBinario:fileBinario);
var
	txtNov:text;
	rNov:rInfoArchivo;
	nomArc:string;
begin	
	writeln('Nom archivo: ');
	read(nomArc);
	assign(archBinario,nomArc);
	rewrite(archBinario);
	assign(txtNov,'novelas.txt');
	reset(txtNov);
	while not eof (txtNov) do begin
		readln(txtNov,rNov.codNovela,rNov.precio,rNov.genero);
		readln(txtNov,rNov.nombre);
		write(archBinario,rNov);
	end;
	close(archBinario);
	close(txtNov);
end;
	
	
	
procedure agregarUnaNovela(var archBinario:fileBinario);
	procedure leerNovela(var r:rInfoArchivo);
	begin
		writeln('codNovela');
		readln(r.codNovela);
		writeln('genero');
		readln(r.genero);
		writeln('nombre');
		readln(r.nombre);
		writeln('precio');
		readln(r.precio);
	end;
	
var
	rNov:rInfoArchivo;
begin
	reset (archBinario);
	seek(archBinario,filesize(archBinario));
	leerNovela(rNov);
	write(archBinario,rNov);
	close(archBinario);
	end;
	
procedure modifNovela(var archBinario:fileBinario);


	procedure modificarInfoNovela(var r:rInfoArchivo);
	var
		x:integer;		
	begin
		repeat
			writeln('1. modificar nombre de la novela ');
			writeln('2. modificar genero de la novela ');
			writeln('3. modificar codigo de la novela ');
			writeln('4. modificar precio de la novela ');
			writeln('0. fin de modificacion ');
			readln(x);
			case x of
				1: 
				begin
					writeln('Nom novela nuevo');
					read(r.nombre);
				end;
				2: 
				begin
					writeln('Nom genero nuevo');
					read(r.genero);
				end;
				3: 
				begin
					writeln('num codigo nuevo');
					read(r.codNovela);
				end;
				4: 
				begin
					writeln('precio nuevo');
					read(r.precio);
				end;
			end;
		until (x=0)
	end;
	
var
	rNov,rAux:rInfoArchivo;
	codNov:integer;
begin
	writeln('ingrese el cod de la novela que quiere modificar: ');
	readln(codNov);
	reset (archBinario);
	while not eof (archBinario)do begin
		read(archBinario,rNov);
		if (rNov.codNovela=codNov)then begin
			modificarInfoNovela(rAux);
			seek(archBinario,filePos(archBinario)-1);
			rNov:=rAux;
			write(archBinario,rNov);
		end;
	end;
end;
	
var
	x,y:integer;
	archBinario:fileBinario;
begin
	repeat
		writeln('1. Crear un archivo binario a partir de la información almacenada en un archivo de texto.');
		writeln('2. Abrir el archivo binario y permitir la actualización del mismo.');
		readln(x);
		case x of
			1: crearArchivo(archBinario);
			2:begin
				writeln('1. Agregar una novela');
				writeln('2. Modificar una novela existente');
				readln(y);
				case y of
					1: agregarUnaNovela(archBinario);
					2: modifNovela(archBinario);
				end;
			end;
		end;
	until (x=0)
end.
		
	
	




	
	
	
	
	

