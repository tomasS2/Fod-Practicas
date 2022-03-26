{

2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla. 
}
program p1ej2fod;
type
	archivoNumeros=file of integer;
var
	nomArchivo:string[15];
	archNum:archivoNumeros;
	nro,sumadorCantNum,sumadorNumeros,sumadorCantNumMenores:integer;
	prom:real;
begin
	sumadorCantNumMenores:=0;
	sumadorCantNum:=0;
	sumadorNumeros:=0;
	writeln('nom archivo punto 1: ');
	readln(nomArchivo);
	assign(archNum,nomArchivo);
{
	assign(archNum,'D:\pascal-cosas\FOD Practicas\Practica 1\p1ej1fod'); //otra forma de abrir el archivo. la ruta de donde se guardo el archivo y su nombre.
}
{
	assign(archNum,'p1ej1fod'); //otra forma de abrir el archivo. El nombre debe coincidir.
}
	reset(archNum);//se abre el archivo ya creado para operar como de lec/escr
	while not eof (archNum) do begin
		read(archNum,nro);//se obitene un elemento y se avanza en el archivo (se avanza siempre que se hace read o write sobre el archivo).
		if (nro<1500)then
			sumadorCantNumMenores:=sumadorCantNumMenores+1;
		sumadorCantNum:=sumadorCantNum+1;
		sumadorNumeros:=sumadorNumeros+nro;
		writeln('num contenido en archivo: ',nro);
	end;
	close(archNum);
	prom:=sumadorNumeros/sumadorCantNum;
	writeln('Promedio: ',prom:2:2);
	writeln('cant num menor a 1500: ',sumadorCantNumMenores);
end.
