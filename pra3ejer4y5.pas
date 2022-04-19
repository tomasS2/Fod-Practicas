{
4. Dada la siguiente estructura:
type
	reg_flor = record
		nombre: String[45];
		codigo:integer;
	tArchFlores = file of reg_flor;

Las bajas se realizan apilando registros borrados y las altas reutilizando registros
borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el
número 0 en el campo código implica que no hay registros borrados y -N indica que el
próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.

a. Implemente el siguiente módulo:
 
//Abre el archivo y agrega una flor, recibida como parámetro
//manteniendo la política descripta anteriormente
	procedure agregarFlor (var a: tArchFlores ; nombre: string;
	codigo:integer);
	 
	
b. Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que
considere necesario para obtener el listado.
* 
* 
5. Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:
"Abre el archivo y elimina la flor recibida como parámetro manteniendo
la política descripta anteriormente"
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);}

program ejer4y5pr3;
type
	reg_flor = record
		nombre: String[45];
		codigo:integer;
	end;
	tArchFlores = file of reg_flor;



procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);
var
	flor,aux,aux2: reg_flor;
begin
	reset (a);
	if not eof (a)then
		read(a,aux);
	if aux.codigo = 0 then 
		writeln('no hay registros borrados')
	else begin
		seek(a, (aux.codigo*-1));
		read(a, aux2);
		seek(a, 0);
		write(a, aux2);
		seek(a, (aux.codigo*-1));
		flor.nombre := nombre;
		flor.codigo := codigo;
		write(a,flor);
	end;
	close(a);
end;
	
procedure listarContenido (var arch: tArchFlores);
var
	txt: text;
	flor:reg_flor;
begin
	assign(txt,'flores.txt');
	rewrite(txt);
	reset(arch);
	while not eof (arch)do begin
		read (arch,flor);
		if (flor.codigo > 0)then 
			writeln(txt, flor.codigo, flor.nombre);
	end;
		close(txt);
		close(arch);
end;
		
procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);	
var
	aux,indice:reg_flor;
	encontre:boolean;
begin
	reset(a);
	encontre:= false;
	if not eof then
		read(a,indice);//guardo contenido reg0
		
	while not eof and not encontre do begin
		read(a,aux);
		if (aux.codigo = flor.codigo) then begin
			encontre:= true;
			aux.codigo:= indice.codigo; //copio indice que estaba en el reg 0
			seek(a, filepos(a)-1);
			indice.codigo:= filepos(a) * -1; //indice a neg.
			write(a,aux);//escribo lo que contenia la pos 0 antes.
			seek(a,0);
			write(a,indice);//pos 0 tiene nueva pos borrada.
		end;
	 
	end;
end;
	
	
	
var
	nombre: String[45];
	cod:integer;
	arch:tArchFlores;
	flor:reg_flor;
begin
	read(cod);
	read(nombre);
	assign(arch, 'archivo');
	agregarFlor(arch,nombre,cod);
	listarContenido(arch);
	read(flor.codigo);
	read(flor.nombre);
	eliminarFlor(arch,flor);
end.
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
