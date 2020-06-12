% For AntiSaccade task
% Plot result from all trials pooled together (4 groups of rPT, 1 condition for each group)
% Aligned on saccade. J Zhu.

clear all
[Neurons_num Neurons_txt] = xlsread('database.xlsx','allPFC');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Opp_Sac = Get_Maxes_sac(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Opp_Sac)
    best_target(n) = opp_index(Opp_Sac(n));
    % The Best_target location is the best saccade location determined by
    % prosaccade task, which makes the correct trials and error trials both have
    % saccade in the receptive field. The class is the diametric class of the
    % best saccade class in prosaccade task for correct trials and the same
    % class for error trials.
end

for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
    Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    try
        [psth_temp1, psth_temp2, psth_temp3, ntrs_temp] = Get_PsthM_AllTrials_3rawProcessingTime_alignSac(Antifilename,best_target(n));
        psth1(n,:) = psth_temp1;
        psth3(n,:) = psth_temp2;
        psth5(n,:) = psth_temp3;
        ntrs(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(best_target(n))])
    end
    try
        [psth_temp1, psth_temp2, psth_temp3, ntrs_temp] = Get_PsthM_AllTrials_3rawProcessingTime_alignSac(Antifilename,Opp_Sac(n));
        psth2(n,:) = psth_temp1;
        psth4(n,:) = psth_temp2;
        psth6(n,:) = psth_temp3;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir2=' num2str(Opp_Sac(n))])
    end
end
nn=sum(ntrs~=0);
ntrs=sum(ntrs);
definepsthmax=15;

figure
set( gcf, 'Color', 'White', 'Unit', 'Normalized', ...
    'Position', [0.1,0.1,0.8,0.8] );
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on
try
    psth1mean = sum(psth1-psth2)/nn(1);
    psth3mean = sum(psth3-psth4)/nn(2);
    psth5mean = sum(psth5-psth6)/nn(3);
catch
end
try
    plot(bins,psth1mean,'color',[1,0.6,0.6],'LineWidth',3);
    plot(bins,psth3mean,'color',[1,0.2,0.2],'LineWidth',3);
    plot(bins,psth5mean,'color',[0.8,0,0],'LineWidth',3);
catch
end

line([0 0], [-10 50],'color','k')
axis([-0.5 1.5 -5 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
gtext({[num2str(nn) ' neurons ' num2str(ntrs) ' trials']},'color','k', 'FontWeight', 'Bold')

% axes( 'Position', [0, 0.95, 1, 0.05] ) ;
% set( gca, 'Color', 'None', 'XColor', 'None', 'YColor', 'None' ) ;
% text( 0.5, 0, 'PFC neurons Align on Sacaade', 'FontSize', 12', 'FontWeight', 'Bold', ...
%     'HorizontalAlignment', 'Center', 'VerticalAlignment', 'middle' )
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