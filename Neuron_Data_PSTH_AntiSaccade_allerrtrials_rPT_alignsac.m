function Neuron_Data_PSTH_AntiSaccade_allerrtrials_rPT_alignsac
% For AntiSaccade task
% Plot result from error trials whose error is saccade to cue
% Align on saccade
% 04-Feb-2020, J Zhu

[Neurons_num Neurons_txt] = xlsread('test_MN.xlsx','all');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Opp_Sac = Get_Maxes_sac(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Opp_Sac)
    Best_target(n) = opp_index(Opp_Sac(n));
end

for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
%     Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    try
        [psth_temp1, psth_temp2, psth_temp3, psth_temp4, ntrs_temp] = Get_PsthM_AllTrials_4rawProcessingTime_alignSac(Antifilename,Best_target(n));
        psth1(n,:) = psth_temp1;
        psth3(n,:) = psth_temp2;
        psth5(n,:) = psth_temp3;
        psth7(n,:) = psth_temp4;
        ntrs(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(Best_target(n))])
    end
    try
        [psth_temp1, psth_temp2, psth_temp3, psth_temp4, ntrs_temp] = Get_PsthM_AllTrials_4rawProcessingTime_alignSac(Antifilename,Opp_Sac(n));
        psth2(n,:) = psth_temp1;
        psth4(n,:) = psth_temp2;
        psth6(n,:) = psth_temp3;
        psth8(n,:) = psth_temp4;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir2=' num2str(Opp_Sac(n))])
    end
end

nn=sum(ntrs~=0);
ntrs=sum(ntrs);
definepsthmax=50;
try
    psth1mean = sum(psth1)/nn(1);
    psth2mean = sum(psth2)/nn(1);
    for i = 1:221
        psth1meanall(i) = sum(psth1mean([i:i+10]));
        psth2meanall(i) = sum(psth2mean([i:i+10]));
    end
catch
end
try
    psth3mean = sum(psth3)/nn(2);
    psth4mean = sum(psth4)/nn(2);
    for i = 1:221
        psth3meanall(i) = sum(psth3mean([i:i+10]));
        psth4meanall(i) = sum(psth4mean([i:i+10]));
    end
catch
end
try
    psth5mean = sum(psth5)/nn(3);
    psth6mean = sum(psth6)/nn(3);
    for i = 1:221
        psth5meanall(i) = sum(psth5mean([i:i+10]));
        psth6meanall(i) = sum(psth6mean([i:i+10]));
    end
catch
end
try
    psth7mean = sum(psth7)/nn(4);
    psth8mean = sum(psth8)/nn(4);
    for i = 1:221
        psth7meanall(i) = sum(psth7mean([i:i+10]));
        psth8meanall(i) = sum(psth8mean([i:i+10]));
    end
catch
end

% fig=openfig('figure2');
figure
set( gcf, 'Color', 'White', 'Unit', 'Normalized', ...
    'Position', [0.2,0.2,0.7,0.7] ) ;
subplot(2,2,1)
set(gca ,'Color', 'White', 'XColor', 'k', 'YColor', 'k')
bin_width = 0.1;  % 100 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:1.4;
bins = bin_edges+0.5*bin_width; %231 in total
hold on
try
    plot(bins,psth1meanall,'c','LineWidth',3);
catch
end
try
    plot(bins,psth2meanall,'m','LineWidth',3);
catch
end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('\color{black} 0-0.075s')
legend('\color{cyan} TargetIn','\color{magenta} TargetOut')
gtext({[num2str(nn(1)) ' neurons ' num2str(ntrs(1)) ' trials']},'color','k', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,2)
set(gca ,'Color', 'White', 'XColor', 'k', 'YColor', 'k')
bin_width = 0.1;  % 100 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:1.4;
bins = bin_edges+0.5*bin_width; %231 in total
hold on

try
    plot(bins,psth3meanall,'c','LineWidth',3);
catch
end
try
    plot(bins,psth4meanall,'m','LineWidth',3);
catch
end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('\color{black} 0.075-0.120s')
gtext({[num2str(nn(2)) ' neurons ' num2str(ntrs(2)) ' trials']},'color','k', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,3)
set(gca ,'Color', 'White', 'XColor', 'k', 'YColor', 'k')
bin_width = 0.1;  % 100 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:1.4;
bins = bin_edges+0.5*bin_width; %231 in total
hold on

try
    plot(bins,psth5meanall,'c','LineWidth',3);
catch
end
try
    plot(bins,psth6meanall,'m','LineWidth',3);
catch
end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('\color{black} 0.120-0.150s')
gtext({[num2str(nn(3)) ' neurons ' num2str(ntrs(3)) ' trials']},'color','k', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,4)
set(gca ,'Color', 'White', 'XColor', 'k', 'YColor', 'k')
bin_width = 0.1;  % 100 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:1.4;
bins = bin_edges+0.5*bin_width; %231 in total
hold on

try
    plot(bins,psth7meanall,'c','LineWidth',3);
catch
end
try
    plot(bins,psth8meanall,'m','LineWidth',3);
catch
end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('\color{black} >0.150s')
gtext({[num2str(nn(4)) ' neurons ' num2str(ntrs(4)) ' trials']},'color','k', 'FontWeight', 'Bold')

axes( 'Position', [0, 0.95, 1, 0.05] ) ;
set( gca, 'Color', 'None') ;
text( 0.5, 0, 'PFC neurons Align Sac Best cue location/opposite location', 'Color', 'k', 'FontSize', 12', 'FontWeight', 'Bold', ...
    'HorizontalAlignment', 'Center', 'VerticalAlignment', 'middle' )
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