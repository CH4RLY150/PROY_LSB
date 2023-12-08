% PRÁCTICA EEG   (EEGLAB) 
%% 1ª parte: DETECCIÓN DE EVENTOS EPILEPTIFORMES
% No aplicamos ningún tipo de preprocesado
clear;
clc;
fs = 256;
start_s = 1467;
n0 = fs * start_s;
end_s = 1494;
nf = fs * end_s;

FolderPath = uigetdir(pwd,'Selecciona la carpeta con archivos DICOM');
d = dir(fullfile(FolderPath, "*.edf"));
answer = inputdlg('Epoch de EEG a procesar','Número de archivo',1);
i = str2double(answer);
filename = fullfile(FolderPath, d(i).name);
[data, header] = readedf(filename);
eegplot(data,'winlength', 10, 'srate', fs)
eegplot(data(:, n0:nf),'winlength', 27, 'srate', fs)

%% 8ª parte
n = size(data);
N = n(1, 1);
L = n(1, 2);
noverlap = 0;
Wn = 1 * fs;
sum = zeros(129, 3600);
for i = N
    if i == 1
        [s, f, t] = stft(data(i, :), fs, "Window", hamming(Wn, 'periodic'), "OverlapLength", noverlap, 'FrequencyRange', 'onesided');
        sum = s;
    end
    [s, f, t] = stft(data(i, :), fs, "Window", hamming(Wn, 'periodic'), "OverlapLength", noverlap, 'FrequencyRange', 'onesided');
    sum = sum + s;
end
%spectrogram(filtrada(i, n0-wn:n0+wn),hamming(1*fs),noverlap,0:1/100:fs/2,fs,"yaxis");
AS = abs(sum).^2;
surf(t,f,AS);
colormap jet;
shading interp;
ax=gca;
colorlim = get(ax,'clim');
newlim = [(colorlim(1)*0.1),colorlim(2)];
set(ax,'clim',(newlim));

%% potencia de cada banda
power_delta = zeros(1,3600);
for i = 3:1:4
    power_delta = power_delta + AS(i, :);
end

power_theta = zeros(1,3600);
for i = 5:1:8
    power_theta = power_theta + AS(i, :);
end

power_alfa = zeros(1,3600);
for i = 9:1:14
    power_alfa = power_alfa + AS(i, :);
end

figure
plot(t, power_delta)
hold on
plot(t, power_theta, 'green', t, power_alfa, 'red')
title('potencia en cada una de las bandas de frecuencia')
xlabel('Tiempo (s)')
ylabel('Potencia')
legend("delta: 2-3Hz", 'theta: 4-7Hz', 'alpha: 8:13Hz')
hold off

%% condiciones 1, 2, 3 y 4
%condición 1
[sequences_c1, vector_areas_c1] = condicion1(power_theta, power_alfa, power_delta);
%condición 2
[sequences_c2, vector_areas_c2] = condicion2(power_alfa, power_delta, power_theta);
%condición 3
[sequences_c3, vector_areas_c3] = condicion3(power_alfa, power_delta, power_theta);
%condición 4
[sequences_c4, vector_areas_c4] = condicion4(power_alfa, power_delta, power_theta);

%% Métodos de selección de segmentos

%SSM I

%SSM II

%SSM III
[areas_c3, SSM_3] = SSM_III(sequences_c1, sequences_c2, sequences_c3, sequences_c4, vector_areas_c1, vector_areas_c2, vector_areas_c3, vector_areas_c4);
SSM3 = table(areas_c3, SSM_3);
SSM3 = sortrows(SSM3, 1);
SSM3 = table2cell(SSM3);

%SSM IV
[Tfin] = SSM_IV(sequences_c1, sequences_c2, sequences_c3, sequences_c4, vector_areas_c1, vector_areas_c2, vector_areas_c3, vector_areas_c4);
SSM4 = sortrows(Tfin, 1);
SSM4 = table2cell(SSM4);

%% Representación de los segmentos

%SSM I

%SSM II

%SSM III
n = size(SSM3);
segmentous = SSM3{n(1, 1), 2};
n0 = fs*min(segmentous);
n1 = fs*max(segmentous);
%segmento = segmentous.*fs;
eegplot(data(:, n0:n1), 'srate', fs)
%SSM IV
n = size(SSM4);
segmentous = SSM4{n(1, 2), 2};
n0 = fs*min(segmentous);
n1 = fs*max(segmentous);
%segmento = segmentous.*fs;
eegplot(data(:, n0:n1), 'srate', fs)

%%
eegplotrej = eegplot(data, 'winrej', [n0 n1 'red' 'green' 'black' ones(1, 23)]);
[events] = eegplot2event(eegplotrej);
eegplot(data, 'events', events, 'srate', fs);