function [FR_temp1, ntrs_temp] = Get_FRbytrial_AllTrials_alignCue(filename,class_num)
%28-Apr-2020, J Zhu
%return the firing rate of a certain epoch of each trial

load(filename)

nTS1 = [];
m_counter1 = 0;

epoch_start = 0.04;
epoch_end = 0.12; % the certain time period

if ~isempty(MatData) && class_num <= length(MatData.class)
    for m1 = 1:length(MatData.class(class_num).ntr)
        if ~isempty(MatData.class(class_num).ntr(m1).Saccade_onT)
            try
                TS=[];
                TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Cue_onT;
                nTS = length(find(TS>=epoch_start & TS< epoch_end));
                nTS1 = [nTS nTS1];
                m_counter1 = m_counter1 + 1;
            catch
            end
        end
    end
    if class_num + 8 <= length(MatData.class)
        for m2 = 1:length(MatData.class(class_num + 8).ntr)
            if ~isempty(MatData.class(class_num + 8).ntr(m2).Saccade_onT)
                try
                    TS=[];
                    TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Cue_onT;
                    nTS = length(find(TS>=epoch_start & TS< epoch_end));
                    nTS1 = [nTS nTS1];
                    m_counter1 = m_counter1 + 1;
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
                        nTS = length(find(TS>=epoch_start & TS< epoch_end));
                        nTS1 = [nTS nTS1];
                        m_counter1 = m_counter1 + 1;
                    catch
                    end
                end
            end
        end
    end
    ntrs1 = m_counter1;
else
    disp('Empty MatData File!!!');
end

FR_temp1 = nTS1/(epoch_end-epoch_start);
ntrs_temp = ntrs1;
end