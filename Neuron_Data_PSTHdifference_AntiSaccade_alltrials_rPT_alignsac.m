% For AntiSaccade task
% Plot result from all trials pooled together (3 groups of rPT, 1 condition for each group)
% Align on saccade
% calculate the PSTH difference between best and opposite location
% J zhu, Nov. 2019

clear all
[Neurons_num Neurons_txt] = xlsread('database.xlsx','youngPFC');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Best_Cue = Get_Maxes(Neurons);
Opp_Sac = Get_Maxes_sac(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Opp_Sac)
    Best_target(n) = opp_index(Opp_Sac(n));
end

for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
    try
        [psth_temp1, psth_temp2, psth_temp3, ntrs_temp] = Get_PsthM_AllTrials_3rawProcessingTime_alignSac(Antifilename,Best_target(n));
        psth1(n,:) = psth_temp1;
        psth3(n,:) = psth_temp2;
        psth5(n,:) = psth_temp3;
        ntrs1(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(Best_target(n))])
    end
    try
        [psth_temp1, psth_temp2, psth_temp3, ntrs_temp] = Get_PsthM_AllTrials_3rawProcessingTime_alignSac(Antifilename,Opp_Sac(n));
        psth2(n,:) = psth_temp1;
        psth4(n,:) = psth_temp2;
        psth6(n,:) = psth_temp3;
        ntrs2(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir2=' num2str(Opp_Sac(n))])
    end
end

nn1=sum(ntrs1~=0);
nn2=sum(ntrs2~=0);
ntrs1=sum(ntrs1);
ntrs2=sum(ntrs2);
definepsthmax=18;

fig=openfig('figure2');
% figure
% set( gcf, 'Color', 'White', 'Unit', 'Normalized', ...
%     'Position', [0.1,0.1,0.8,0.8] ) ;
subplot(1,3,1)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on
try
    psth1mean = sum(psth1)/nn1(1);
    psth2mean = sum(psth2)/nn2(1);
    d1=psth1mean-psth2mean;
catch
end
try
    plot(bins,d1,'b','LineWidth',3);
catch
end
line([0 0], [-25 25],'color','k')
axis([-0.5 1.5 -10 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('0-0.080s')
gtext({[num2str(nn1(1)) ' neurons ' num2str(ntrs1(1)) ' trials']},'color','b', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,3,2)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on
try
    psth3mean = sum(psth3)/nn1(2);
    psth4mean = sum(psth4)/nn2(2);
    d2=psth3mean-psth4mean;
catch
end
try
    plot(bins,d2,'b','LineWidth',3);
catch
end
line([0 0], [-25 25],'color','k')
axis([-0.5 1.5 -10 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('0.080-0.140s')
gtext({[num2str(nn1(2)) ' neurons ' num2str(ntrs1(2)) ' trials']},'color','b', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(1,3,3)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on
try
    psth5mean = sum(psth5)/nn1(3);
    psth6mean = sum(psth6)/nn2(3);
    d3=psth5mean-psth6mean;
catch
end
try
    plot(bins,d3,'b','LineWidth',3);
catch
end
line([0 0], [-25 50],'color','k')
axis([-0.5 1.5 -10 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('>0.140s')
gtext({[num2str(nn1(3)) ' neurons ' num2str(ntrs1(3)) ' trials']},'color','b', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes( 'Position', [0, 0.95, 1, 0.05] ) ;
set( gca, 'Color', 'None', 'XColor', 'None', 'YColor', 'None' ) ;
text( 0.5, 0, 'PFC neurons Align Sac highest saccade responds - lowest saccade responds', 'FontSize', 12', 'FontWeight', 'Bold', ...
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