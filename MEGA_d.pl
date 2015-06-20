#DESCRIPCIÓN


#El programa va a calcular distancias genéticas usando un script de MEGA con todos los archivos que se encuentren en el directorio de trabajo

#Los scripts .mao creados con MEGA-cc tendrán que estar en el mismo directorio que este programa

#En este mismo directorio hay que crear las carpetas d dN y dS antes de ejecutar el programa

#Variables de entrada: todos los archivos en formato .mas que contenga un determinado directorio

#Variables de salida: un archivo .meg que contiene la matriz de distancias de cada alineamiento que esté en el directorio de trabajo

#Si la ejecución se relentiza hay que mover todos los archivos a una carpeta nueva, ya que se pueden generar archivos invisibles que obstaculizan la ejecución

#_____________________________________________________________________________________________________________________________________________________________

#MÓDULOS


use strict;   #Obliga a la declaración directa de todas las variables que se vaya a usar

use File::Find;   #Permite la búsqueda y uso secuencial de todos los archivos contenidos en un directorio

#_____________________________________________________________________________________________________________________________________________________________

#PROGRAMA


my $path="/home/alberto/Desktop/MEGA";   #Establezco la localización del directorio que en mi caso contiene todos alineamientos en formato .meg

#Con las siguientes instrucciones aplico las subrutina "&do_mega-" a cada archivo en formato .mas que se encuentre en el directorio indicado:

print "¿Qué quiere calcular: d, dN, dS o TODAS?\n";

my $orden=<STDIN>;   #Con esto se introduce la orden vía teclado

chomp $orden;   #Elimino el caracter de final de línea

if ($orden eq "TODAS") {

	find(\&mega_d, $path);   #Aplica la subrutina a cada archivo del directorio

	system "mv *.meg d";   #Muevo los archivos que contienen las matrices de distancias a un directorio concreto que tiene que haber sido creado previamente

	find(\&mega_dN, $path);

	system "mv *.meg dN";

	find(\&mega_dS, $path);

	system "mv *.meg dS";

}

if ($orden eq "d") {

	find(\&mega_d, $path);   

	system "mv *.meg d";

}

if ($orden eq "dN") {

	find(\&mega_dN, $path);   

	system "mv *.meg dN";

}

if ($orden eq "dS") {

	find(\&mega_dS, $path);   

	system "mv *.meg dS";

}

else {print "Escribe una de las opociones posibles\n";}

exit;

#_____________________________________________________________________________________________________________________________________________________________

#SUBRUTINAS


sub mega_d {
    
    my $align="$_";

    system "megacc -a d.mao -d $align -o $align.distances";   #Con esta llamada ejecuto megacc con el script .mao indicado y el alineamiento correspondiente

    system "rm  *.txt";   #Con esta llamada al sistema elimino los archivos residuales que se generan durante el proceso 

}

sub mega_dN {
    
    my $align="$_";

    system "megacc -a dN.mao -d $align -o $align.distances";

    system "rm  *.txt";

}

sub mega_dS {
    
    my $align="$_";

    system "megacc -a dS.mao -d $align -o $align.distances";

    system "rm  *.txt";

}
