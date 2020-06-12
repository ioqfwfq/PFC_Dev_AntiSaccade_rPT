function [FR_temp1, FR_temp2, FR_temp3, FR_temp4, ntrs_temp] = Get_multiFRbyneuron_AllTrials_4rawProcessingTime_alignCue(filename,class_num)
%10-Jan-2019, J Zhu
%return the mena rate of neurons' firing rates of certain *epoches* of the trails for 4 groups rPT
load(filename)

bin_width = 0.05;  % 50 milliseconds bin
bin_step=0.01; % 10 ms window
bin_edges=0:bin_step:0.25; % 0 - 300 ms
bins = bin_edges+0.5*bin_step; %25 bins

Threshold1 = 0.075;
Threshold2 = 0.12;
Threshold3 = 0.15;

for nb = 1:length(bins)
    epoch_start = bin_edges(nb);
    epoch_end = epoch_start + bin_width; % the certain time period
    nTS1 = []; % 0-0.075s
    nTS2 = []; % 0.075-0.120s
    nTS3 = []; % 0.120-0.150s
    nTS4 = []; % >0.150s
    m_counter1 = 0;
    m_counter2 = 0;
    m_counter3 = 0;
    m_counter4 = 0;

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
                if  MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT >= Threshold2 && MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT < Threshold3
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
    FR_temp1(nb) = mean(nTS1/(epoch_end-epoch_start));
    FR_temp2(nb) = mean(nTS2/(epoch_end-epoch_start));
    FR_temp3(nb) = mean(nTS3/(epoch_end-epoch_start));
    FR_temp4(nb) = mean(nTS4/(epoch_end-epoch_start));
    ntrs_temp = [ntrs1 ntrs2 ntrs3 ntrs4];
end
end