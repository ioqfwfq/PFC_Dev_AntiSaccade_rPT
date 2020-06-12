function [psth_temp1, ntrs_temp] = Get_PsthM_slowTrials_alignSac(filename,class_num)
% Apr-2020, J Zhu
% *fast* trials (rPT <= 120 ms)
% The analysis was performed in a time-resolved fashion, comparing
% responses in a 100-ms-long moving window computed in 10-ms steps.

load(filename)
bin_width = 0.1;  % 100 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:1.5;
bins = bin_edges+0.5*bin_width; %231 in total

allTS1 = [];
m_counter1 = 0;

Threshold1 = 0.12;

if ~isempty(MatData) && class_num <= length(MatData.class)
    for m1 = 1:length(MatData.class(class_num).ntr)
        if ~isempty(MatData.class(class_num).ntr(m1).Saccade_onT)
            if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT >= Threshold1
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Saccade_onT;
                    allTS1 = [allTS1 TS];
                    m_counter1 = m_counter1 + 1;
                catch
                end
            end
        end
    end
    if class_num + 8 <= length(MatData.class)
        for m2 = 1:length(MatData.class(class_num + 8).ntr)
            if ~isempty(MatData.class(class_num + 8).ntr(m2).Saccade_onT)
                if MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT >= Threshold1
                    try
                        TS=[];
                        TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Saccade_onT;
                        allTS1 = [allTS1 TS];
                        m_counter1 = m_counter1 + 1;
                    catch
                    end
                end
            end
        end
        if class_num + 16 <= length(MatData.class)
            for m3 = 1:length(MatData.class(class_num + 16).ntr)
                if ~isempty(MatData.class(class_num + 16).ntr(m3).Saccade_onT)
                    if MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT >= Threshold1
                        try
                            TS=[];
                            TS = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Saccade_onT;
                            allTS1 = [allTS1 TS];
                            m_counter1 = m_counter1 + 1;
                        catch
                        end
                    end
                end
            end
        end
    end
    ntrs1 = m_counter1;
else
    disp('Empty MatData File!!!');
end

psth_temp1 =histc(allTS1,bin_edges)/(bin_width*ntrs1);
if isempty(psth_temp1)
    psth_temp1 = zeros(1,length(bins));
end
ntrs_temp = [ntrs1];
end