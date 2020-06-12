function Neuron_Data_PSTH_ODR_alltrials_alignsac
% For ODR task
% Plot result from all trials pooled together
% Aligned on saccade
% 30-Apr-2020, J Zhu

clear all
[Neurons_num, Neurons_txt] = xlsread('test_MN.xlsx','all');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Opp_Sac = Get_Maxes_sac(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Opp_Sac)
    best_target(n) = opp_index(Opp_Sac(n));
end

for n = 1:length(Neurons)
%     Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
%     Errfilename = [Neurons1{n,1}(1:6),'_2_',num2str(Neurons1{n,2}),'_erriscuesac'];
    try
        [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignSac(Profilename,best_target(n));
        psth1(n,:) = psth_temp;
        ntrs1(n) = ntrs_temp;
        [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignSac(Profilename,Opp_Sac(n));
        psth2(n,:) = psth_temp;
        ntrs2(n) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Profilename  '  Dir1=' num2str(best_target(n))])
    end
end

nn1=sum(ntrs1~=0);
ntrs1=sum(ntrs1);
nn2=sum(ntrs2~=0);
ntrs2=sum(ntrs2);

definepsthmax=50;

% fig=openfig('figure2');
figure
set( gcf, 'Color', 'White', 'Unit', 'Normalized', ...
    'Position', [0.1,0.1,0.8,0.8] );
bin_width = 0.1;  % 100 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:1.5;
bins = bin_edges+0.5*bin_width; %231 in total
hold on
try
    psth1mean = sum(psth1)/nn1;
    psth2mean = sum(psth2)/nn2;
catch
end
try
    plot(bins,psth1mean,'c','LineWidth',3);
    plot(bins,psth2mean,'m','LineWidth',3);
catch
end

line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 1.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
gtext({[num2str(nn1) ' neurons ' num2str(ntrs1) ' trials']},'color','r', 'FontWeight', 'Bold')
% gtext({[num2str(nn2) ' neurons ' num2str(ntrs2) ' trials']},'color','b', 'FontWeight', 'Bold')

% axes( 'Position', [0, 0.95, 1, 0.05] );
% set( gca, 'Color', 'None', 'XColor', 'None', 'YColor', 'None' );
% text( 0.5, 0, 'PFC motor neurons Align saccade Best target location', 'FontSize', 12', 'FontWeight', 'Bold', ...
%     'HorizontalAlignment', 'Center', 'VerticalAlignment', 'middle' )
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
for n = 1:length(Neurons1)
    Profilename = [Neurons1{n,1}([1:6]),'_1_',num2str(Neurons1{n,2})];
    Antifilename = [Neurons1{n,1}([1:6]),'_2_',num2str(Neurons1{n,2})];
    temp = Neuron_Data_Maxcuerate_ProFrom4LOC(Profilename,Antifilename);
    max_results(n,1:length(temp)) = temp(1);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function max_results = Get_Maxes_sac(Neurons)
max_result(1:length(Neurons),1:3) = NaN;
for n = 1:length(Neurons)
    Profilename = [Neurons{n,1}([1:6]),'_1_',num2str(Neurons{n,2})];
    Antifilename = [Neurons{n,1}([1:6]),'_2_',num2str(Neurons{n,2})];
    temp = Neuron_Data_Maxsacrate_ProFrom4LOC(Profilename,Antifilename);
    max_results(n,1:length(temp)) = temp(1);
end
end