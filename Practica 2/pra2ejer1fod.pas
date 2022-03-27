{
1.Una empresa posee un archivo con información de los ingresos percibidos por diferentes empleados en concepto de comisión, 
 de cada uno de ellos se conoce: código de empleado,nombre y monto  de la comisión.

La información del archivo se encuentra ordenada por código de empleado y cada empleado puede aparecer más de una vez en el archivo de comisiones. 
Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. 
En consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca  una única vez con el valor total de sus comisiones.
NOTA:  No se conoce a priori la cantidad de  empleados. Además,  el archivo debe  ser recorrido una única vez.

no se si crear el maestro a partir de un detalle o modificar el maestro a partir del detalle.

}
program p2ej1fod;
const 	
	VALOR_ALTO=9999;
type
	rInformacionEmpleados= record
		codEmple:integer;
		montoComision:real;
	end;
	archComisiones=file of rInformacionEmpleados;//arc. detalle
	archInfoCompacta=file of rInformacionEmpleados; //maestro.
	
	
		
	

procedure cargarMaestro (var mae: archInfoCompacta; var det: archComisiones);
	procedure leerDetalle (var det: archComisiones; var r:rInformacionEmpleados);
	begin
		if not eof (det) then 
			read(det,r)
		else
			r.codEmple:=VALOR_ALTO;
	end;
var
	rDet:rInformacionEmpleados;
	rMae:rInformacionEmpleados;
	sumador,auxCod:integer;
begin
	assign (det,'infoDetalleEmpleados');
	assign(mae,'archMaestro');
	rewrite(mae);
	reset(det);
	leerDetalle(det,rDet);
	while (rDet.codEmple<>VALOR_ALTO)do begin
		auxCod:=rDet.codEmple
		sumador:=0;
		while (auxCod = rDet.codEmple)do begin
			sumador:=sumador+rDet.montoComision;
			leerDetalle(det,rDet);
		end;
		rMae.codEmple:=auxCod;
		rMae.montoComision:=sumador;
		write(mae,rMae);
	end;
	close(mae);
	close(det);
end;

var
	det:archComisiones;
	mae:archInfoCompacta;
begin	
	cargarMaestro(mae,det);
end.
