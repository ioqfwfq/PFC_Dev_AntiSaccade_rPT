function [ltc1, ltc2, ltc3, ltc4, ntrs_temp] = Get_Latency_AllTrials_4rawProcessingTime_alignSac(filename,class_num)
% 7-Feb-2020, J Zhu
% The analysis was performed in a time-resolved fashion, comparing
% responses in a 100-ms-long moving window computed in 10-ms steps.
% calculating latency of *each trials* using Neuron_Data_QsumLatency.m

load(filename)
% bin_width = 0.1;  % 100 milliseconds bin
% bin_step = 0.01; %10 ms steps
% bin_edges=-.5:bin_step:0.5;
% bins = bin_edges+0.5*bin_width; %231 in total

ltc1 = []; % 0-0.075s
ltc2 = []; % 0.075-0.120s
ltc3 = []; % 0.120-0.150s
ltc4 = []; % >0.150s

m_counter1 = 0;
m_counter2 = 0;
m_counter3 = 0;
m_counter4 = 0;

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
                [raster_temp stimon_temp maxoff_temp bin_edges_temp] = Get_raster_for_latency(TS_cueon);
                [on, off] = Neuron_Data_QsumLatency(raster_temp,stimon_temp,maxoff_temp,TS_cueon,bin_edges_temp);
                ltc = on-RT;
            catch
            end
            if RT < Threshold1
                ltc1 = [ltc1 ltc];
                m_counter1 = m_counter1 + 1;
            end
            if RT >= Threshold1 && RT < Threshold2
                ltc2 = [ltc2 ltc];
                m_counter2 = m_counter2 + 1;
            end
            if  RT >= Threshold2 && RT < Threshold3
                ltc3 = [ltc3 ltc];
                m_counter3 = m_counter3 + 1;
            end
            if RT >= Threshold3
                ltc4 = [ltc4 ltc];
                m_counter4 = m_counter4 + 1;
            end
        end
    end
    if class_num + 8 <= length(MatData.class)
        for m2 = 1:length(MatData.class(class_num + 8).ntr)
            if ~isempty(MatData.class(class_num + 8).ntr(m2).Saccade_onT)
                try
                    RT = MatData.class(class_num + 8).ntr(m2).Saccade_onT - MatData.class(class_num + 8).ntr(m2).Cue_onT;
                    TS_cueon = MatData.class(class_num + 8).ntr(m2).TS-MatData.class(class_num + 8).ntr(m2).Cue_onT;
                    [raster_temp stimon_temp maxoff_temp bin_edges_temp] = Get_raster_for_latency(TS_cueon);
                    [on, off] = Neuron_Data_QsumLatency(raster_temp,stimon_temp,maxoff_temp,TS_cueon,bin_edges_temp);
                    ltc = on-RT;
                catch
                end
                if RT < Threshold1
                    ltc1 = [ltc1 ltc];
                    m_counter1 = m_counter1 + 1;
                end
                if RT >= Threshold1 && RT < Threshold2
                    ltc2 = [ltc2 ltc];
                    m_counter2 = m_counter2 + 1;
                end
                if  RT >= Threshold2 && RT < Threshold3
                    ltc3 = [ltc3 ltc];
                    m_counter3 = m_counter3 + 1;
                end
                if RT >= Threshold3
                    ltc4 = [ltc4 ltc];
                    m_counter4 = m_counter4 + 1;
                end
            end
        end
        if class_num + 16 <= length(MatData.class)
            for m3 = 1:length(MatData.class(class_num + 16).ntr)
                if ~isempty(MatData.class(class_num + 16).ntr(m3).Saccade_onT)
                    try
                        RT = MatData.class(class_num + 16).ntr(m3).Saccade_onT - MatData.class(class_num + 16).ntr(m3).Cue_onT;
                        TS_cueon = MatData.class(class_num + 16).ntr(m3).TS-MatData.class(class_num + 16).ntr(m3).Cue_onT;
                        [raster_temp stimon_temp maxoff_temp bin_edges_temp] = Get_raster_for_latency(TS_cueon);
                        [on, off] = Neuron_Data_QsumLatency(raster_temp,stimon_temp,maxoff_temp,TS_cueon,bin_edges_temp);
                        ltc = on-RT;
                    catch
                    end
                    if RT < Threshold1
                        ltc1 = [ltc1 ltc];
                        m_counter1 = m_counter1 + 1;
                    end
                    if RT >= Threshold1 && RT < Threshold2
                        ltc2 = [ltc2 ltc];
                        m_counter2 = m_counter2 + 1;
                    end
                    if  RT >= Threshold2 && RT < Threshold3
                        ltc3 = [ltc3 ltc];
                        m_counter3 = m_counter3 + 1;
                    end
                    if RT >= Threshold3
                        ltc4 = [ltc4 ltc];
                        m_counter4 = m_counter4 + 1;
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

ntrs_temp = [ntrs1 ntrs2 ntrs3 ntrs4];
end

function [raster_temp stimon_temp maxoff_temp bin_edges_temp] = Get_raster_for_latency(TS)
bin_width = 0.1;  % 100 milliseconds bin
bin_step = 0.01; %10 ms steps
bin_edges=-.5:bin_step:.6;
bins = bin_edges+0.5*bin_width; %110 in total
raster = histc(TS, bin_edges);

window_width = 0.1;  % 100 milliseconds bin
window_step = 0.01; %10 ms steps
window_edges=-.5:bin_step:.5;
windows = window_edges+0.5*window_width; %100 in total
for i = 1:101
    raster_temp(i) = sum(raster([i:i+10]));
end
stimon_temp = find(bin_edges == 0);
maxoff_temp = length(raster_temp);
bin_edges_temp = window_edges;
end
