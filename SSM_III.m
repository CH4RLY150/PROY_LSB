function [vector_area, SSM_III] = SSM_III(sequences_c1,sequences_c2, sequences_c3, sequences_c4, vector_areas_c1, vector_areas_c2, vector_areas_c3, vector_areas_c4)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N1 = size(sequences_c1);
N2 = size(sequences_c2);
N3 = size(sequences_c3);
N4 = size(sequences_c4);

SSM_III = cell(N1(1, 1)+N2(1, 1)+N3(1, 1)+N4(1, 1), 1);
for q = 1:N1(1, 1)
    SSM_III{q, 1} = sequences_c1{q, 1};
   % SSM_I{2, q} = sequences_c1{1, q};
end
for q = 1:N2(1, 1)
    SSM_III{q+N1(1, 1), 1} = sequences_c2{q, 1};
    %SSM_I{2, q} = sequences_c2{1, q};
end
for q = 1:N3(1, 1)
    SSM_III{q+N2(1, 1)+N1(1, 1), 1} = sequences_c3{q, 1};
    %SSM_I{2, q} = sequences_c3{1, q};
end
for q = 1:N4(1, 1)
    SSM_III{q+N2(1, 1)+N1(1, 1)+N3(1, 1), 1} = sequences_c4{q, 1};
    %SSM_I{2, q} = sequences_c4{1, q};
end
vector_areas = cat(2,vector_areas_c1, vector_areas_c2);
vector_areas = cat(2, vector_areas_c3, vector_areas);
vector_areas = cat(2, vector_areas, vector_areas_c4);
vector_area = transpose(vector_areas);
end