% For AntiSaccade task
% Plot result from all trials pooled together
% Align on cue

clear all
[Neurons_num Neurons_txt] = xlsread('test_VN.xlsx','allerr');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Best_Cue = Get_Maxes(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Best_Cue)
    Opp_Cue(n) = opp_index(Best_Cue(n));
end

for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
    Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    bin_width = 0.05;
    step = 0.005;
    bin_start = 0:step:0.18;
    bins_end = bin_start+bin_width;
    for nb = 1:length(bin_start)
        try
            [psth_temp ntrs_temp] = Get_PsthM_partial_aligncue(Errfilename,Best_Cue(n),bin_start(nb),bins_end(nb));
            psth = psth_temp;
            ntrs = ntrs_temp;
        catch
            disp(['error processing neuron  ', Errfilename  '  Dir1=' num2str(Best_Cue(n))])
        end
        psth1(n,:,nb) = psth_temp;
        ntrs1(n,nb) = ntrs_temp;
    end
end
nn=sum(ntrs1~=0);
ntrs=sum(ntrs1);
sumpsth=sum(psth1);

for n=1:nb
    try
    psthmean(n,:) = sumpsth(:,:,n)/nn(n);
    catch
    end
end

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