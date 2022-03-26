{
6. Agregar al menú del programa del ejercicio 5, opciones para:
a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
teclado.
b. Modificar el stock de un celular dado.
c. Exportar el contenido del archivo binario a un archivo de texto denominado:
”SinStock.txt”, con aquellos celulares que tengan stock 0.
NOTA: Las búsquedas deben realizarse por nombre de celular.
}
program p1ej6fod;
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

procedure leerCel(var r:rCelular);
begin
	writeln('cod');
	readln(r.cod);
	if (r.cod<>-1)then begin//condicion inventada.
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
{
procedure creartxt (var txt:text);

var
	r:rCelular;
begin
	assign (txt,'celulares.txt');
	rewrite(txt);
	leerCel(r);
	while (r.cod<>-1) do begin
		writeln(txt,r.cod,r.precio,r.marca);
		writeln(txt,r.stockDisp,r.stockMin,r.descripcion);
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
	
	writeln;
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
	rCel:rCelular;
begin
	assign(txtCel,'celulares.txt');
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

procedure anadirUnoOMasCelulares (var archCel:fileCel);
var
	rCel:rCelular;

begin
	reset(archCel);
	seek(archCel,filesize(archCel));
	leerCel(rCel);
	while (rCel.cod<>-1) do begin//condicion inventada.
		write(archCel, rCel);
		leerCel(rCel);
	end;	
	close(archCel);
end;
		
		
procedure modificarStockCelularDado(var archCel:fileCel);
var
	nomCel:string;
	rCel:rCelular;
	stockNuevo:integer;
begin
	writeln('nom celular para modificar stock: ');
	read(nomCel);
	reset(archCel);
	while not eof (archCel) do begin
		read(archCel,rCel);
		if (rCel.nom=nomCel)then begin
			writeln('Num nuevo stock: ');
			readln(stockNuevo);
		end;
		 seek(archCel,filePos(archCel)-1);
		 rCel.stockDisp:=stockNuevo;
		 write(archCel,rCel);
	end;
	close(archCel);
end;

procedure exportarContenido(var archCel:fileCel);
var
	txtNoStock:text;
	rCel:rCelular;
begin	
	assign(txtNoStock,'SinStock.txt');
	rewrite(txtNoStock);
	reset(archCel);
	while not eof (archCel) do begin
		read(archCel,rCel);
		if (rCel.stockDisp=0)then 
			write(txtNoStock,'cod: ', rCel.cod, ' Nom: '+ rCel.nom+ ' marca: ' +  rCel.marca  +' descripcion: '+rCel.descripcion+' modelo: '+ rCel.modelo, ' precio: ', rCel.precio, ' stockMin: ', rCel.stockMin, ' stockDisp: ', rCel.stockDisp);
	end;
	close(archCel);
end;

var
	//archtxt:text;
	x:integer;
	archCel:fileCel;
begin
{
	creartxt(archtxt);
}
	repeat
		writeln('1. crear archivo');
		writeln('2. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo.');
		writeln('3. Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de caracteres proporcionada por el usuario.');
		writeln('4. Exportar el archivo creado en el inciso a) a un archivo de texto denominado “celulares.txt” con todos los celulares del mismo.');
		writeln('5. Añadir uno o más celulares al final del archivo con sus datos ingresados por teclado.');
		writeln('6. Modificar el stock de un celular dado.');
		writeln('7. Exportar el contenido del archivo binario a un archivo de texto denominado: ”SinStock.txt”, con aquellos celulares que tengan stock 0.');
		writeln('0. Terminar operacion.');
		readln(x);
		case x of 
			1:crearYCargarArchivo(archCel);
			2:listarMenorAlMinimo(archCel);
			3:listarCoincideDescripcion(archCel);
			4:exportarArchivo(archCel);
			5:anadirUnoOMasCelulares(archCel);
			6:modificarStockCelularDado(archCel);
			7:exportarContenido(archCel);
		end;
	until(x=0)
end.
