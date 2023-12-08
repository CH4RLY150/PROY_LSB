function [Tfin] = SSM_IV(sequences_c1,sequences_c2, sequences_c3, sequences_c4, vector_areas_c1, vector_areas_c2, vector_areas_c3, vector_areas_c4)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
N1 = size(sequences_c1);
N2 = size(sequences_c2);
N3 = size(sequences_c3);
N4 = size(sequences_c4);

vecareas_c1 = transpose(vector_areas_c1);
vecareas_c2 = transpose(vector_areas_c2);
vecareas_c3 = transpose(vector_areas_c3);
vecareas_c4 = transpose(vector_areas_c4);

n1 = round(N1(1, 1)*0.25);
n2 = round(N2(1, 1)*0.25);
n3 = round(N3(1, 1)*0.25);
n4 = round(N4(1, 1)*0.25);

Tabla_c1 = table(vecareas_c1, sequences_c1);
Tabla_c1 = sortrows(Tabla_c1, 1);
Tabla_c1(1:N1(1, 1)-n1, :) = [];

Tabla_c2 = table(vecareas_c2, sequences_c2);
Tabla_c2 = sortrows(Tabla_c2, 1);
T2 = renamevars(Tabla_c2,"vecareas_c2","vecareas_c1");
T2 = renamevars(T2, "sequences_c2", "sequences_c1");
T2(1:N2(1, 1)-n2, :) = [];

Tabla_c3 = table(vecareas_c3, sequences_c3);
Tabla_c3 = sortrows(Tabla_c3, 1);
T3 = renamevars(Tabla_c3,"vecareas_c3","vecareas_c1");
T3 = renamevars(T3, "sequences_c3", "sequences_c1");
T3(1:N3(1, 1)-n3, :) = [];

Tabla_c4 = table(vecareas_c4,sequences_c4);
Tabla_c4 = sortrows(Tabla_c4, 1);
T4 = renamevars(Tabla_c4,"vecareas_c4","vecareas_c1");
T4 = renamevars(T4, "sequences_c4", "sequences_c1");
T4(1:N4(1, 1)-n4, :) = [];

Tnew = [Tabla_c1; T2];
Tnew_ = [Tnew; T3];
Tfin = [Tnew_; T4];
end