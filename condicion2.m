function [sequences_c2, vector_areas] = condicion2(power_alfa,power_delta, power_theta)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
c2 = find(power_alfa>power_theta & power_alfa>power_delta);
if isempty(c2) == 0
    seqlengths = diff([0, find(diff(c2) ~= 1 & diff(c2)>15), numel(c2)]);
    sequences = mat2cell(c2, 1, seqlengths);

    A_c2 = realmax('double');
    nsize = size(sequences);
    %sequences_c2 = cell(2, nsize(1, 2));
    sequences_c2 = cell(nsize(1, 2), 1);
    vector_areas = zeros(1, nsize(1, 2));
    for j = 1:nsize(1, 2)
        minimo = min(sequences{1,j});
        maximo = max(sequences{1,j});
        if minimo ~= maximo
            Area1 = trapz(minimo:maximo, power_alfa(1, minimo:maximo))-trapz(minimo:maximo, power_theta(1, minimo:maximo));
            Area2 = trapz(minimo:maximo, power_alfa(1, minimo:maximo))-trapz(minimo:maximo, power_delta(1, minimo:maximo));
            A_ = min(abs(Area1), abs(Area2));
            A_c2 = min(A_c2, A_);

            %vector_random = zeros(2, length(sequences{1, j}));
            %vector_random(1, 1) = A_c2;
            %vector_random(2, :) = sequences{1, j};
            vector_areas(1, j) = A_c2;
            sequences_c2{j, 1}= sequences{1, j};
            %sequences_c2{1,j} = sequences{1,j};
            %sequences_c2{2, j} = A_c2;
        end
    end
end
end