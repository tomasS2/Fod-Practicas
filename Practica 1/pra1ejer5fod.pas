{
5. Realizar un programa para una tienda de celulares, que presente un menú con
opciones para:
a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
correspondientes a los celulares, deben contener: código de celular, el nombre,
descripcion, marca, precio, stock mínimo y el stock disponible.
b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.
d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
“celulares.txt” con todos los celulares del mismo.
* 
NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario
una única vez.
NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
tres líneas consecutivas: en la primera se especifica: código de celular, el precio y
marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
“celulares.txt”.

cuando importo los datos desde el arch  "celulares.txt" el stock minimo y el stock disponible me los guarda sin espacio entre medio (debe ser porque son 2 integer y se buguea)-

}
program p1ej5fod;
type
	rCelular=record
		cod:integer;
		nom:string;
		marca:string;
		descripcion:string;
		modelo:string;
		precio:real;
		stockMin:integer;
		stockDisp:integer;
	end;
	fileCel= file of rCelular;



{
procedure creartxt (var txt:text);
	procedure leerCel(var r:rCelular);
	begin
		writeln('cod');
		readln(r.cod);
		if (r.cod<>-1)then begin
			writeln('nom');
			readln(r.nom);
			writeln('marca');
			readln(r.marca);
			writeln('descripcion');
			readln(r.descripcion);
			writeln('modelo');
			readln(r.modelo);
			writeln('precio');
			readln(r.precio);
			writeln('stockMin');
			readln(r.stockMin);
			writeln('stockDisp');
			readln(r.stockDisp);
		end;
	end;
var
	r:rCelular;
begin
	assign (txt,'celulares.txt');
	rewrite(txt);
	leerCel(r);
	while (r.cod<>-1) do begin
		writeln(txt,r.cod,' ',r.precio,' ',r.marca);
		writeln(txt,r.stockDisp,' ',r.stockMin,' ',r.descripcion);
		writeln(txt,r.nom);
		leerCel(r);
	end;
	close(txt);
end;
}


procedure crearYCargarArchivo (var archCel: fileCel);
var
	archTextCel:text;
	nomArc:string;
	rCel:rCelular;
begin
	writeln('ingre nom archivo');
	readln(nomArc);
	assign(archCel,nomArc);
	rewrite(archCel);
	
	assign(archTextCel,'celulares.txt');
	reset(archTextCel);
	while not eof (archTextCel)do begin
		readln(archTextCel, rCel.cod, rCel.precio, rCel.marca);
		readln(archTextCel, rCel.stockDisp, rCel.stockMin, rCel.descripcion);
		readln(archTextCel, rCel.nom);
		write(archCel,rCel);
	end;
	close(archTextCel);
	close(archCel);
	
end;

{
Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
stock mínimo.
}
procedure imprimirRegCel(rCel:rCelular);
begin
	writeln(rCel.cod);
	writeln(rCel.nom);
	writeln(rCel.marca);
	writeln(rCel.descripcion);
	writeln(rCel.modelo);
	writeln(rCel.precio);
	writeln(rCel.stockMin);
	writeln(rCel.stockDisp);
end;

procedure listarMenorAlMinimo (var archCel:fileCel);
var
	rCel:rCelular;
begin
	reset(archCel);
	while not eof (archCel) do begin
		read(archCel,rCel);
		if (rCel.stockDisp<rCel.stockMin)then 
			imprimirRegCel(rCel);
	end;
	close (archCel);
end;
{c. Listar en pantalla los celulares del archivo cuya descripción contenga una
cadena de caracteres proporcionada por el usuario.}
procedure listarCoincideDescripcion (var archCel:fileCel);
var
	desc:string;
	rCel:rCelular;
begin
	writeln('ingresar descripcion: ');
	readln(desc);
	writeln('Coincidencias: ');
	reset(archCel);
	while not eof (archCel) do begin
		read(archCel,rCel);
		
		if (rCel.descripcion=desc)then 
			imprimirRegCel(rCel);
	end;
	close (archCel);
end;

procedure exportarArchivo (var archCel:fileCel);
var
	txtCel:text;
	n:string;
	rCel:rCelular;
begin
	writeln('ignre nom text');
	readln(n);
	assign(txtCel,n);
	rewrite(txtCel);
	reset (archCel);
	while not eof (archCel) do begin
		read(archCel,rCel);		
		writeln(txtCel,rCel.cod, rCel.precio, rCel.marca);
		writeln(txtCel,rCel.stockDisp, rCel.stockMin, rCel.descripcion);
		writeln(txtCel,rCel.nom);
	end;
	close (archCel);
	close (txtCel);
end;


var
{
	archtxt:text;
}
	x:integer;
	archCel:fileCel;
begin
{
	writeln('creacion del archivo de celulares txt (implementado)');
	creartxt(archtxt);
}

	repeat
		writeln('1. crear archivo');
		writeln('2. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo.');
		writeln('3. Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de caracteres proporcionada por el usuario.');
		writeln('4. Exportar el archivo creado en el inciso a) a un archivo de texto denominado “celulares.txt” con todos los celulares del mismo.');
		writeln('0. Terminar operacion.');
		readln(x);
		case x of 
			1:crearYCargarArchivo(archCel);
			2:listarMenorAlMinimo(archCel);
			3:listarCoincideDescripcion(archCel);
			4:exportarArchivo(archCel);
		end;
	until(x=0)
end.
	
	
	
	
