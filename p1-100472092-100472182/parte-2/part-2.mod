#
# 100472092, 100472182

set PARKING_EXISTENTES;
set PARKINGS_CANDIDATOS;
set PARKING := (PARKING_EXISTENTES union PARKINGS_CANDIDATOS);
set DISTRITO;

/* parameters */
param Tiempo_parking_distrito {i in PARKING, j in DISTRITO}; /*tiempo parking i -> distrito j*/
param Total_llamadas_distrito {j in DISTRITO};
param Coste_nuevo_parking {k in PARKINGS_CANDIDATOS};
param Coste_minuto_llamada {i in PARKING};
param Max_llamadas_parking; /* máximo de llamadas por parking*/
param M;
param Exceso;
param Cota_inf;
param Percent_max;
param Max_minutes_parking;



/* decision variables */
var Llamadas_parking {i in PARKING, j in DISTRITO} integer >=0;
var Parking_i_acoge_llamadas_j {i in PARKING, j in DISTRITO} binary; 
var Seleccion_parking_k {i in PARKING} binary;

/* objective function */
minimize coste: sum{i in PARKING, j in DISTRITO} (Tiempo_parking_distrito[i, j]*Coste_minuto_llamada[i]*Llamadas_parking[i, j]) + sum{k in PARKINGS_CANDIDATOS}(Seleccion_parking_k[k]*Coste_nuevo_parking[k]);

/* Constraints */
s.t. Llamadas {i in PARKING}: sum{j in DISTRITO} Llamadas_parking[i, j] <= Max_llamadas_parking; /*llamadas <= 10000*/
s.t. Redistribucion_distrito {j in DISTRITO: Total_llamadas_distrito[j] >= Percent_max*Max_llamadas_parking}: sum{i in PARKING} Parking_i_acoge_llamadas_j[i, j] >= 2; /*Un parking no puede acoger más de 7499 llamadas de un distrito*/
s.t. Llamadas_distrito {j in DISTRITO}: sum{i in PARKING}Llamadas_parking[i, j] = Total_llamadas_distrito[j]; /*\sum_i lij = Li*/
s.t. Max_tiempo_llamadas {i in PARKING, j in DISTRITO}: Llamadas_parking[i, j] * (Max_minutes_parking - Tiempo_parking_distrito[i, j]) >= 0; /*lij(35 - tij) >= 0*/
s.t. No_supera_50_del_resto_candidatos {i in PARKING, h in PARKING: i<>h}: sum {j in DISTRITO} Llamadas_parking[i, j] <= Exceso * sum{k in DISTRITO} Llamadas_parking[h, k] + M*(1 - Seleccion_parking_k[h]); /*\sum_j lij <= 1.5 sum_k lik*/
s.t. Condicion_acoger_llamadas {i in PARKING, j in DISTRITO}: Llamadas_parking[i, j] <= M*Parking_i_acoge_llamadas_j[i, j];
s.t. Condicion_acoger_llamadas2 {i in PARKING, j in DISTRITO}: Llamadas_parking[i, j] >= Parking_i_acoge_llamadas_j[i, j];
s.t. Cota_minima {i in PARKING, j in DISTRITO}: Llamadas_parking[i, j] >= Cota_inf*Parking_i_acoge_llamadas_j[i, j]*Total_llamadas_distrito[j]; /*lij >= 0.1 * Elij*Li*/
s.t. Condicion_existencia {i in PARKING}: sum{h in DISTRITO} Parking_i_acoge_llamadas_j[i, h] <= M*Seleccion_parking_k[i];

end;
