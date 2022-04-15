program ej2P4;
type
	cadena = string[20];
	asistente = record
		cod : integer;
		gen : cadena;
		nom : cadena;
		director : cadena;
		duracion : integer;
		precio : real;
		
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

procedure listaInvertida();
var

begin
crearRegistroAux()
crearArchivoConCabecera(registroAux)
		
crear reg aux, crear reg normalemnte, moverse con los file para actualizar las posicoines(poniendo -pos a los registros borrados).

end;

	
