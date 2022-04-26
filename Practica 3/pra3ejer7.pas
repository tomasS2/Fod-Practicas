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
	
	
	
	//HACER ESTO MISMO EN EL 6
procedure compactar (var f: f_ave);
var
	reg_ave: ave;
	pos_borrar: integer;
begin
	reset (f);
	while not eof (f) do begin
		read(f,reg_ave);
		if (reg_ave.cod < 0) then begin 
			pos_borrar:= filePos(f)-1;
			seek (f, filesize(f)-1);
			read(f,reg_ave);
			while (reg_ave.cod < 0) do begin //mientras lo que este en la ultima pos este marcado, borro.
				seek (f, filesize(f)-1);
				truncate(f);
				seek (f, filesize(f)-1);//es uno menos que antes porque trunqué.
				read(f,reg_ave);
			end;//cuando el ultimo deja de ser un registro marcado, sale.
			{se copia lo que esta en la ultima pos del archivo (un registro con un valor NO marcado) en la pos donde está guardado el indice de un registro a borrar. Una vez copiado, se trunca la ultima pos para eliminar el duplicado.}
			seek(f, pos_borrar);
			write(f,reg_ave);
			seek (f, filesize(f)-1);
			truncate(f);
			seek(f, pos_borrar);
		end;
		read(f, reg_ave);
	end;
end;
	

var 
	f: f_ave;
begin
	assign(f,'arc_aves');
	eliminarEspecies(f);
	compactar(f);
end.
	





















