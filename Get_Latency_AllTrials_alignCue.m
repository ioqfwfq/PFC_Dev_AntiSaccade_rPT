function [ltc_temp, ntrs_temp] = Get_Latency_AllTrials_alignCue(filename,class_num)
% 7-Mar-2020, J Zhu
% The analysis was performed in a time-resolved fashion, comparing
% responses in a 100-ms-long moving window computed in 10-ms steps.
% calculating latency of each trials using Neuron_Data_QsumLatency.m

load(filename)

ltc_temp = [];

m_counter = 0;

if ~isempty(MatData) && class_num <= length(MatData.class)
    for m1 = 1:length(MatData.class(class_num).ntr)
        if ~isempty(MatData.class(class_num).ntr(m1).Saccade_onT)
            try
                RT = MatData.class(class_num).ntr(m1).Saccade_onT - MatData.class(class_num).ntr(m1).Cue_onT;
                TS_cueon = MatData.class(class_num).ntr(m1).TS-MatData.class(class_num).ntr(m1).Cue_onT;
                [raster_temp stimon_temp maxoff_temp bin_edges_temp] = Get_raster_for_latency(TS_cueon);
                [on, off] = Neuron_Data_QsumLatency(raster_temp,stimon_temp,maxoff_temp,TS_cueon,bin_edges_temp);
                ltc = on;
            catch
            end
            ltc_temp = [ltc_temp ltc];
            m_counter = m_counter + 1;
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
                    ltc = on;
                catch
                end
                ltc_temp = [ltc_temp ltc];
                m_counter = m_counter + 1;
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
                        ltc = on;
                    catch
                    end
                    ltc_temp = [ltc_temp ltc];
                    m_counter = m_counter + 1;
                end
            end
        end
    end
ntrs = m_counter;
else
    disp('Empty MatData File!!!');
end
    ntrs_temp = ntrs;
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
