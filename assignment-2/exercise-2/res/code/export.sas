PROC EXPORT DATA= ej2.semanal 
            OUTFILE= "F:\trabajo2\ejercicio2\data\semanal.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;


PROC EXPORT DATA= ej2.semanal4 
            OUTFILE= "F:\trabajo2\ejercicio2\data\semanal4.csv" 
            DBMS=CSV REPLACE;
     PUTNAMES=YES;
RUN;
