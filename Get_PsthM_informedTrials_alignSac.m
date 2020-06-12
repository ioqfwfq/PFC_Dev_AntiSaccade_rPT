function [psth_temp, ntrs_temp] = Get_PsthM_informedTrials_alignSac(filename,class_num)
% Apr-2020, J Zhu
% *informed* trials (rPT > 150 ms, rPT <= 350 ms)
% The analysis was performed in a time-resolved fashion, comparing
% responses in a 20-ms-long moving window computed in 10-ms steps.

load(filename)
bin_width = 0.02;  % 20 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.8:bin_step:1.5;

allTS = [];
m_counter = 0;

Threshold1 = 0.15;
Threshold2 = 0.35;% *informed* trials (rPT > 150 ms, rPT <= 350 ms)

if ~isempty(MatData) && class_num <= length(MatData.class)
    for m1 = 1:length(MatData.class(class_num).ntr)
        if ~isempty(MatData.class(class_num).ntr(m1).Saccade_onT)
            if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT > Threshold1 && MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT <= Threshold2
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Saccade_onT;
                    allTS = [allTS TS];
                    m_counter = m_counter + 1;
                catch
                end
            end
        end
    end
    if class_num + 8 <= length(MatData.class)
        for m2 = 1:length(MatData.class(class_num + 8).ntr)
            if ~isempty(MatData.class(class_num + 8).ntr(m2).Saccade_onT)
                if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT > Threshold1 && MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT <= Threshold2
                    try
                        TS=[];
                        TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Saccade_onT;
                        allTS = [allTS TS];
                        m_counter = m_counter + 1;
                    catch
                    end
                end
            end
        end
        if class_num + 16 <= length(MatData.class)
            for m3 = 1:length(MatData.class(class_num + 16).ntr)
                if ~isempty(MatData.class(class_num + 16).ntr(m3).Saccade_onT)
                    if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT > Threshold1 && MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT <= Threshold2
                        try
                            TS=[];
                            TS = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Saccade_onT;
                            allTS = [allTS TS];
                            m_counter = m_counter + 1;
                        catch
                        end
                    end
                end
            end
        end
    end
    ntrs = m_counter;
else
    disp('Empty MatData File!!!');
end

psth_temp =histc(allTS,bin_edges)/(bin_step*ntrs);
if isempty(psth_temp)
    psth_temp1 = zeros(1,length(bins));
end
ntrs_temp = ntrs;
end