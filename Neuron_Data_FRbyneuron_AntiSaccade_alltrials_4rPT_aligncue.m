function y = Neuron_Data_FRbyneuron_AntiSaccade_alltrials_4rPT_aligncue
% For AntiSaccade task
% calculate the firing rate of certain epoch of certain trails
% Align cue, group by neuron, calculating mean rate of neurons then ANOVA
% 10-Jan-2019, J Zhu

clear all
[Neurons_num Neurons_txt] = xlsread('database.xlsx','allPFC');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Best_Cue = Get_Maxes(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Best_Cue)
    Opp_Cue(n) = opp_index(Best_Cue(n));
end
fr1 = [];
fr2 = [];
fr3 = [];
fr4 = [];
fr5 = [];
fr6 = [];
fr7 = [];
fr8 = [];

for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
%     Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    try
        [FR_temp1, FR_temp2, FR_temp3, FR_temp4, ntrs_temp] = Get_FRbyneuron_AllTrials_4rawProcessingTime_alignCue(Antifilename,Best_Cue(n));
        fr1 = [fr1 FR_temp1];
        fr3 = [fr3 FR_temp2];
        fr5 = [fr5 FR_temp3];
        fr7 = [fr7 FR_temp4];
        ntrs(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(Best_Cue(n))])
    end
    try
        [FR_temp1, FR_temp2, FR_temp3, FR_temp4, ntrs_temp] = Get_FRbyneuron_AllTrials_4rawProcessingTime_alignCue(Antifilename,Opp_Cue(n));
        fr2 = [fr2 FR_temp1];
        fr4 = [fr4 FR_temp2];
        fr6 = [fr6 FR_temp3];
        fr8 = [fr8 FR_temp4];
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir2=' num2str(Opp_Cue(n))])
    end
end

nn=sum(ntrs~=0);
ntrs=sum(ntrs);

y(:,1)=fr1;
y(:,2)=fr3;
y(:,3)=fr5;
y(:,4)=fr7;
[p,tbl,stats] = anova1(y);
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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