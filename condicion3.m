function [sequences_c3, vector_areas] = condicion3(power_alfa,power_delta, power_theta)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
c3_1 =find(power_theta>power_delta);
c3_2 =find(power_alfa>power_delta);
c3 = intersect(c3_1, c3_2);
if isempty(c3) == 0
    seqlengths = diff([0, find(diff(c3) ~= 1 & diff(c3)>15), numel(c3)]);
    sequences = mat2cell(c3, 1, seqlengths);

    A_c3 = realmax('double');
    nsize = size(sequences);
    %sequences_c3 = cell(2, nsize(1, 2));
    sequences_c3 = cell(nsize(1, 2), 1);
    vector_areas = zeros(1, nsize(1, 2));
    for j = 1:nsize(1, 2)
        minimo = min(sequences{1,j});
        maximo = max(sequences{1,j});
        if minimo ~= maximo
            Area1 = trapz(minimo:maximo, power_theta(1, minimo:maximo))-trapz(minimo:maximo, power_delta(1, minimo:maximo));
            Area2 = trapz(minimo:maximo, power_alfa(1, minimo:maximo))-trapz(minimo:maximo, power_delta(1, minimo:maximo));
            A_ = min(abs(Area1), abs(Area2));
            A_c3 = min(A_c3, A_);

            %vector_random = zeros(2, length(sequences{1, j}));
            %vector_random(1, 1) = A_c3;
            %vector_random(2, :) = sequences{1, j};
            vector_areas(1, j) = A_c3;
            sequences_c3{j, 1} = sequences{1, j};
            %sequences_c3{1,j} = sequences{1,j};
            %sequences_c3{2, j} = A_c3;
        end
    end
end
end