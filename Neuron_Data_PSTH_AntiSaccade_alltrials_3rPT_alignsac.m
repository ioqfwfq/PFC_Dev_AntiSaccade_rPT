% For AntiSaccade task
% Plot result from all trials pooled together (3 groups of rPT, 1 condition for each group)
% Align on saccade

clear all
[Neurons_num Neurons_txt] = xlsread('test_VN.xlsx','all');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Best_Cue = Get_Maxes(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Best_Cue)
    Opp_Cue(n) = opp_index(Best_Cue(n));
end
Opp_Sac = Get_Maxes_sac(Neurons);
for n = 1:length(Opp_Sac)
    best_target(n) = opp_index(Opp_Sac(n));
end

for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
    Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    try
        [psth_temp1, psth_temp2, psth_temp3, ntrs_temp] = Get_PsthM_AllTrials_3rawProcessingTime_alignSac(Errfilename,Opp_Cue(n));
        psth1(n,:) = psth_temp1;
        psth3(n,:) = psth_temp2;
        psth5(n,:) = psth_temp3;
        ntrs1(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(Opp_Cue(n))])
    end
    try
        [psth_temp1, psth_temp2, psth_temp3, ntrs_temp] = Get_PsthM_AllTrials_3rawProcessingTime_alignSac(Errfilename,Best_Cue(n));
        psth2(n,:) = psth_temp1;
        psth4(n,:) = psth_temp2;
        psth6(n,:) = psth_temp3;
        ntrs2(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir2=' num2str(Best_Cue(n))])
    end
end

nn1=sum(ntrs1~=0);
ntrs1=sum(ntrs1);
nn2=sum(ntrs2~=0);
ntrs2=sum(ntrs2);
definepsthmax=40;

% fig=openfig('figure2');
figure
set( gcf, 'Color', 'White', 'Unit', 'Normalized', ...
    'Position', [0.1,0.1,0.8,0.8] ) ;
subplot(3,1,1)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on
try
    psth1mean = sum(psth1)/nn1(1);
    psth2mean = sum(psth2)/nn2(1);
    psth1meannorm = psth1mean-mean(psth1mean([1:12]));
    psth2meannorm = psth2mean-mean(psth2mean([1:12]));
catch
end
try
    plot(bins,psth1meannorm,'--c','LineWidth',2);
%     plot(bins,psth1meannorm,'r','LineWidth',2);
catch
end
try
%     plot(bins,psth2meannorm,'color',[0,1,0],'LineWidth',2);
    plot(bins,psth2meannorm,'--','color',[0,0,1],'LineWidth',2);
catch
end
line([0 0], [-10 50],'color','k')
axis([-0.5 1.5 -10 definepsthmax+0.2])
xlim([-0.5 0.8])
xlabel('Time s')
ylabel('Normalized Firing Rate spikes/s')
title('0-0.080s')
% gtext({[num2str(nn1(1)) ' neurons ' num2str(ntrs1(1)) ' trials']},'color','k', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,1,2)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on

try
    psth3mean = sum(psth3)/nn1(2);
    psth4mean = sum(psth4)/nn2(2);
    psth3meannorm = psth3mean-mean(psth3mean([1:12]));
    psth4meannorm = psth4mean-mean(psth4mean([1:12]));
catch
end
try
    plot(bins,psth3meannorm,'--c','LineWidth',2);
%     plot(bins,psth3meannorm,'r','LineWidth',2);
catch
end
try
%     plot(bins,psth4meannorm,'color',[0,1,0],'LineWidth',2);
    plot(bins,psth4meannorm,'--','color',[0,0,1],'LineWidth',2);
catch
end
line([0 0], [-10 50],'color','k')
axis([-0.5 1.5 -10 definepsthmax+0.2])
xlim([-0.5 0.8])
xlabel('Time s')
ylabel('Normalized Firing Rate spikes/s')
title('0.080-0.140s')
% gtext({[num2str(nn1(2)) ' neurons ' num2str(ntrs1(2)) ' trials']},'color','k', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,1,3)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on

try
    psth5mean = sum(psth5)/nn1(3);
    psth6mean = sum(psth6)/nn2(3);    
    psth5meannorm = psth5mean-mean(psth5mean([1:12]));
    psth6meannorm = psth6mean-mean(psth6mean([1:12]));
    catch
end
try
    plot(bins,psth5meannorm,'--c','LineWidth',2);
%     plot(bins,psth5meannorm,'r','LineWidth',2);
catch
end
try
%     plot(bins,psth6meannorm,'color',[0,1,0],'LineWidth',2);
    plot(bins,psth6meannorm,'--','color',[0,0,1],'LineWidth',2);
catch
end
line([0 0], [-10 50],'color','k')
axis([-0.5 1.5 -10 definepsthmax+0.2])
xlim([-0.5 0.8])
xlabel('Time s')
ylabel('Normalized Firing Rate spikes/s')
title('>0.140s')
% gtext({[num2str(nn1(3)) ' neurons ' num2str(ntrs1(3)) ' trials']},'color','k', 'FontWeight', 'Bold')

% axes( 'Position', [0, 0.95, 1, 0.05] ) ;
% set( gca, 'Color', 'None', 'XColor', 'None', 'YColor', 'None' ) ;
% text( 0.5, 0, 'PFC neurons Align Cue Best cue location/opposite location', 'FontSize', 12', 'FontWeight', 'Bold', ...
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