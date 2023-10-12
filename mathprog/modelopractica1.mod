#
# 100472092, 100472182

set PARKING;
set DISTRITO;

/* parameters */
param Tiempo_parking_distrito {i in PARKING, j in DISTRITO}; /*tiempo parking i -> distrito j*/
param Total_llamadas_distrito {j in DISTRITO};
param Max_llamadas_parking {i in PARKING}; /* máximo de 10.000 llamadas por parking*/
param Max_minutes_parking {i in PARKING};

/* decision variables */
var Llamadas_parking {i in PARKING, j in DISTRITO} >=0; 

/* objective function */
minimize time: sum{i in PARKING, j in DISTRITO} Tiempo_parking_distrito[i, j] * Llamadas_parking[i, j];

/* Constraints */
s.t. Llamadas {i in PARKING}: sum{j in DISTRITO} Llamadas_parking[i, j] <= Max_llamadas_parking[i]; /*llamadas <= 10000*/
s.t. Llamadas_distrito {j in DISTRITO}: sum{i in PARKING}Llamadas_parking[i, j] = Total_llamadas_distrito[j]; /*\sum_i lij = Li*/
s.t. Max_tiempo_llamadas {i in PARKING, j in DISTRITO}: Llamadas_parking[i, j] * (Max_minutes_parking[i] - Tiempo_parking_distrito[i, j]) >= 0; /*lij(35 - tij) >= 0*/
s.t. No_supera_50_del_resto {i in PARKING, h in PARKING: i<>h}: sum {j in DISTRITO} Llamadas_parking[i, j] <= 1.5 * sum{k in DISTRITO} Llamadas_parking[h, k]; /*\sum_j lij <= 1.5 sum_k lik*/

end;
