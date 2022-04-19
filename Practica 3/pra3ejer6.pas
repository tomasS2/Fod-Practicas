{
6. Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado
con la información correspondiente a las prendas que se encuentran a la venta. De
cada prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y
precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las prendas
a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las prendas que 
quedarán obsoletas. Deberá implementar un procedimiento que reciba ambos archivos
y realice la baja lógica de las prendas, para ello deberá modificar el stock de la prenda
correspondiente a valor negativo.
Por último, una vez finalizadas las bajas lógicas, deberá efectivizar las mismas
compactando el archivo. Para ello se deberá utilizar una estructura auxiliar, renombrando
el archivo original al finalizar el proceso. Solo deben quedar en el archivo las prendas
que no fueron borradas, una vez realizadas todas las bajas físicas.}

program ejer6pr3;
const 
	VALOR_ALTO = 9999;
type
	cad20 = string[20];

	prenda = record	
		cod: integer;
		desc: cad20;
		color: cad20;
		tipo: cad20;
		stock: integer;
		precio: real;
	end;
	
	file_prendas = file of prenda;
	file_obsoletas = file of integer;
	file_compacto = file of prenda;
	

procedure darBajaLogica(var fp:file_prendas ;var fo:file_obsoletas);


	procedure leerArchCod (var fo:file_obsoletas;var cod_obsoleta:integer) ;
	begin
		if not eof (fo) then 
			read(fo,cod_obsoleta)
		else
			cod_obsoleta:= VALOR_ALTO;
	end;
	
	
var
	cod_obsoleta : integer;
	reg_prenda: prenda;
begin
	reset(fp);//mae
	reset(fo);//det
	leerArchCod(fo,cod_obsoleta);
	while (cod_obsoleta<>VALOR_ALTO) do begin
		read(fp,reg_prenda);
		while (cod_obsoleta <> reg_prenda.cod)do 
			read(fp,reg_prenda);
		if (cod_obsoleta = reg_prenda.cod) then begin
				reg_prenda.stock := reg_prenda.stock*-1;
				seek(fp, filePos(fp)-1);
				write(fp, reg_prenda);				
		end;
	end;
	close(fo);
	close(fp);
end;


procedure compactar (var fp:file_prendas);
var
	reg_prenda,aux: prenda;
	pos_borrar:integeR;
begin
	reset(fp);
	while not eof (fp) do begin
		read(fp,reg_prenda);
		if (reg_prenda.stock < 0)then	begin
			pos_borrar:= filePos(fp)-1;
			if (pos_borrar <> filesize(fp)-1)then begin
				seek(fp,filesize(fp)-1);
				read(fp,aux);
				seek(fp,pos_borrar);
				write(fp,aux);		
			end;
			seek(fp,filesize(fp)-1);
			truncate(fp);
		end;
	end;
	close(fp);
	rename(fp, 'prendas_compactadas');
end;



var 
	fo: file_obsoletas;
	fp: file_prendas;
begin
	assign(fp, 'prendas');
	assign(fo, 'prendas_obsoletas');
	darBajaLogica(fp,fo);
	compactar(fp);
end.	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
