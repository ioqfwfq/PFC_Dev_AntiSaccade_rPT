function Neuron_Data_FRbyneuron_AntiSaccade_alltrials_4rPT_alignsac
% For AntiSaccade task
% calculate the firing rate of certain epoch of certain trails
% Align on saccade onset
% 29-Apr-2020, J Zhu

clear all
[Neurons_num Neurons_txt] = xlsread('database.xlsx','allPFC');
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];
% warning off MATLAB:divideByZero
% load('61sameneurons')
% Neurons = [neuron(:,1) neuron(:,2)];

Opp_Sac = Get_Maxes_sac(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Opp_Sac)
    Best_target(n) = opp_index(Opp_Sac(n));
end

fr1 = [];
fr2 = [];
fr3 = [];
fr4 = [];

for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
%     Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    try
        [FR_temp1, FR_temp2, FR_temp3, FR_temp4, ntrs_temp] = Get_FRbyneuron_AllTrials_4rawProcessingTime_alignSac(Antifilename,Best_target(n));
        fr1 = [fr1 FR_temp1];
        fr2 = [fr2 FR_temp2];
        fr3 = [fr3 FR_temp3];
        fr4 = [fr4 FR_temp4];
        ntrs(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(Best_target(n))])
    end
end

nn=sum(ntrs~=0);
ntrs=sum(ntrs);

y(:,1)=fr1;
y(:,2)=fr2;
y(:,3)=fr3;
y(:,4)=fr4;
% [p,tbl,stats] = anova1(y);
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