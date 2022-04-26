{
8. Se cuenta con un archivo con información de las diferentes distribuciones de linux
existentes. De cada distribución se conoce: nombre, año de lanzamiento, número de
versión del kernel, cantidad de desarrolladores y descripción. El nombre de las
distribuciones no puede repetirse.
Este archivo debe ser mantenido realizando bajas lógicas y utilizando la técnica de
reutilización de espacio libre llamada lista invertida.
Escriba la definición de las estructuras de datos necesarias y los siguientes
procedimientos:
ExisteDistribucion: módulo que recibe por parámetro un nombre y devuelve verdadero si
la distribución existe en el archivo o falso en caso contrario.

AltaDistribución: módulo que lee por teclado los datos de una nueva distribución y la
agrega al archivo reutilizando espacio disponible en caso de que exista. (El control de
unicidad lo debe realizar utilizando el módulo anterior). En caso de que la distribución que
se quiere agregar ya exista se debe informar “ya existe la distribución”.

BajaDistribución: módulo que da de baja lógicamente una distribución cuyo nombre se
lee por teclado. Para marcar una distribución como borrada se debe utilizar el campo
cantidad de desarrolladores para mantener actualizada la lista invertida. Para verificar
que la distribución a borrar exista debe utilizar el módulo ExisteDistribucion. En caso de no
existir se debe informar “Distribución no existente”.
}


program ej8pr3;
type
	cad20 = string[20];
	cad50 = string[50];
	distribucion = record
		nom: cad20;
		descripcion: cad50;
		anio_lanzamiento: integer;
		nro_version: integer;
		cant_desa: integer;
	end;
	
	file_distribuciones = file of distribucion;
	


procedure existeDistribucion (var f: file_distribuciones; nom_ver: cad20; var existe: boolean );
var
	reg: distribucion;
begin
	reset(f);
	read(f,reg);//leo cabecera.
	existe:= false;
	while not eof (f) and (not existe) do begin
		read(f,reg);
		if (reg.nom = nom_ver)then
			existe:= true;
	end;
	close(f);
end;	


		{ALTA}
	
	
procedure AltaDistribucion (var f: file_distribuciones);
	procedure hacerAlta (var f: file_distribuciones; reg: distribucion);
	var
		cabecera: distribucion;
	begin
		reset(f);
		read(f, cabecera);
		if (cabecera.cant_desa = 0) then begin
			seek (f,filesize (f));
			write(f, reg);
		end
		else begin
			seek (f, cabecera.cant_desa *-1);
			read(f, cabecera);
			seek (f, filePos(f)-1);
			write(f, reg);
			seek (f, 0);
			write(f, cabecera);
		end;
		close(f);
	end;

	
var
	reg: distribucion;
	existe: boolean;
begin
	read(reg.nom);
	read(reg.descripcion);
	read(reg.anio_lanzamiento);
	read(reg.nro_version);
	read(reg.cant_desa);
	existeDistribucion(f, reg.nom, existe);
	if (existe) then
		write('ya existe la distribucion')
	else
		hacerAlta(f,reg);
end;
	
	
	
	{BAJA}
	
	
procedure BajaDistribucion (var f: file_distribuciones);
	procedure hacerBaja (var f: file_distribuciones; reg: distribucion);
	var
		nom_baja: cad20;
		encontre: boolean;
		cabecera: distribucion;
	begin
		read(nom_baja);
		encontre:= false;
		reset(f);
		read(f, cabecera);
		while not eof (f) and not encontre do begin
			read(f, reg);
			if (reg.nom = nom_baja)then
				encontre:= true;
				reg.cant_desa:= cabecera.cant_desa; //copio indice que estaba en el reg 0
				seek(f, filepos(f)-1);
				cabecera.cant_desa:= filepos(f) * -1; //indice a neg.
				write(f,reg);//escribo lo que contenia la pos 0 antes.
				seek(f,0);
				write(f,cabecera);//pos 0 tiene nueva pos borrada.
			end;
		close(f);
	end;

	
var
	reg: distribucion;
	existe: boolean;
begin
	read(reg.nom);
	read(reg.descripcion);
	read(reg.anio_lanzamiento);
	read(reg.nro_version);
	read(reg.cant_desa);
	existeDistribucion(f, reg.nom, existe);
	if (existe) then
		hacerBaja(f,reg)
	else
		write('distribucion no existente');
end;
	
	
	
var
	f: file_distribuciones;
begin
	assign(f,'archivo');
	AltaDistribucion(f);
	BajaDistribucion(f);
end.
	
	
	
	
	
	
	
	
	
