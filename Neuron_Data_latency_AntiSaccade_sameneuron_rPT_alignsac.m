function Neuron_Data_latency_AntiSaccade_sameneuron_rPT_alignsac
% For AntiSaccade task
% Plot result from all trials pooled together (4 groups of rPT, 1 condition for each group)
% Aligned on saccade on. J Zhu.
% 4-Feb-2020, smoothen the curve using sliding windows

clear all
% [Neurons_num Neurons_txt] = xlsread('database.xlsx','allPFC');
Data = load('61sameneurons');
warning off MATLAB:divideByZero
Neurons = Data.neuron;

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

ltc1 = [];
ltc2 = [];
ltc3 = [];
ltc4 = [];
for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
%     Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
%     Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    try
        [ltc1_temp, ltc2_temp, ltc3_temp, ltc4_temp, ntrs_temp] = Get_Latency_AllTrials_4rawProcessingTime_alignSac(Antifilename,best_target(n));
        ltc1 = [ltc1 ltc1_temp];
        ltc2 = [ltc2 ltc2_temp];
        ltc3 = [ltc3 ltc3_temp];
        ltc4 = [ltc4 ltc4_temp];
        ntrs(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(best_target(n))])
    end
end

ntrs=sum(ntrs);

ltc = nan(max(ntrs),4);

ltc(1:ntrs(1),1)=ltc1';
ltc(1:ntrs(2),2)=ltc2';
ltc(1:ntrs(3),3)=ltc3';
ltc(1:ntrs(4),4)=ltc4';

p = latency_4rPT_permutationtest(ltc1, ltc2, ltc3, ltc4)

% definepsthmax=50;

% % fig=openfig('samePFCneurons');
figure
set( gcf, 'Color', 'White', 'Unit', 'Normalized');
boxplot(ltc,'orientation', 'horizontal',...
     'widths',0.3)
set(gca ,'Color', 'White', 'XColor', 'k', 'YColor', 'k',...
    'XTick', [-0.5:0.1:0.5],'YTick', [1,2,3,4], 'YTickLabel',{'0-0.075', '0.075-0.120', '0.120-0.150', '>0.150'})
xlabel('Latency s')
ylabel('rPT s')
xlim([-0.5 0.5])
% gtext({[num2str(nn) ' neurons ' num2str(ntrsa(1)) '/' num2str(ntrsa(2)) '/' num2str(ntrsa(3)) '/' num2str(ntrsa(4)) ' trials']},'color','k', 'FontWeight', 'Bold')
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