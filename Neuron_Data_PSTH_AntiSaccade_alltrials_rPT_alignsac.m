% For AntiSaccade task
% Plot result from all trials pooled together (4 groups of rPT, 1 condition for each group)
% Aligned by saccade
% Fix the calculation of raw processing time for ALL trials. 19-Sep-2019, J Zhu
% Update plotting. Plot best cue location with its oppo location together
% in same figure. 09-Sep-2019, J Zhu

clear all
[Neurons_num Neurons_txt] = xlsread('inuse.xlsx','youngPFC');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Best_target = Get_Maxes_sac(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Best_target)
    Opp_Cue(n) = opp_index(Best_target(n));
end

for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
    try
        [psth_temp1, psth_temp2, psth_temp3, psth_temp4, ntrs_temp] = Get_PsthM_AllTrials_rawProcessingTime_alignSac(Antifilename,Best_target(n));
        psth1(n,:) = psth_temp1;
        psth3(n,:) = psth_temp2;
        psth5(n,:) = psth_temp3;
        psth7(n,:) = psth_temp4;
        ntrs(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(Best_target(n))])
    end
    try
        [psth_temp1, psth_temp2, psth_temp3, psth_temp4, ntrs_temp] = Get_PsthM_AllTrials_rawProcessingTime_alignSac(Antifilename,Opp_Cue(n));
        psth2(n,:) = psth_temp1;
        psth4(n,:) = psth_temp2;
        psth6(n,:) = psth_temp3;
        psth8(n,:) = psth_temp4;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir2=' num2str(Opp_Cue(n))])
    end
end

nn=sum(ntrs~=0);
ntrs=sum(ntrs);
definepsthmax=50;

fig=openfig('figure2');
% figure
% set( gcf, 'Color', 'White', 'Unit', 'Normalized', ...
%     'Position', [0.1,0.1,0.8,0.8] ) ;
subplot(2,2,1)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on
try
    psth1mean = sum(psth1)/nn(1);
    psth2mean = sum(psth2)/nn(1);
catch
end
try
    plot(bins,psth1mean,'b','LineWidth',3);
catch
end
% try
%     plot(bins,psth2mean,'b','LineWidth',3);
% catch
% end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('0-0.075s')
gtext({[num2str(nn(1)) ' neurons ' num2str(ntrs(1)) ' trials']},'color','b', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,2)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on

try
    psth3mean = sum(psth3)/nn(2);
    psth4mean = sum(psth4)/nn(2);
catch
end
try
    plot(bins,psth3mean,'b','LineWidth',3);
catch
end
% try
%     plot(bins,psth4mean,'b','LineWidth',3);
% catch
% end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('0.075-0.120s')
gtext({[num2str(nn(2)) ' neurons ' num2str(ntrs(2)) ' trials']},'color','b', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,3)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on

try
    psth5mean = sum(psth5)/nn(3);
    psth6mean = sum(psth6)/nn(3);
catch
end
try
    plot(bins,psth5mean,'b','LineWidth',3);
catch
end
% try
%     plot(bins,psth6mean,'b','LineWidth',3);
% catch
% end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('0.120-0.150s')
gtext({[num2str(nn(3)) ' neurons ' num2str(ntrs(3)) ' trials']},'color','b', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,4)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on

try
    psth7mean = sum(psth7)/nn(4);
    psth8mean = sum(psth8)/nn(4);    
catch
end
try
    plot(bins,psth7mean,'b','LineWidth',3);
catch
end
% try
%     plot(bins,psth8mean,'b','LineWidth',3);
% catch
% end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('>0.150s')
gtext({[num2str(nn(4)) ' neurons ' num2str(ntrs(4)) ' trials']},'color','b', 'FontWeight', 'Bold')

axes( 'Position', [0, 0.95, 1, 0.05] ) ;
set( gca, 'Color', 'None', 'XColor', 'None', 'YColor', 'None' ) ;
text( 0.5, 0, 'PFC neurons Align Sac Best saccade location', 'FontSize', 12', 'FontWeight', 'Bold', ...
    'HorizontalAlignment', 'Center', 'VerticalAlignment', 'middle' )

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
function max_results = Get_Maxes_sac(Neurons)
max_result(1:length(Neurons),1:3) = NaN;
for n = 1:length(Neurons)
    Profilename = [Neurons{n,1}([1:6]),'_1_',num2str(Neurons{n,2})];
    Antifilename = [Neurons{n,1}([1:6]),'_2_',num2str(Neurons{n,2})];
    temp = Neuron_Data_Maxsacrate_ProFrom4LOC(Profilename,Antifilename);
    max_results(n,1:length(temp)) = temp(1);
end
end