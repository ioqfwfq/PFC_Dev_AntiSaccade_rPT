function [psth_temp1, psth_temp2, psth_temp3, psth_temp4, ntrs_temp] = Get_PsthM_AllTrials_rawProcessingTime_alignSac(filename,class_num)
load(filename)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;

allTS1 = []; % 0-0.075s
allTS2 = []; % 0.075-0.120s
allTS3 = []; % 0.120-0.150s
allTS4 = []; % >0.150s
m_counter1 = 0;
m_counter2 = 0;
m_counter3 = 0;
m_counter4 = 0;

Threshold1 = 0.075;
Threshold2 = 0.12;
Threshold3 = 0.15;

if ~isempty(MatData)
    for m1 = 1:length(MatData.class(class_num).ntr)
        if ~isempty(MatData.class(class_num).ntr(m1).Saccade_onT)
            if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT < Threshold1         
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Saccade_onT;
                    allTS1 = [allTS1 TS];
                    m_counter1 = m_counter1 + 1;
                catch
                end
            end
            if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT >= Threshold1 && MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT < Threshold2
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Saccade_onT;
                    allTS2 = [allTS2 TS];
                    m_counter2 = m_counter2 + 1;
                catch
                end
            end
            if  MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT >= MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT < Threshold3
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Saccade_onT;
                    allTS3 = [allTS3 TS];
                    m_counter3 = m_counter3 + 1;
                catch
                end
            end
            if MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT >= Threshold3
                try
                    TS=[];
                    TS = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Saccade_onT;
                    allTS4 = [allTS4 TS];
                    m_counter4 = m_counter4 + 1;
                catch
                end
            end
        end
    end
    for m2 = 1:length(MatData.class(class_num + 8).ntr)
        if ~isempty(MatData.class(class_num + 8).ntr(m2).Saccade_onT)
            if MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT < Threshold1
                try
                    TS=[];
                    TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Saccade_onT;
                    allTS1 = [allTS1 TS];
                    m_counter1 = m_counter1 + 1;
                catch
                end
            end
            if MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT >= Threshold1 && MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT < Threshold2
                try
                    TS=[];
                    TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Saccade_onT;
                    allTS2 = [allTS2 TS];
                    m_counter2 = m_counter2 + 1;
                catch
                end
            end
            if  MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT >= Threshold2 && MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT < Threshold3
                try
                    TS=[];
                    TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Saccade_onT;
                    allTS3 = [allTS3 TS];
                    m_counter3 = m_counter3 + 1;
                catch
                end
            end
            if MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT >= Threshold3
                try
                    TS=[];
                    TS = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Saccade_onT;
                    allTS4 = [allTS4 TS];
                    m_counter4 = m_counter4 + 1;
                catch
                end
            end
        end
    end
    for m3 = 1:length(MatData.class(class_num + 16).ntr)
        if ~isempty(MatData.class(class_num + 16).ntr(m3).Saccade_onT)
            if MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT < Threshold1
                try
                    TS=[];
                    TS = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Saccade_onT;
                    allTS1 = [allTS1 TS];
                    m_counter1 = m_counter1 + 1;
                catch
                end
            end
            if MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT >= Threshold1 && MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT < Threshold2
                try
                    TS=[];
                    TS = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Saccade_onT;
                    allTS2 = [allTS2 TS];
                    m_counter2 = m_counter2 + 1;
                catch
                end
            end
            if  MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT >= Threshold2 && MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT < Threshold3
                try
                    TS=[];
                    TS = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Saccade_onT;
                    allTS3 = [allTS3 TS];
                    m_counter3 = m_counter3 + 1;
                catch
                end
            end
            if MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT >= Threshold3
                try
                    TS=[];
                    TS = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Saccade_onT;
                    allTS4 = [allTS4 TS];
                    m_counter4 = m_counter4 + 1;
                catch
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

psth_temp1 =histc(allTS1,bin_edges)/(bin_width*ntrs1);
if isempty(psth_temp1)
    psth_temp1 = zeros(1,47);
end
psth_temp2 =histc(allTS2,bin_edges)/(bin_width*ntrs2);
if isempty(psth_temp2)
    psth_temp2 = zeros(1,47);
end
psth_temp3 =histc(allTS3,bin_edges)/(bin_width*ntrs3);
if isempty(psth_temp3)
    psth_temp3 = zeros(1,47);
end
psth_temp4 =histc(allTS4,bin_edges)/(bin_width*ntrs4);
if isempty(psth_temp4)
    psth_temp4 = zeros(1,47);
end
ntrs_temp = [ntrs1 ntrs2 ntrs3 ntrs4];
end