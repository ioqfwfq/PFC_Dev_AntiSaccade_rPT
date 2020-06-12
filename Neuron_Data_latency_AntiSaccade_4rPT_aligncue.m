function [ltc] = Neuron_Data_latency_AntiSaccade_4rPT_aligncue
% For AntiSaccade task
% Show result from all trials pooled together (4 groups of rPT, 1 condition for each group)
% Aligned on saccade onset.
% The analysis was performed in a time-resolved fashion, comparing
% responses in a 100-ms-long moving window computed in 10-ms steps.
% TSs of all trials in each of the rPT groups are pooled together and been
% consider as a single trial.
% Calculating latency of *all trials* from each group using Neuron_Data_QsumLatency.m
%
% Input parameters: allTS - timestamps from all trials
%
% 7-Apr-2020, J Zhu

clear all
[Neurons_num Neurons_txt] = xlsread('database.xlsx','adultPFC');
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];
% Data = load('61sameneurons');
% Neurons = Data.neuron;
warning off MATLAB:divideByZero

Best_Cue = Get_Maxes(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Best_Cue)
    Opp_Cue(n) = opp_index(Best_Cue(n));
end

allTS1 = [];
allTS2 = [];
allTS3 = [];
allTS4 = [];
RT1 = [];
RT2 = [];
RT3 = [];
RT4 = [];

% Get TS and RT
for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    %     Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
    %     Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    try
        [allTS1_temp, allTS2_temp, allTS3_temp, allTS4_temp, RT1_temp, RT2_temp, RT3_temp, RT4_temp] = Get_allTS_AllTrials_4rawProcessingTime_alignCue(Antifilename,Best_Cue(n));
        allTS1 = [allTS1 allTS1_temp];
        allTS2 = [allTS2 allTS2_temp];
        allTS3 = [allTS3 allTS3_temp];
        allTS4 = [allTS4 allTS4_temp];
        RT1 = [RT1 RT1_temp];
        RT2 = [RT2 RT2_temp];
        RT3 = [RT3 RT3_temp];
        RT4 = [RT4 RT4_temp];
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(Best_Cue(n))])
    end
end

% Calculate latency using function QsumLatency
%4 rPT groups
[raster1_temp, stimon1_temp, maxoff1_temp, bin_edges1_temp] = Get_raster_for_latency(allTS1);
[on1_temp, off1_temp] = Neuron_Data_QsumLatency_alignCue(raster1_temp,stimon1_temp,maxoff1_temp,allTS1,bin_edges1_temp);
[raster2_temp, stimon2_temp, maxoff2_temp, bin_edges2_temp] = Get_raster_for_latency(allTS2);
[on2_temp, off2_temp] = Neuron_Data_QsumLatency_alignCue(raster2_temp,stimon2_temp,maxoff2_temp,allTS2,bin_edges2_temp);
[raster3_temp, stimon3_temp, maxoff3_temp, bin_edges3_temp] = Get_raster_for_latency(allTS3);
[on3_temp, off3_temp] = Neuron_Data_QsumLatency_alignCue(raster3_temp,stimon3_temp,maxoff3_temp,allTS3,bin_edges3_temp);
[raster4_temp, stimon4_temp, maxoff4_temp, bin_edges4_temp] = Get_raster_for_latency(allTS4);
[on4_temp, off4_temp] = Neuron_Data_QsumLatency_alignCue(raster4_temp,stimon4_temp,maxoff4_temp,allTS4,bin_edges4_temp);
ltc(1) = on1_temp;
ltc(2) = on2_temp;
ltc(3) = on3_temp;
ltc(4) = on4_temp;
p = Neuron_Data_latency_AntiSaccade_4rPT_aligncue_permutationtest(Neurons,RT1,RT2,RT3,RT4,ltc)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Directions = Get_Dir(Neurons)
Directions(1:length(Neurons),1:12) = NaN;
for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}([1:6]),'_2_',num2str(Neurons{n,2})];
    fn_matext = ([Antifilename([1:8]),'.mat']);
    load(fn_matext);
    Direction= unique([AllData.trials(:).Class]);
    Directions(n,1:12) = Direction(1:12);
end
end
function max_results = Get_Maxes(Neurons)
max_result(1:length(Neurons),1:3) = NaN;
for n = 1:length(Neurons)
    Profilename = [Neurons{n,1}([1:6]),'_1_',num2str(Neurons{n,2})];
    Antifilename = [Neurons{n,1}([1:6]),'_2_',num2str(Neurons{n,2})];
    temp = Neuron_Data_Maxcuerate_ProFrom4LOC(Profilename,Antifilename);
    max_results(n,1:length(temp)) = temp(1);
end
end
function max_results = Get_Maxes_sac(Neurons)
max_result(1:length(Neurons),1:3) = NaN;
for n = 1:length(Neurons)
    Profilename = [Neurons{n,1}([1:6]),'_1_',num2str(Neurons{n,2})];
    Antifilename = [Neurons{n,1}([1:6]),'_2_',num2str(Neurons{n,2})];
    temp = Neuron_Data_Maxsacrate_ProFrom4LOC(Profilename,Antifilename);
    max_results(n,1:length(temp)) = temp(1);
end
end
function [raster_temp stimon_temp maxoff_temp bin_edges_temp] = Get_raster_for_latency(TS)
bin_width = 0.01;  % 100 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.5:bin_step:.6;
bins = bin_edges+0.5*bin_width; %110 in total
raster_temp = histc(TS, bin_edges);

% window_width = 0.1;  % 100 milliseconds bin
% window_step = 0.01; %10 ms steps
% window_edges=-.5:bin_step:.5;
% windows = window_edges+0.5*window_width; %100 in total
% for i = 1:101
%     raster_temp(i) = sum(raster([i:i+10]));
% end
stimon_temp = find(round(bin_edges,2) == 0);
maxoff_temp = length(raster_temp);
bin_edges_temp = bin_edges;
end