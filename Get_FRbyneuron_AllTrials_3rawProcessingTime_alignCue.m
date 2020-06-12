function [FR_temp1, FR_temp2, FR_temp3, FR_temp4, ntrs_temp] = Get_FRbyneuron_AllTrials_3rawProcessingTime_alignCue(filename,class_num)
%10-Jan-2019, J Zhu
%return the mena rate of neurons' firing rates of certain epoch of the trails for 3 groups rPT
load(filename)

nTS1 = []; 
nTS2 = []; 
nTS3 = []; 
m_counter1 = 0;
m_counter2 = 0;
m_counter3 = 0;

Threshold1 = 0.08;
Threshold2 = 0.14;

epoch_start = 0.05;
epoch_end = 0.12; % the certain time period

if ~isempty(MatData) && class_num <= length(MatData.class)
    for m1 = 1:length(MatData.class(class_num).ntr)
        if ~isempty(MatData.class(class_num).ntr(m1).Saccade_onT)
            if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT < Threshold1
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Cue_onT;
                    nTS = length(find(TS>=epoch_start & TS< epoch_end));
                    nTS1 = [nTS nTS1];
                    m_counter1 = m_counter1 + 1;
                catch
                end
            end
            if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT >= Threshold1 && MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT < Threshold2
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Cue_onT;
                    nTS = length(find(TS>=epoch_start & TS< epoch_end));
                    nTS2 = [nTS nTS2];
                    m_counter2 = m_counter2 + 1;
                catch
                end
            end
            if  MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT >= MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT < Threshold3
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Cue_onT;
                    nTS = length(find(TS>=epoch_start & TS< epoch_end));
                    nTS3 = [nTS nTS3];
                    m_counter3 = m_counter3 + 1;
                catch
                end
            end
            if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT >= Threshold3
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Cue_onT;
                    nTS = length(find(TS>=epoch_start & TS< epoch_end));
                    nTS4 = [nTS nTS4];
                    m_counter4 = m_counter4 + 1;
                catch
                end
            end
        end
    end
    if class_num + 8 <= length(MatData.class)
        for m2 = 1:length(MatData.class(class_num + 8).ntr)
            if ~isempty(MatData.class(class_num + 8).ntr(m2).Saccade_onT)
                if MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT < Threshold1
                    try
                        TS=[];
                        TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Cue_onT;
                        nTS = length(find(TS>=epoch_start & TS< epoch_end));
                        nTS1 = [nTS nTS1];
                        m_counter1 = m_counter1 + 1;
                    catch
                    end
                end
                if MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT >= Threshold1 && MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT < Threshold2
                    try
                        TS=[];
                        TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Cue_onT;
                        nTS = length(find(TS>=epoch_start & TS< epoch_end));
                        nTS2 = [nTS nTS2];
                        m_counter2 = m_counter2 + 1;
                    catch
                    end
                end
                if  MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT >= Threshold2 && MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT < Threshold3
                    try
                        TS=[];
                        TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Cue_onT;
                        nTS = length(find(TS>=epoch_start & TS< epoch_end));
                        nTS3 = [nTS nTS3];
                        m_counter3 = m_counter3 + 1;
                    catch
                    end
                end
                if MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT >= Threshold3
                    try
                        TS=[];
                        TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Cue_onT;
                        nTS = length(find(TS>=epoch_start & TS< epoch_end));
                        nTS4 = [nTS nTS4];
                        m_counter4 = m_counter4 + 1;
                    catch
                    end
                end
            end
        end
        if class_num + 16 <= length(MatData.class)
            for m3 = 1:length(MatData.class(class_num + 16).ntr)
                if ~isempty(MatData.class(class_num + 16).ntr(m3).Saccade_onT)
                    if MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT < Threshold1
                        try
                            TS=[];
                            TS = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Cue_onT;
                            nTS = length(find(TS>=epoch_start & TS< epoch_end));
                            nTS1 = [nTS nTS1];
                            m_counter1 = m_counter1 + 1;
                        catch
                        end
                    end
                    if MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT >= Threshold1 && MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT < Threshold2
                        try
                            TS=[];
                            TS = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Cue_onT;
                            nTS = length(find(TS>=epoch_start & TS< epoch_end));
                            nTS2 = [nTS nTS2];
                            m_counter2 = m_counter2 + 1;
                        catch
                        end
                    end
                    if  MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT >= Threshold2 && MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT < Threshold3
                        try
                            TS=[];
                            TS = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Cue_onT;
                            nTS = length(find(TS>=epoch_start & TS< epoch_end));
                            nTS3 = [nTS nTS3];
                            m_counter3 = m_counter3 + 1;
                        catch
                        end
                    end
                    if MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT >= Threshold3
                        try
                            TS=[];
                            nTS = length(find(TS>=epoch_start & TS< epoch_end));
                            nTS4 = [nTS nTS4];
                            m_counter4 = m_counter4 + 1;
                        catch
                        end
                    end
                end
            end
        end
    end
    ntrs1 = m_counter1;
    ntrs2 = m_counter2;
    ntrs3 = m_counter3;
    ntrs4 = m_counter4;
else
    disp('Empty MatData File!!!');
end

FR_temp1 = mean(nTS1/(epoch_end-epoch_start));
FR_temp2 = mean(nTS2/(epoch_end-epoch_start));
FR_temp3 = mean(nTS3/(epoch_end-epoch_start));
FR_temp4 = mean(nTS4/(epoch_end-epoch_start));
ntrs_temp = [ntrs1 ntrs2 ntrs3 ntrs4];

end