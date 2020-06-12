function [psth_temp ntrs] = Get_PsthM_partial_aligncue(filename,class_num,lo,hi) 
%align on cue
load(filename)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;

bin_edges_Pro=-1:bin_width:3;
bins_Pro = bin_edges_Pro+0.5*bin_width;

Threshold1 = lo;
Threshold2 = hi;

allTS = [];
m_counter = 0;

if ~isempty(MatData) && class_num <= length(MatData.class)
    for m1 = 1:length(MatData.class(class_num).ntr)
        if ~isempty(MatData.class(class_num).ntr(m1).Saccade_onT)
            if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT >= Threshold1 && MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT < Threshold2
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Cue_onT;
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
                if MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT >= Threshold1 && MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT < Threshold2
                    try
                        TS=[];
                        TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Cue_onT;
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
                    if MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT >= Threshold1 && MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT < Threshold2
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
    end

else
    disp('Empty MatData File!!!');
end
psth_temp =histc(allTS,bin_edges)/(bin_width*m_counter);
if isempty(psth_temp)
    psth_temp = zeros(1,47);
end
ntrs = m_counter;
end