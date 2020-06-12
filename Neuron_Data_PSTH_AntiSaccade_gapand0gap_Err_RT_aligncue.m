% For AntiSaccade task
% Plot result from zero gap and gap trials together(4 groups of RT, 1 condition for each group)
% Align by cue
% Update plotting. 04-Sep-2019, J Zhu
% Update plotting. Plot best cue location with its oppo location together
% in same figure. 09-Sep-2019, J Zhu
% Fix the RT It used to be rPT for gap trials, now it's fixed. 10-Sep-2019
% J zhu

clear all
[Neurons_num Neurons_txt] = xlsread('testErr.xlsx','adult');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Best_Cue = Get_Maxes(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Best_Cue)
    Opp_Cue(n) = opp_index(Best_Cue(n));
end

for n = 1:length(Neurons)
    AntiErrfilename = [Neurons{n,1}([1:6]),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
%     Profilename = [Neurons{n,1}([1:6]),'_1_',num2str(Neurons{n,2})];
    try
        [psth_temp1, psth_temp2, psth_temp3, psth_temp4, ntrs_temp] = Get_PsthM_combine_RT(AntiErrfilename,Best_Cue(n)+8,Best_Cue(n)+16);
        psth1(n,:) = psth_temp1;
        psth3(n,:) = psth_temp2;
        psth5(n,:) = psth_temp3;
        psth7(n,:) = psth_temp4;
        ntrs(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', AntiErrfilename  '  Dir1=' num2str(Best_Cue(n))])
    end
    try
        [psth_temp1, psth_temp2, psth_temp3, psth_temp4, ntrs_temp] = Get_PsthM_combine_RT(AntiErrfilename,Opp_Cue(n)+8,Opp_Cue(n)+16);
        psth2(n,:) = psth_temp1;
        psth4(n,:) = psth_temp2;
        psth6(n,:) = psth_temp3;
        psth8(n,:) = psth_temp4;
    catch
        disp(['error processing neuron  ', AntiErrfilename  '  Dir2=' num2str(Opp_Cue(n))])
    end
end

nn=sum(ntrs~=0);
ntrs=sum(ntrs);
definepsthmax=50;

% fig=openfig('figure2');
figure
set( gcf, 'Color', 'White', 'Unit', 'Normalized', ...
    'Position', [0.1,0.1,0.8,0.8] ) ;
subplot(2,4,1)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on
try
    psth1mean = sum(psth1)/nn(1);
    psth2mean = sum(psth2)/nn(1);
catch
end
try
    plot(bins,psth1mean,'c','LineWidth',3);
catch
end
try
    plot(bins,psth2mean,'m','LineWidth',3);
catch
end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('0-0.075s')
gtext({[num2str(nn(1)) ' neurons ' num2str(ntrs(1)) ' trials']},'color','k', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,2)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on

try
    psth3mean = sum(psth3)/nn(2);
    psth4mean = sum(psth4)/nn(2);
catch
end
try
    plot(bins,psth3mean,'c','LineWidth',3);
catch
end
try
    plot(bins,psth4mean,'m','LineWidth',3);
catch
end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('0.075-0.120s')
gtext({[num2str(nn(2)) ' neurons ' num2str(ntrs(2)) ' trials']},'color','k', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,3)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on

try
    psth5mean = sum(psth5)/nn(3);
    psth6mean = sum(psth6)/nn(3);
catch
end
try
    plot(bins,psth5mean,'c','LineWidth',3);
catch
end
try
    plot(bins,psth6mean,'m','LineWidth',3);
catch
end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('0.120-0.150s')
gtext({[num2str(nn(3)) ' neurons ' num2str(ntrs(3)) ' trials']},'color','k', 'FontWeight', 'Bold')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,4)
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on

try
    psth7mean = sum(psth7)/nn(4);
    psth8mean = sum(psth8)/nn(4);    
catch
end
try
    plot(bins,psth7mean,'c','LineWidth',3);
catch
end
try
    plot(bins,psth8mean,'m','LineWidth',3);
catch
end
line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
title('>0.150s')
gtext({[num2str(nn(4)) ' neurons ' num2str(ntrs(4)) ' trials']},'color','k', 'FontWeight', 'Bold')

axes( 'Position', [0, 0.95, 1, 0.05] ) ;
set( gca, 'Color', 'None', 'XColor', 'None', 'YColor', 'None' ) ;
text( 0.5, 0, 'Visual neurons Align Cue Best cue location/opposite location', 'FontSize', 12', 'FontWeight', 'Bold', ...
    'HorizontalAlignment', 'Center', 'VerticalAlignment', 'middle' )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Directions = Get_Dir(Neurons)
Directions(1:length(Neurons),1:12) = NaN;
for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}([1:6]),'_2_',num2str(Neurons{n,2})];
    fn_matext = ([Antifilename([1:8]),'.mat']);
    load(fn_matext);
    Direction= unique([AllData.trials(:).Class]);
    Directions(n,1:12) = Direction(1:12);
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function max_results = Get_Maxes(Neurons)
max_result(1:length(Neurons),1:3) = NaN;
for n = 1:length(Neurons)
    Profilename = [Neurons{n,1}([1:6]),'_1_',num2str(Neurons{n,2})];
    Antifilename = [Neurons{n,1}([1:6]),'_2_',num2str(Neurons{n,2})];
    temp = Neuron_Data_Maxcuerate_ProFrom4LOC(Profilename,Antifilename);
    max_results(n,1:length(temp)) = temp(1);
end
end
function max_results = Get_Maxes_sac(Neurons)
max_result(1:length(Neurons),1:3) = NaN;
for n = 1:length(Neurons)
    Profilename = [Neurons{n,1}([1:6]),'_1_',num2str(Neurons{n,2})];
    Antifilename = [Neurons{n,1}([1:6]),'_2_',num2str(Neurons{n,2})];
    temp = Neuron_Data_Maxsacrate_ProFrom4LOC(Profilename,Antifilename);
    max_results(n,1:length(temp)) = temp(1);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [psth_temp1, psth_temp2, psth_temp3, psth_temp4, ntrs_temp] = Get_PsthM_combine_RT(filename,class_num1,class_num2)
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

if length(MatData.class)>8 %24  % AntiSac
    if ~isempty(MatData)
        if class_num1 <= length(MatData.class)
            for m1 = 1:length(MatData.class(class_num1).ntr)
                if MatData.class(class_num1).ntr(m1).RT < Threshold1
                    if ~isempty(MatData.class(class_num1).ntr(m1).Saccade_onT)
                        try
                            TS=[];
                            TS = MatData.class(class_num1).ntr(m1).TS-MatData.class(class_num1).ntr(m1).Cue_onT;
                            allTS1 = [allTS1 TS];
                            m_counter1 = m_counter1 + 1;
                        catch
                        end
                    end
                end
                if MatData.class(class_num1).ntr(m1).RT >= Threshold1 && MatData.class(class_num1).ntr(m1).RT < Threshold2
                    if ~isempty(MatData.class(class_num1).ntr(m1).Saccade_onT)
                        try
                            TS=[];
                            TS = MatData.class(class_num1).ntr(m1).TS-MatData.class(class_num1).ntr(m1).Cue_onT;
                            allTS2 = [allTS2 TS];
                            m_counter2 = m_counter2 + 1;
                        catch
                        end
                    end
                end
                if  MatData.class(class_num1).ntr(m1).RT >= Threshold2 && MatData.class(class_num1).ntr(m1).RT < Threshold3
                    if ~isempty(MatData.class(class_num1).ntr(m1).Saccade_onT)
                        try
                            TS=[];
                            TS = MatData.class(class_num1).ntr(m1).TS-MatData.class(class_num1).ntr(m1).Cue_onT;
                            allTS3 = [allTS3 TS];
                            m_counter3 = m_counter3 + 1;
                        catch
                        end
                    end
                end
                if MatData.class(class_num1).ntr(m1).RT >= Threshold3
                    if ~isempty(MatData.class(class_num1).ntr(m1).Saccade_onT)
                        try
                            TS=[];
                            TS = MatData.class(class_num1).ntr(m1).TS-MatData.class(class_num1).ntr(m1).Cue_onT;
                            allTS4 = [allTS4 TS];
                            m_counter4 = m_counter4 + 1;
                        catch
                        end
                    end
                end
            end
        end
        if class_num2 <= length(MatData.class)
            for m2 = 1:length(MatData.class(class_num2).ntr)
                if MatData.class(class_num2).ntr(m2).RT + 0.1 < Threshold1
                    if ~isempty(MatData.class(class_num2).ntr(m2).Saccade_onT)
                        try
                            TS=[];
                            TS = MatData.class(class_num2).ntr(m2).TS-MatData.class(class_num2).ntr(m2).Cue_onT;
                            allTS1 = [allTS1 TS];
                            m_counter1 = m_counter1 + 1;
                        catch
                        end
                    end
                end
                if MatData.class(class_num2).ntr(m2).RT + 0.1 >= Threshold1 && MatData.class(class_num2).ntr(m2).RT + 0.1 < Threshold2
                    if ~isempty(MatData.class(class_num2).ntr(m2).Saccade_onT)
                        try
                            TS=[];
                            TS = MatData.class(class_num2).ntr(m2).TS-MatData.class(class_num2).ntr(m2).Cue_onT;
                            allTS2 = [allTS2 TS];
                            m_counter2 = m_counter2 + 1;
                        catch
                        end
                    end
                end
                if  MatData.class(class_num2).ntr(m2).RT + 0.1 >= Threshold2 && MatData.class(class_num2).ntr(m2).RT + 0.1 < Threshold3
                    if ~isempty(MatData.class(class_num2).ntr(m2).Saccade_onT)
                        try
                            TS=[];
                            TS = MatData.class(class_num2).ntr(m2).TS-MatData.class(class_num2).ntr(m2).Cue_onT;
                            allTS3 = [allTS3 TS];
                            m_counter3 = m_counter3 + 1;
                        catch
                        end
                    end
                end
                if MatData.class(class_num2).ntr(m2).RT + 0.1 >= Threshold3
                    if ~isempty(MatData.class(class_num2).ntr(m2).Saccade_onT)
                        try
                            TS=[];
                            TS = MatData.class(class_num2).ntr(m2).TS-MatData.class(class_num2).ntr(m2).Cue_onT;
                            allTS4 = [allTS4 TS];
                            m_counter4 = m_counter4 + 1;
                        catch
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
end