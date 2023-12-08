function [sequences_c1, vector_areas] = condicion1(power_theta,power_alfa, power_delta)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
c1_ = find(power_theta>power_alfa & power_theta>power_delta);
c1 = sort(c1_);
if isempty(c1) == 0
    seqlengths = diff([0, find(diff(c1) ~= 1 & diff(c1)>15), numel(c1)]);
    sequences = mat2cell(c1, 1, seqlengths);
    
    A_c1 = realmax('double');
    nsize = size(sequences);
    %sequences_c1 = cell(2, nsize(1, 2));
    sequences_c1 = cell(nsize(1, 2), 1);
    vector_areas = zeros(1, nsize(1,2));
    for j = 1:nsize(1, 2)
        minimo = min(sequences{1,j});
        maximo = max(sequences{1,j});
        if minimo ~= maximo
            Area1 = trapz(minimo:maximo, power_theta(1, minimo:maximo))-trapz(minimo:maximo, power_alfa(1, minimo:maximo));
            Area2 = trapz(minimo:maximo, power_theta(1, minimo:maximo))-trapz(minimo:maximo, power_delta(1, minimo:maximo));
            A_ = min(abs(Area1), abs(Area2));
            A_c1 = min(A_c1, A_);

            %vector_random = zeros(2, length(sequences{1, j}));
            %vector_random(1, 1) = A_c1;
            %vector_random(2, :) = sequences{1, j};
            vector_areas(1, j) = A_c1;
            sequences_c1{j, 1} = sequences{1, j};
            
            %sequences_c1{1,j} = sequences{1,j};
            %sequences_c1{2, j} = A_c1;
        end
    end
end
end