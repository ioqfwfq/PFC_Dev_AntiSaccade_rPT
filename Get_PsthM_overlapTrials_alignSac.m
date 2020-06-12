function [psth_temp, ntrs_temp] = Get_PsthM_overlapTrials_alignSac(filename,class_num)
% Apr-2020, J Zhu
% Overlap trials only
% The analysis was performed in a time-resolved fashion, comparing
% responses in a 20-ms-long moving window computed in 10-ms steps.

load(filename)
bin_width = 0.02;  % 20 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:1.5;

allTS = [];
m_counter = 0;

if ~isempty(MatData) && class_num <= length(MatData.class) % class_num is from 1 to 8
    for m1 = 1:length(MatData.class(class_num).ntr) % class 1-8 are overlap trials
        if ~isempty(MatData.class(class_num).ntr(m1).Saccade_onT)
            try
                TS=[];
                TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Saccade_onT;
                allTS = [allTS TS];
                m_counter = m_counter + 1;
            catch
            end
        end
    end
    ntrs = m_counter;
else
    disp('Empty MatData File!!!');
end

psth_temp =histc(allTS,bin_edges)/(bin_step*ntrs);
if isempty(psth_temp)
    psth_temp = zeros(1,length(bins));
end
ntrs_temp = ntrs;
end