{
7. Se cuenta con un archivo que almacena información sobre especies de aves en
vía de extinción, para ello se almacena: código, nombre de la especie, familia de ave,
descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice
un programa que elimine especies de aves, para ello se recibe por teclado las especies a
eliminar. Deberá realizar todas las declaraciones necesarias, implementar todos los
procedimientos que requiera y una alternativa para borrar los registros. Para ello deberá
implementar dos procedimientos, uno que marque los registros a borrar y posteriormente
otro procedimiento que compacte el archivo, quitando los registros marcados. Para
quitar los registros se deberá copiar el último registro del archivo en la posición del registro
a borrar y luego eliminar del archivo el último registro de forma tal de evitar registros
duplicados.
Nota: Las bajas deben finalizar al recibir el código 500000
}
program ejer7pr3;
const
	VALOR_ALTO = 9999;
type
	cad20 = string[20];
	cad40 = string[40];
	ave = record
		cod : integer;
		nom_espe : cad20;
		fam_ave : cad20;
		desc : cad40;
		zona : cad20;
	end;
	
	f_ave = file of ave;
	


procedure eliminarEspecies (var f:f_ave);
var
	reg_ave: ave;
	cod_borrar : integer;
begin
	reset(f);
	read(cod_borrar);
	
	while (cod_borrar <> 5000) do begin
		seek(f,0);
		while not eof (f) and  do begin
			read(f,reg_ave);
			while (reg_ave.cod <> cod_borrar)and not eof (f) do 
				read(f,reg_ave);
			if (reg_ave.cod = cod_borrar) then begin
				reg_ave.cod := reg_ave.cod * -1;
				seek(f, filePos(f)-1);
				write(f,reg_ave);
			end;
		end;
		read(cod_borrar);
	end;
	close(f);
end;
	
	
	
procedure compactar (var f: f_ave);

//MAL
//CORREGIR LO QUE PASA SI EL ULTIMO REGISTRO ESTA MARCADO Y HAY OTRO EN EL MEDIO. EN EL 6 TAMBIEN CORREGIR.

var
	reg_ave,aux: ave;
	pos_borrar,i: integer;
begin
	reset (f);
	i:=1;
	while not eof (f) do begin
		read(f,reg_ave);
		while reg_ave.cod < 0 and not eof (f) do begin 
		//CORREGIR CASO QUE LEA EL PRIMER REGISTRO 
			seek(f, filesize(f)-i);
			read(f,aux);
			i := i + 1;
		end;
		seek(f,filesize(f)-1);
		truncate(f);
	end;
	close(f);
end;
	

var 
	f: f_ave;
begin
	assign(f,'arc_aves');
	eliminarEspecies(f);
	compactar(f);
end.
	





















