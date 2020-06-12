function Neuron_Data_PSTH_AntiSaccade_sameneuron_CandE_aligncue
% For AntiSaccade task
% Plot result from all trials pooled together
% Aligned on cue on
% only plot the neurons which have trials in CORRECT and ERROR trials
% 04-Feb-2020, J Zhu

clear all
[Neurons_num Neurons_txt] = xlsread('test_VN.xlsx','all');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Best_Cue = Get_Maxes(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Best_Cue)
    Opp_Cue(n) = opp_index(Best_Cue(n));
end


for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
    Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    try
        [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignCue(Antifilename,Best_Cue(n));
        psth1(n,:) = psth_temp;
        ntrs1(n) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(Best_Cue(n))])
    end
    try
        [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignCue(Errfilename,Best_Cue(n));
        psth2(n,:) = psth_temp;
        ntrs2(n) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Errfilename  '  Dir2=' num2str(Best_Cue(n))])
    end
end
jj=1;
neuron = [];
for j = 1:n-1
    if length(find(psth1(j,:)~= 0))>0 && length(find(psth2(j,:) ~= 0))>0
        psth1a(jj,:)=psth1(j,:);
        psth2a(jj,:)=psth2(j,:);
        ntrsa(jj,1)=ntrs1(j);
        ntrsa(jj,2)=ntrs2(j);
        neuron=[neuron; Neurons_txt(j,1) num2cell(Neurons_num(j,1))]
        jj=jj+1;
    end
end

nn=jj-1;
ntrsa=sum(ntrsa);
definepsthmax=50;

% fig=openfig('figure2');
figure
set( gcf, 'Color', 'White', 'Unit', 'Normalized', ...
    'Position', [0.2,0.2,0.7,0.7] ) ;

bin_width = 0.1;  % 100 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:1.4;
bins = bin_edges+0.5*bin_width; %231 in total
hold on
try
    psth1mean = sum(psth1a)/nn;
    psth2mean = sum(psth2a)/nn;
    for i = 1:221
        psth1meanall(i) = sum(psth1mean([i:i+10]));
        psth2meanall(i) = sum(psth2mean([i:i+10]));
    end
catch
end
try
    plot(bins,psth1meanall,'color',[0, 1 ,0],'LineWidth',4);
    plot(bins,psth2meanall,'color',[0.5, 0.2 ,0.5],'LineWidth',4);
catch
end
set(gca ,'Color', 'White', 'XColor', 'k', 'YColor', 'k')
% line([0 0], [0 50],'color','k')
patch([0 0.1 0.1 0], [0 0 definepsthmax definepsthmax], [0.8 0.8 0.8], 'EdgeColor', 'none')
try
    plot(bins,psth2meanall,'color',[0.5, 0.2 ,0.5],'LineWidth',4);
    plot(bins,psth1meanall,'color',[0, 1 ,0],'LineWidth',4);
    
catch
end
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
legend('\color{black} correct','\color{black} error')
gtext({[num2str(nn) ' neurons ' num2str(ntrsa(1)) '/' num2str(ntrsa(2)) ' trials']},'color','k', 'FontWeight', 'Bold')

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