function [psth_temp, ntrs_temp] = Get_PsthM_AllTrials_alignCue(filename,class_num)
%09-Oct-2019, J Zhu
load(filename)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-0.8:bin_width:2.5;

bins = bin_edges+0.5*bin_width;

allTS = [];
m_counter = 0;

if ~isempty(MatData) && class_num <= length(MatData.class)
    for m1 = 1:length(MatData.class(class_num).ntr)
%         if ~isempty(MatData.class(class_num).ntr(m1).Saccade_onT)

            try
                TS=[];
                TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Cue_onT;
                allTS = [allTS TS];
                m_counter = m_counter + 1;
            catch
            end
%         end

    end
    if class_num + 8 <= length(MatData.class)
        for m2 = 1:length(MatData.class(class_num + 8).ntr)
            if ~isempty(MatData.class(class_num + 8).ntr(m2).Saccade_onT)
                try
                    TS=[];
                    TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Cue_onT;
                    allTS = [allTS TS];
                    m_counter = m_counter + 1;
                catch
                end
            end
        end
        if class_num + 16 <= length(MatData.class)
            for m3 = 1:length(MatData.class(class_num + 16).ntr)
                if ~isempty(MatData.class(class_num + 16).ntr(m3).Saccade_onT)
                    try
                        TS=[];
                        TS = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Cue_onT;
                        allTS = [allTS TS];
                        m_counter = m_counter + 1;
                    catch
                    end
                end
            end
        end
    end
    ntrs = m_counter;
else
    disp('Empty MatData File!!!');
end
psth_temp =histc(allTS,bin_edges)/(bin_width*ntrs);
if isempty(psth_temp)
    psth_temp = zeros(1,47);
end
ntrs_temp = ntrs;
end