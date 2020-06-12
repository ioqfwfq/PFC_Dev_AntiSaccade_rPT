function Neuron_Data_PSTH_ODR_alltrials_aligncue
% For ODR task
% Plot result from all trials pooled together
% Aligned on cue
% 29-Apr-2020, J Zhu

clear all
[Neurons_num, Neurons_txt] = xlsread('test_MN.xlsx','all');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Best_Cue = Get_Maxes(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Best_Cue)
    Opp_Cue(n) = opp_index(Best_Cue(n));
end
Opp_Sac = Get_Maxes_sac(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Opp_Sac)
    best_target(n) = opp_index(Opp_Sac(n));
end

for n = 1:length(Neurons)
%     Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
%     Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];

    try
        [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignCue_ext(Profilename,Opp_Sac(n));
        psth1(n,:) = psth_temp;
        ntrs1(n) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Profilename  '  Dir1=' num2str(Opp_Sac(n))])
    end
    try
        [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignCue_ext(Profilename,best_target(n));
        psth2(n,:) = psth_temp;
        ntrs2(n) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Profilename  '  Dir2=' num2str(best_target(n))])
    end
    
end

nn1=sum(ntrs1~=0);
ntrs1=sum(ntrs1);
nn2=sum(ntrs2~=0);
ntrs2=sum(ntrs2);
definepsthmax=30;

try
    psth1mean = sum(psth1)/nn1;
    psth2mean = sum(psth2)/nn2;
catch
end

figure
set(gcf, 'Color', 'White', 'Unit', 'Normalized', ...
    'Position', [0.2,0.2,0.7,0.7] );
set(gca ,'Color', 'White', 'XColor', 'k', 'YColor', 'k')
bin_width = 0.01;  % 10 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:3.0;
bins = bin_edges+0.5*bin_width; %381 in total
hold on
line([2 2],[0 definepsthmax])
patch([0 0.5 0.5 0], [0 0 definepsthmax definepsthmax], [0.9 0.9 0.9], 'EdgeColor', 'none')
try
    plot(bins,psth1mean,'c','LineWidth',2);
catch
end
try
    plot(bins,psth2mean,'m','LineWidth',2);
catch
end
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 3.0])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
gtext({[num2str(nn1) ' neurons ' num2str(ntrs1(1)) ' trials']},'color','k', 'FontWeight', 'Bold')

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