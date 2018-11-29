PROC IMPORT OUT= EJ1.ESPECTADORES 
            DATAFILE= "F:\trabajo2\ejercicio1\INE2.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

