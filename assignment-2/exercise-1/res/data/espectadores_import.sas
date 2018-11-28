PROC IMPORT OUT= TRABAJO1.ESPECTADORES 
            DATAFILE= "E:\trabajo2\ejercicio1\INE2.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
