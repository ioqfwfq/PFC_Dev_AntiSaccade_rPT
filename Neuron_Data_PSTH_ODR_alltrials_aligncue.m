% For ODR task
% Plot result from all trials pooled together
% Aligned by cue
% 09-Oct-2019, J Zhu

clear all
[Neurons_num Neurons_txt] = xlsread('test_MN.xlsx','young');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

% Best_Cue = Get_Maxes(Neurons);
% opp_index = [5 6 7 8 1 2 3 4 9];
% for n = 1:length(Best_Cue)
%     Opp_Cue(n) = opp_index(Best_Cue(n));
% end
Best_target = Get_Maxes_sac(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Best_target)
    Opp_target(n) = opp_index(Best_target(n));
end

for n = 1:length(Neurons)
    %     Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
%     Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    
    try
        [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignCue(Profilename,Best_target(n));
        psth1(n,:) = psth_temp;
        ntrs(n) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Profilename  '  Dir1=' num2str(Best_target(n))])
    end
    try
        [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignCue(Profilename,Opp_target(n));
        psth2(n,:) = psth_temp;
%         ntrs(n) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Profilename  '  Dir1=' num2str(Opp_target(n))])
    end
end

nn=sum(ntrs~=0);
ntrs=sum(ntrs);
definepsthmax=50;

% fig=openfig('figure2');
figure
set( gcf, 'Color', 'White', 'Unit', 'Normalized', ...
    'Position', [0.1,0.1,0.8,0.8] ) ;
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:2.5;
bins = bin_edges+0.5*bin_width;
hold on
try
    psthmean1 = sum(psth1)/nn;
catch
end
try
    plot(bins,psthmean1,'c','LineWidth',3);
catch
end
try
    psthmean2 = sum(psth2)/nn;
catch
end
try
    plot(bins,psthmean2,'m','LineWidth',3);
catch
end

line([2 2], [0 50],'color','k')
axis([-0.5 2.5 0 definepsthmax+0.2])
% xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
gtext({[num2str(nn) ' neurons ' num2str(ntrs) ' trials']},'color','k', 'FontWeight', 'Bold')


% axes( 'Position', [0, 0.95, 1, 0.05] ) ;
% set( gca, 'Color', 'None', 'XColor', 'None', 'YColor', 'None' ) ;
% text( 0.5, 0, 'PFC visual neurons Align Cue Best cue location', 'FontSize', 12', 'FontWeight', 'Bold', ...
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