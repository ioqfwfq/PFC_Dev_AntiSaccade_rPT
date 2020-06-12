function [allTS1, allTS2, allTS3, allTS4, RT1, RT2, RT3, RT4] = Get_allTS_AllTrials_4rawProcessingTime_alignSac(filename,class_num)
% return Time Stamps and RT of each trials for latency calculation
% 7-Apr-2020, J Zhu

load(filename)

allTS1 = []; % 0-0.075s
allTS2 = []; % 0.075-0.120s
allTS3 = []; % 0.120-0.150s
allTS4 = []; % >0.150s
RT1 = []; % 0-0.075s
RT2 = []; % 0.075-0.120s
RT3 = []; % 0.120-0.150s
RT4 = []; % >0.150s

Threshold1 = 0.075;
Threshold2 = 0.12;
Threshold3 = 0.15;

% Get all the time stamps
if ~isempty(MatData) && class_num <= length(MatData.class)
    for m1 = 1:length(MatData.class(class_num).ntr)
        if ~isempty(MatData.class(class_num).ntr(m1).Saccade_onT)
            try
                RT = MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT;
                TS_cueon = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Cue_onT;
            catch
            end
            if RT < Threshold1
                allTS1 = [allTS1 TS_cueon];
                RT1 = [RT1 RT];
            end
            if RT >= Threshold1 && RT < Threshold2
                allTS2 = [allTS2 TS_cueon];
                RT2 = [RT2 RT];
            end
            if  RT >= Threshold2 && RT < Threshold3
                allTS3 = [allTS3 TS_cueon];
                RT3 = [RT3 RT];
            end
            if RT >= Threshold3
                allTS4 = [allTS4 TS_cueon];
                RT4 = [RT4 RT];
            end
        end
    end
    if class_num + 8 <= length(MatData.class)
        for m2 = 1:length(MatData.class(class_num + 8).ntr)
            if ~isempty(MatData.class(class_num + 8).ntr(m2).Saccade_onT)
                try
                    RT = MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT;
                    TS_cueon = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Cue_onT;
                catch
                end
                if RT < Threshold1
                    allTS1 = [allTS1 TS_cueon];
                    RT1 = [RT1 RT];
                end
                if RT >= Threshold1 && RT < Threshold2
                    allTS2 = [allTS2 TS_cueon];
                    RT2 = [RT2 RT];
                end
                if  RT >= Threshold2 && RT < Threshold3
                    allTS3 = [allTS3 TS_cueon];
                    RT3 = [RT3 RT];
                end
                if RT >= Threshold3
                    allTS4 = [allTS4 TS_cueon];
                    RT4 = [RT4 RT];
                end
            end
        end
        if class_num + 16 <= length(MatData.class)
            for m3 = 1:length(MatData.class(class_num + 16).ntr)
                if ~isempty(MatData.class(class_num + 16).ntr(m3).Saccade_onT)
                    try
                        RT = MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT;
                        TS_cueon = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Cue_onT;
                    catch
                    end
                    if RT < Threshold1
                        allTS1 = [allTS1 TS_cueon];
                        RT1 = [RT1 RT];
                    end
                    if RT >= Threshold1 && RT < Threshold2
                        allTS2 = [allTS2 TS_cueon];
                        RT2 = [RT2 RT];
                    end
                    if  RT >= Threshold2 && RT < Threshold3
                        allTS3 = [allTS3 TS_cueon];
                        RT3 = [RT3 RT];
                    end
                    if RT >= Threshold3
                        allTS4 = [allTS4 TS_cueon];
                        RT4 = [RT4 RT];
                    end
                end
            end
        end
    end
else
    disp('Empty MatData File!!!');
end
end