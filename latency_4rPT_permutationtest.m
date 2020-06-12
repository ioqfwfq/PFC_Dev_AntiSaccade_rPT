function p = latency_4rPT_permutationtest
% For AntiSaccade task
% Show result from all trials pooled together (4 groups of rPT, 1 condition for each group)
% Aligned on saccade onset.
% The analysis was performed in a time-resolved fashion, comparing
% responses in a 100-ms-long moving window computed in 10-ms steps.
% TSs of all trials in each of the rPT groups are pooled together and been
% consider as a single trial.
% Calculating latency of *all trials* from each group using Neuron_Data_QsumLatency.m
%
% Input parameters: allTS - timestamps from all trials
%
% 7-Apr-2020, J Zhu
ltc1 = ltc1_temp;
ltc2 = ltc2_temp;
ltc3 = ltc3_temp;
ltc4 = ltc4_temp;

samplesize1 = length(ltc1);
samplesize2 = length(ltc2);
samplesize3 = length(ltc3);
samplesize4 = length(ltc4);
allltc = [ltc1 ltc2 ltc3 ltc4];
nrandsample = 10000; % how many times to randsample

for n=1:nrandsample
    y = randperm(length(allltc));
    sample1 = allltc(y(1:samplesize1));
    sample2 = allltc(y(samplesize1+1:samplesize1+samplesize2));
    sample3 = allltc(y(samplesize1+samplesize2+1:samplesize1+samplesize2+samplesize3));
    sample4 = allltc(y(samplesize1+samplesize2+samplesize3+1:samplesize1+samplesize2+samplesize3+samplesize4));
    diff(n,1) = abs(mean(sample1)-mean(sample2));
    diff(n,2) = abs(mean(sample1)-mean(sample3));
    diff(n,3) = abs(mean(sample1)-mean(sample4));
    diff(n,4) = abs(mean(sample2)-mean(sample3));
    diff(n,5) = abs(mean(sample2)-mean(sample4));
    diff(n,6) = abs(mean(sample3)-mean(sample4));
end


realdiff(1) = abs(mean(ltc1)-mean(ltc2));
realdiff(2) = abs(mean(ltc1)-mean(ltc3));
realdiff(3) = abs(mean(ltc1)-mean(ltc4));
realdiff(4) = abs(mean(ltc2)-mean(ltc3));
realdiff(5) = abs(mean(ltc2)-mean(ltc4));
realdiff(6) = abs(mean(ltc3)-mean(ltc4));
for i = 1:6
    p(i) = length(find(diff(:,i)>realdiff(i)))/length(diff(:,i));
end

    
