{
1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.

}
program p1ej1fod;
type
	arcNum= file of integer;{definición del tipo de dato para el archivo }
var
	archLogNum:arcNum;{variable que define el nombre lógico del archivo}
	archFisNum:string[15];{utilizada para obtener el nombre físico del archivo desde teclado}
	n:integer;{nro será utilizada para obtener la información de teclado}
begin
	writeln('nom archivo');
	read(archFisNum);{se obtiene el nombre del archivo}
	assign (archLogNum,archFisNum);
	rewrite(archLogNum);{se crea el archivo}
	writeln('ingre num');
	readln(n);{ se obtiene de teclado el primer valor}
	while (n<>30000)do begin
		write(archLogNum, n); {se escribe en el archivo cada número }
		writeln('ingre num');
		readln(n);
	end;
	close(archLogNum);{se cierra el archivo abierto oportunamente con la instrucción rewrite}
end.
	
