{
13. Suponga que usted es administrador de un servidor de correo electrónico. En los logs
del mismo (información guardada acerca de los movimientos que ocurren en el server) que
se encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información:
nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. Diariamente el
servidor de correo genera un archivo con la siguiente información: nro_usuario,
cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los
usuarios en un día determinado. Ambos archivos están ordenados por nro_usuario y se
sabe que un usuario puede enviar cero, uno o más mails por día.

a- Realice el procedimiento necesario para actualizar la información del log en
un día particular. Defina las estructuras de datos que utilice su procedimiento.
b- Genere un archivo de texto que contenga el siguiente informe dado un archivo
detalle de un día determinado:
nro_usuarioX…………..cantidadMensajesEnviados
………….
nro_usuarioX+n………..cantidadMensajesEnviados
Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que
existen en el sistema.
}

program p2ej13fod;
const 
	VALOR_ALTO = 9999;
type
	cad20 = string[20];
	cad100 = string[100];
	rLogs = record 
		nro_usuario: integer;
		nom_usuario: cad20;
		nom: cad20;
		ape: cad20;
		cant_mail_enviados: integeR;
	end;
	
	rInfoDet = record
		nro_usuario: integer;
		cuenta_destino: cad20;
		cuerpo_mensaje: cad100;
	end;
	
	fileMae = file of rLogs; //mae
	fileDet = file of rInfoDet; //det

procedure actualizarArchivoLog(var mae: fileMae; var det: fileDet);
	procedure leer (var det:fileDet; var regd: rInfoDet);
	begin
		if not eof (det)then 
			read(det, regd)
		else
			regd.nro_usuario:= VALOR_ALTO;
	end;

var
	regd: rInfoDet;
	regm: rLogs;
begin
	reset(mae); 
	reset(det);
	leer(det, regd);
	 while (regd.nro_usuario <> VALOR_ALTO)do begin
		read (mae,regm);
		while (regd.nro_usuario <> regm.nro_usuario)do 
			read (mae,regm);
		while (regd.nro_usuario = regm.nro_usuario)do begin
			regm.cant_mail_enviados := regm.cant_mail_enviados +1;
			leer(det, regd);
		end;
		seek(mae, filepos(mae)-1);
		write(mae, regm);
		
	end;
	close(mae);
	close(det);
end;
	
	
procedure generartxt (var mae: fileMae);
var
	regm: rLogs;
	txt: text;
begin
	reset (mae);
	assign(txt, 'text_con_info');
	rewrite(txt);
	while not eof (mae) do begin
		read(mae, regm);
		write(txt, regm.nro_usuario, regm.cant_mail_enviados);
	end;	
end;

var
	mae: fileMae;
	det: fileDet;
begin
	assign(mae, 'archivo/var/log/logmail.dat');
	assign(det, 'detalle');
	actualizarArchivoLog(mae,det);
	generartxt(mae);
end.

	
	
	
	
