[Neurons_num Neurons_txt] = xlsread('PSTH_DifftaskCAE216DAN288_PFCtr_all.xls');
% This script perform paired t-test on firing rate in certain time window 
% (10/20ms) with stimulus in RF/out RF and baseline firing (extracted from 
% certain time window and averaged, e.g -100ms to 0). 
% It automatically runs Neuron_Data_PSTHsaliencyDifftask on the list of neurons on 
% the excel sheet and extract firing rate within each time window from each datafile (neuron). 
% This is for the difficulty task.
% Last edited: Oct 14 2009 
% By Fumi Katsuki

warning off MATLAB:divideByZero

%%% CHANGE PARAMETERS %%%
Area = 'PFC' %'PPC'
filerange = 'CAE216DAN288tr' % the last numbers of datafile used (DAN&CAE)
t = 0.02 % Time window to find firing rate (10ms)
tms = t*1000; % Convert time window sec to msec
level = 4 % Difficulty level (1-4)
%%%%%%%%%%%%%%%%%%%%%%%%%

Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

for n = 1:length(Neurons)
    filename = [Neurons{n,1},'_',num2str(Neurons{n,2})]; % Extract Timestamp (TS) from one datafile
    [allTS1,allTS2,allTS3,allTS4,allTS_opp1,allTS_opp2,allTS_opp3,allTS_opp4, ntrss, ntrss_opp] = Neuron_Data_PSTHsaliencyDifftask(filename);
    FR_max = [];
    FR_opp = [];
    for startt = -1:t:2.5 % start point of time window    
        TS_max = eval(['allTS' num2str(level) '(find(allTS' num2str(level) '>= startt & allTS' num2str(level) '< startt+t))']); % find TS of max response calss (array class) that falls in the time window 
        FR_maxone = eval(['length(TS_max)/(t*ntrss(' num2str(level) '))']); % Calculate firing rate (FR)
        FR_max = [FR_max FR_maxone];
        TS_opp = eval(['allTS_opp' num2str(level) '(find(allTS_opp' num2str(level) '>= startt & allTS_opp' num2str(level) '< startt+t))']); % find TS of opp response calss (array class) that falls in the time window 
        FR_oppone = eval(['length(TS_opp)/(t*ntrss_opp(' num2str(level) '))']); % Calculate firing rate(FR)
        FR_opp = [FR_opp FR_oppone];
    end
    allFR_max(n,:) = FR_max; % all firing rate of max location extracted from all datafiles
    allFR_opp(n,:) = FR_opp; % all firing rate of opp location extracted from all datafiles
    
    FR_maxbase = [];
    FR_oppbase = [];
    for startt2 = -0.1:t:0 % Use -100ms to 0 to get the baseline firing rates
        TS_max = eval(['allTS' num2str(level) '(find(allTS' num2str(level) '>= startt2 & allTS' num2str(level) '< startt2+t))']); % find TS of max response calss (array class) that falls in the time window 
        FR_maxone = eval(['length(TS_max)/(t*ntrss(' num2str(level) '))']); % Calculate firing rate (FR)
        FR_maxbase = [FR_maxbase FR_maxone];
        TS_opp = eval(['allTS_opp' num2str(level) '(find(allTS_opp' num2str(level) '>= startt2 & allTS_opp' num2str(level) '< startt2+t))']); % find TS of opp response calss (array class) that falls in the time window 
        FR_oppone = eval(['length(TS_opp)/(t*ntrss_opp(' num2str(level) '))']); % Calculate firing rate(FR)
        FR_oppbase = [FR_oppbase FR_oppone];
    end
    m_maxbase = ones(1,size(allFR_max,2))*mean(FR_maxbase);
    m_oppbase = ones(1,size(allFR_opp,2))*mean(FR_oppbase);
    allFR_maxbase(n,:) = m_maxbase; % make the same size matrix as allFR_max with firing rate of mean FR
    allFR_oppbase(n,:) = m_oppbase; % make the same size matrix as allFR_opp with firing rate of mean FR
end


%%%%%Paired t-test%%%%%%%%%%%%%%
allpval_max = [];
allpval_opp = [];
for i = 1:(3.5/t) % number of time window
[hm pm] = ttest(allFR_max(:,i), allFR_maxbase(:,i)); % Paired ttest for max vs. maxbase
allpval_max = [allpval_max pm];
[ho po] = ttest(allFR_opp(:,i), allFR_oppbase(:,i)); % Paired ttest for opp vs. oppbase
allpval_opp = [allpval_opp po];
end
time = -1:t:2.5;
time = time(1:length(time)-1);

allresults = [time',allpval_max',allpval_opp'];
csvwrite(['ttestLatency_PSTHDifftask_',Area,'_',filerange,'_',num2str(tms),'msLevel' num2str(level), '.dat'],allresults)

disp('done')

