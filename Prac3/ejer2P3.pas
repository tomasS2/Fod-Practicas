program ej2P3;
type

	cadena = string[20];
	
	asistente = record
		num : integer;
		nom : cadena;
		ape : cadena;
		gmail : cadena;
		telefono : integer;
		dni : integer;
		
	end;
	
	archivo = file of asistente;
	
procedure crearArch(var a:archivo);	

	procedure leer (var r: asistente);
	begin
		read(r.num);
		if(a.num <> -1)then begin
			read(r.nom);
			read(r.ape);
			read(r.gmail);
			read(r.telefono);
			read(r.dni);
		end;		
	end;
	
var	
	archFis:string[15];{utilizada para obtener el nombre físico del archivo desde teclado}
	asi:asistente;{nro será utilizada para obtener la información de teclado}
begin
	writeln('nom archivo');
	read(archFisNum);{se obtiene el nombre del archivo}
	assign (a,archFis);
	rewrite(a);{se crea el archivo}
	writeln('ingre num');
	leer(asi);{ se obtiene de teclado el primer valor}
	while (asi.num<>-1)do begin
		write(a, asi); {se escribe en el archivo cada número }
		leer(asi);
	end;
	close(a);{se cierra el archivo abierto oportunamente con la instrucción rewrite}
end.
	
procedure borrar(var a:archivo);
var
	asis : asistente;
begin
	reset(a);
	while(not eof(a))do begin
		read(a,asis);
		if(asis.num < 1000)then begin
			asis.nom := ' ------------ ';
			write(a, asis);
		end;
	end;
	close(a);		
end;
	
VAR
BEGIN
END.
