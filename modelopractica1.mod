#
# Giapetto's problem
#
# This finds the optimal solution for maximizing Giapitto's profit
#


set PARKING;
set DISTRITO;

/* parameters */
param Tiempo_parking_distrito {i in PARKING}{j in DISTRITO}; /*tiempo parking i -> distrito j*/
param Total_llamadas_distrito {j in DISTRITO};
param Max_llamadas_parking {i in PARKING}; /* máximo de 10.000 llamadas por parking*/
param Max_minutes_parking {i in PARKING};

/* decision variables */
var Llamadas_parking {i in PARKING}{j in DISTRITO} >=0; 

/* objective function */
minimize: sum{i in PARKING} sum{j in DISTRITO} Tiempo_parking_distrito[i][j] * llamadas_parking[i][j];

/* Constraints */
s.t. Llamadas : sum{i in DISTRITO} Llamadas_parking[i] <= Max_llamadas_parking[i];
s.t. Llamadas_distrito {j in DISTRITO}: sum{i in PARKING}Llamadas_parking[i][j] = Total_llamadas_distrito[j];
s.t. Max_tiempo_llamadas {i in PARKING}{j in DISTRITO}: Llamadas_parking[i][j] * (Max_minutes_parking[i] - Tiempo_parking_distrito[i][j]) >= 0;
s.t. No_supera_50_del_resto {i in PARKING, h in PARKING: i<>h}: sum {j in DISTRITO} Llamadas_parking[i][j] <= 1.5 * sum{k in DISTRITO} * Llamadas_parking[h][k];

end;
