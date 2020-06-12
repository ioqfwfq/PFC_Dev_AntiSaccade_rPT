[Neurons_num Neurons_txt] = xlsread('PSTH_class1_18CAE216DAN360_PFCLIPtr_4loc+.xls');
% This script runs bootstrap analysis by sampling the same number of nurons as 
% the real population from a mixed population (PFC and LIP populations area combined in the excel sheet)
% and compute Target Discrimination Processing Time (Time of target discrimination - Latency). 
% Repeat this for desirble times (e.g. 1000 times) with or without replacement.
% The actual population TDPTs are assumed to be computed for each area using
% the script named Neuron_Data_AutpTDTPclass1_18slide. Those values will be loaded beginning
% of this script to compute the pvalue in the end.
% Edited: Jun 22 2011 FK

warning off MATLAB:divideByZero
%%% CHANGE PARAMETERS %%%
Area1 = 'PFC' 
Area2 = 'LIP'
filerange = 'CAE216DAN360tr4+' % the last numbers of datafile used (DAN&CAE)
t = 0.001 % sliding time (eg 10ms)
tw = 0.01 % Time window to find firing rate (eg 40ms)
tms = t*1000; % Convert sliding time sec to msec
twms = tw*1000; % Convert time window sec to msec
samplesize1 = 100 % 278 % sample size per randsample for Area1 (Use the actual poplation size of this area)
samplesize2 = 100 % 187 % sample size per randsample for Area2 (Use the actual poplation size of this area)
nrandsample = 1000 % how many times to randsample
%%%%%%%%%%%%%%%%%%%%%%%%

TDPTfile1 = ['TDPTclass1-18_',Area1,'_',filerange,'_TW',num2str(twms),'TI',num2str(tms),'ms.dat'];
TDPTfile2 = ['TDPTclass1-18_',Area2,'_',filerange,'_TW',num2str(twms),'TI',num2str(tms),'ms.dat'];
TDPTarea1 = load(TDPTfile1);
TDPTarea2 = load(TDPTfile2);
TDPTdiffreal = TDPTarea2-TDPTarea1;

Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];
cuetime = -0.1:t:0.5-t; 
% TDPTboot1(1:nrandsample) = NaN;
TDPTboot2(1:nrandsample) = NaN;

nneurons = 1:length(Neurons);
% %%%% AREA 1 %%%%
disp('Area1');
for nrep = 1:nrandsample
    disp(nrep);
    y = randsample(nneurons, samplesize1, false); % replacement: true
    results_all(1:length(y),1:length(cuetime))=NaN;
    for n = 1:length(y)
    filename = [Neurons{y(n),1},'_',num2str(Neurons{y(n),2})]; % Extract Timestamp (TS) from one datafile
    [FR_max FR_opp FR_maxbase FR_oppbase] = Neuron_Data_TDPTclass1_18slide(filename,t,tw);
   
    allFR_max(n,:) = FR_max; % all firing rate of max location extracted from all datafiles
    allFR_opp(n,:) = FR_opp; % all firing rate of opp location extracted from all datafiles
    
%     m_maxbase = ones(1,size(allFR_max,2))*mean(FR_maxbase);
%     m_oppbase = ones(1,size(allFR_opp,2))*mean(FR_oppbase);
    m_maxbase = ones(1,length(cuetime))*mean(FR_maxbase);
    m_oppbase = ones(1,length(cuetime))*mean(FR_oppbase);
    allFR_maxbase(n,:) = m_maxbase; % make the same size matrix as allFR_max with firing rate of mean FR
    allFR_oppbase(n,:) = m_oppbase; % make the same size matrix as allFR_opp with firing rate of mean FR
    end

%%%%% Determine TTD and Latency Using Paired t-test %%%%%%%%%%%%%%%%%%%%%%%
%%%%% Left aligned bin %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Time of Target Discrimination (TTD) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
allpval = [];
for i = 1:length(allFR_max) % number of time window
    [h p] = ttest(allFR_max(:,i), allFR_opp(:,i)); % Paired ttest
    allpval = [allpval p];
end
TTDallresults = [cuetime',allpval'];
% Find the first bin of 10 consecutive sig pvalues %
TTDsigpval = find(TTDallresults(:,1)>0.05 & TTDallresults(:,2)<0.05);
TTDall = [];
for j = 1:length(TTDsigpval)-10
    if TTDsigpval(j+9) == TTDsigpval(j)+9
        TTDall = [TTDall TTDsigpval(j)];
    else
        continue
    end
end
TTD = TTDallresults(min(TTDall),1); %%% This is the time of target discrimination of each sample group

%%%%% Visual Response Latency (VRL) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
allFR_maxL = allFR_max(:,1:length(cuetime)); % TS for Latency
allFR_oppL = allFR_opp(:,1:length(cuetime)); % TS for Latency
allpval_max = [];
allpval_opp = [];
for i = 1:length(allFR_maxL) % number of time window
    [hm pm] = ttest(allFR_maxL(:,i), allFR_maxbase(:,i)); % Paired ttest for max vs. maxbase
    allpval_max = [allpval_max pm];
    [ho po] = ttest(allFR_oppL(:,i), allFR_oppbase(:,i)); % Paired ttest for opp vs. oppbase
    allpval_opp = [allpval_opp po];
end
VRLallresults = [cuetime',allpval_max',allpval_opp'];
% Find the first bin of 10 consecutive sig pvalues, use max classes %
VRLsigpval = find(VRLallresults(:,1)>0 & VRLallresults(:,2)<0.05);
VRLall = [];
for j = 1:length(VRLsigpval)-10
    if VRLsigpval(j+9) == VRLsigpval(j)+9
        VRLall = [VRLall VRLsigpval(j)];
    else
        continue
    end
end
VRL = VRLallresults(min(VRLall),1); %%% This is the time of target discrimination of each sample group

%%%%% Target Discrimination Processing Time (TDPT) %%%%%%%%%%%%%%%%%%%%%%%%
TDPTboot1(nrep) = TTD-VRL;
end

%%%% AREA 2 %%%%
disp('Area2')
for nrep = 1:nrandsample
    disp(nrep);
    y = randsample(nneurons, samplesize2, false); % replacement: true
    results_all(1:length(y),1:length(cuetime))=NaN;
    for n = 1:length(y)
    filename = [Neurons{y(n),1},'_',num2str(Neurons{y(n),2})]; % Extract Timestamp (TS) from one datafile
    [FR_max FR_opp FR_maxbase FR_oppbase] = Neuron_Data_TDPTclass1_18slide(filename,t,tw);
    
    allFR_max2(n,:) = FR_max; % all firing rate of max location extracted from all datafiles
    allFR_opp2(n,:) = FR_opp; % all firing rate of opp location extracted from all datafiles
    
%     m_maxbase2 = ones(1,size(allFR_max2,2))*mean(FR_maxbase);
%     m_oppbase2 = ones(1,size(allFR_opp2,2))*mean(FR_oppbase);
    m_maxbase2 = ones(1,length(cuetime))*mean(FR_maxbase);
    m_oppbase2 = ones(1,length(cuetime))*mean(FR_oppbase);
    allFR_maxbase2(n,:) = m_maxbase2; % make the same size matrix as allFR_max with firing rate of mean FR
    allFR_oppbase2(n,:) = m_oppbase2; % make the same size matrix as allFR_opp with firing rate of mean FR
    end

%%%%% Determine TTD and Latency Using Paired t-test %%%%%%%%%%%%%%%%%%%%%%%
%%%%% Left aligned bin %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Time of Target Discrimination (TTD) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
allpval2 = [];
for i = 1:length(allFR_max2) % number of time window
    [h p] = ttest(allFR_max2(:,i), allFR_opp2(:,i)); % Paired ttest
    allpval2 = [allpval2 p];
end
TTDallresults2 = [cuetime',allpval2'];
% Find the first bin of 10 consecutive sig pvalues %
TTDsigpval2 = find(TTDallresults2(:,1)>0.05 & TTDallresults2(:,2)<0.05);
TTDall2 = [];
for j = 1:length(TTDsigpval2)-10
    if TTDsigpval2(j+9) == TTDsigpval2(j)+9
        TTDall2 = [TTDall2 TTDsigpval2(j)];
    else
        continue
    end
end
TTD2 = TTDallresults2(min(TTDall2),1); %%% This is the time of target discrimination of each sample group

%%%%% Visual Response Latency (VRL) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
allFR_maxL2 = allFR_max2(:,1:length(cuetime)); % TS for Latency
allFR_oppL2 = allFR_opp2(:,1:length(cuetime)); % TS for Latency
allpval_max2 = [];
allpval_opp2 = [];
for i = 1:length(allFR_maxL2) % number of time window
    [hm pm] = ttest(allFR_maxL2(:,i), allFR_maxbase2(:,i)); % Paired ttest for max vs. maxbase
    allpval_max2 = [allpval_max2 pm];
    [ho po] = ttest(allFR_oppL2(:,i), allFR_oppbase2(:,i)); % Paired ttest for opp vs. oppbase
    allpval_opp2 = [allpval_opp2 po];
end
VRLallresults2 = [cuetime',allpval_max2',allpval_opp2'];
% Find the first bin of 10 consecutive sig pvalues, use max classes %
VRLsigpval2 = find(VRLallresults2(:,1)>0 & VRLallresults2(:,2)<0.05);
VRLall2 = [];
for j = 1:length(VRLsigpval2)-10
    if VRLsigpval2(j+9) == VRLsigpval2(j)+9
        VRLall2 = [VRLall2 VRLsigpval2(j)];
    else
        continue
    end
end
VRL2 = VRLallresults2(min(VRLall2),1); %%% This is the time of target discrimination of each sample group

%%%%% Target Discrimination Processing Time (TDPT) %%%%%%%%%%%%%%%%%%%%%%%%
TDPTboot2(nrep) = TTD2-VRL2;
end

TDPTdiffboot = TDPTboot2-TDPTboot1;
p = length(find(TDPTdiffboot>=TDPTdiffreal))/nrandsample

allresults.TDPTbootArea1 = TDPTboot1;
allresults.TDPTbootArea2 = TDPTboot2;
allresults.TDPTdiffboot = TDPTdiffboot';
allresults.TDPTdiffreal = TDPTdiffreal;
allresults.pval = p;
save(['TDPTboot',num2str(nrandsample),'class1-18_',Area1,num2str(samplesize1),Area2,num2str(samplesize2),'_',filerange,'_TW',num2str(twms),'TI',num2str(tms),'ms.mat'],'allresults' )
disp('done')

