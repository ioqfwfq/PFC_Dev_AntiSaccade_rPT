function Neuron_Data_PSTH_AntiSaccade_alltrials_aligncue
% For AntiSaccade task
% Plot result from all trials pooled together
% Aligned on cue
% 27-May-2020, J Zhu

clear all
% [Neurons_num Neurons_txt] = xlsread('testErr.xlsx','MN');
% warning off MATLAB:divideByZero
% Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];
load('60samevisualneurons')
Neurons = [neuron(:,1) neuron(:,2)];

Opp_Sac = Get_Maxes_sac(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Opp_Sac)
    Best_target(n) = opp_index(Opp_Sac(n));
end

for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    %     Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
        Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    
%     try
%         [psth_temp, ntrs_temp] = Get_PsthM_partial_aligncue_test(Errfilename,Opp_Sac(n),0.075,0.150);
%         psth1(n,:) = psth_temp;
%         ntrs1(n) = ntrs_temp;
%     catch
%         disp(['error processing neuron  ', Errfilename  '  Dir1=' num2str(Opp_Sac(n))])
%     end
%     try
%         [psth_temp, ntrs_temp] = Get_PsthM_partial_aligncue_test(Errfilename,Best_target(n),0.075,0.150);
%         psth2(n,:) = psth_temp;
%         ntrs2(n) = ntrs_temp;
%     catch
%         disp(['error processing neuron  ', Errfilename  '  Dir2=' num2str(Best_target(n))])
%     end
    try
        [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignCue_test(Antifilename,Best_target(n));
        psth1(n,:) = psth_temp;
        ntrs1(n) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(Best_target(n))])
    end
    try
        [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignCue_test(Errfilename,Best_target(n));
        psth2(n,:) = psth_temp;
        ntrs2(n) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Errfilename  '  Dir2=' num2str(Best_target(n))])
    end
    
end

nn1=sum(ntrs1~=0);
ntrs1=sum(ntrs1);
nn2=sum(ntrs2~=0);
ntrs2=sum(ntrs2);
definepsthmax=50;

try
    psth1mean = sum(psth1)/nn1;
    psth2mean = sum(psth2)/nn2;
    for i = 1:length(psth1mean)-5
        psth1meanall(i) = mean(psth1mean([i:i+4]));
        psth2meanall(i) = mean(psth2mean([i:i+4]));
    end
catch
end

figure
set(gcf, 'Color', 'White', 'Unit', 'Normalized', ...
    'Position', [0.2,0.2,0.7,0.7] );
set(gca ,'Color', 'White', 'XColor', 'k', 'YColor', 'k')
bin_width = 0.01;  % 100 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:1.45;
bins = bin_edges+0.5*bin_width; %231 in total
hold on
patch([0 0.1 0.1 0], [0 0 definepsthmax definepsthmax], [0.9 0.9 0.9], 'EdgeColor', 'none')
try
    plot(bins,psth1meanall,'color',[0,1,1],'LineWidth',2);
catch
end
try
    plot(bins,psth2meanall,'color',[1,0,1],'LineWidth',2);
catch
end
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
% title('\color{black} 0-0.075s')
% legend('\color{green} correct','\color{gray} error')
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