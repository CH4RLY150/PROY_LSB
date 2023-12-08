function [sequences_c4, vector_areas] = condicion4(power_alfa, power_delta,power_theta)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
c4 = find(power_alfa<power_delta & power_alfa<power_theta);
if isempty(c4) == 0
    seqlengths = diff([0, find(diff(c4) ~= 1 & diff(c4)>15), numel(c4)]);
    sequences = mat2cell(c4, 1, seqlengths);

    A_c4 = realmax('double');
    nsize = size(sequences);
    %sequences_c4 = cell(2, nsize(1, 2));
    sequences_c4 = cell(nsize(1, 2), 1);
    vector_areas = zeros(1, nsize(1, 2));
    for j = 1:nsize(1, 2)
        minimo = min(sequences{1,j});
        maximo = max(sequences{1,j});
        if minimo ~= maximo
            Area1 = trapz(minimo:maximo, power_delta(1, minimo:maximo))-trapz(minimo:maximo, power_alfa(1, minimo:maximo));
            Area2 = trapz(minimo:maximo, power_theta(1, minimo:maximo))-trapz(minimo:maximo, power_alfa(1, minimo:maximo));
            A_ = min(abs(Area1), abs(Area2));
            A_c4 = min(A_c4, A_);

            %vector_random = zeros(2, length(sequences{1, j}));
            %vector_random(1, 1) = A_c4;
            %vector_random(2, :) = sequences{1, j};
            vector_areas(1, j) = A_c4;
            sequences_c4{j, 1} = sequences{1, j};
            %sequences_c4{1,j} = sequences{1,j};
            %sequences_c4{2, j} = A_c4;
        end
    end
end
end