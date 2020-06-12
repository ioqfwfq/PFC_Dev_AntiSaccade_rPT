% For AntiSaccade task
% Plot result from all trials pooled together (4 groups of rPT, 1 condition for each group)
% Aligned on saccade. J Zhu.

clear all
[Neurons_num Neurons_txt] = xlsread('database.xlsx','allPFC');
warning off MATLAB:divideByZero
Neurons = [Neurons_txt(:,1) num2cell(Neurons_num(:,1))];

Opp_Sac = Get_Maxes_sac(Neurons);
opp_index = [5 6 7 8 1 2 3 4 9];
for n = 1:length(Opp_Sac)
    best_target(n) = opp_index(Opp_Sac(n));
    % The Best_target location is the best saccade location determined by
    % prosaccade task, which makes the correct trials and error trials both have
    % saccade in the receptive field. The class is the diametric class of the
    % best saccade class in prosaccade task for correct trials and the same
    % class for error trials.
end

for n = 1:length(Neurons)
    Antifilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2})];
    Profilename = [Neurons{n,1}(1:6),'_1_',num2str(Neurons{n,2})];
    Errfilename = [Neurons{n,1}(1:6),'_2_',num2str(Neurons{n,2}),'_erriscuesac'];
    try
        [psth_temp1, psth_temp2, psth_temp3, psth_temp4, ntrs_temp] = Get_PsthM_AllTrials_rawProcessingTime_alignSac(Antifilename,best_target(n));
        psth1(n,:) = psth_temp1;
        psth3(n,:) = psth_temp2;
        psth5(n,:) = psth_temp3;
        psth7(n,:) = psth_temp4;
        ntrs(n,:) = ntrs_temp;
    catch
        disp(['error processing neuron  ', Antifilename  '  Dir1=' num2str(best_target(n))])
    end
end
jj=1;
for j = 1:n
    if length(find(psth1(j,:)~= 0))>0 && length(find(psth3(j,:) ~= 0))>0 && length(find(psth5(j,:) ~= 0))>0 && length(find(psth7(j,:) ~= 0))>0
        psth1a(jj,:)=psth1(j,:);
        psth3a(jj,:)=psth3(j,:);
        psth5a(jj,:)=psth5(j,:);
        psth7a(jj,:)=psth7(j,:);
        ntrsa(jj,:)=ntrs(j,:);
        jj=jj+1;
    end
end
nn=jj-1;
ntrsa=sum(ntrsa);
definepsthmax=50;

% fig=openfig('samePFCneurons');
figure
% set( gcf, 'Color', 'White', 'Unit', 'Normalized', ...
%     'Position', [0.1,0.1,0.8,0.8] ) ;
bin_width = 0.05;  % 50 milliseconds bin
bin_edges=-.8:bin_width:1.5;
bins = bin_edges+0.5*bin_width;
hold on
try
    psth1mean = sum(psth1a)/nn;
    psth3mean = sum(psth3a)/nn;
    psth5mean = sum(psth5a)/nn;
    psth7mean = sum(psth7a)/nn;
catch
end
try
    plot(bins,psth1mean,'r','LineWidth',2);
    plot(bins,psth3mean,'m','LineWidth',2);
    plot(bins,psth5mean,'b','LineWidth',2);
    plot(bins,psth7mean,'c','LineWidth',2);
catch
end
% try
%     psth3mean = sum(psth3a)/nn;
% catch
% end
% try
%     plot(bins,psth3mean,'m','-o','LineWidth',3);
% catch
% end
% try
%     psth5mean = sum(psth5a)/nn;
% catch
% end
% try
%     plot(bins,psth5mean,'m','--','LineWidth',3);
% catch
% end
% try
%     psth7mean = sum(psth7a)/nn;
% catch
% end
% try
%     plot(bins,psth7mean,'m','LineWidth',3);
% catch
% end

line([0 0], [0 50],'color','k')
axis([-0.5 1.5 0 definepsthmax+0.2])
xlim([-0.5 0.5])
xlabel('Time s')
ylabel('Firing Rate spikes/s')
gtext({[num2str(nn) ' neurons ' num2str(ntrsa(1)) '/' num2str(ntrsa(2)) '/' num2str(ntrsa(3)) '/' num2str(ntrsa(4)) ' trials']},'color','b', 'FontWeight', 'Bold')

% subplot(2,2,1)
% bin_width = 0.05;  % 50 milliseconds bin
% bin_edges=-.8:bin_width:1.5;
% bins = bin_edges+0.5*bin_width;
% hold on
% try
%     psth1mean = sum(psth1a)/nn;
% catch
% end
% try
%     plot(bins,psth1mean,'m','LineWidth',3);
% catch
% end
%
% line([0 0], [0 50],'color','k')
% axis([-0.5 1.5 0 definepsthmax+0.2])
% xlim([-0.5 0.5])
% xlabel('Time s')0.075-
% ylabel('Firing Rate spikes/s')
% title('0-0.075s')
% gtext({[num2str(nn) ' neurons ' num2str(ntrsa(1)) ' trials']},'color','m', 'FontWeight', 'Bold')
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(2,2,2)
% bin_width = 0.05;  % 50 milliseconds bin
% bin_edges=-.8:bin_width:1.5;
% bins = bin_edges+0.5*bin_width;
% hold on
%
% try
%     psth3mean = sum(psth3a)/nn;
% catch
% end
% try
%     plot(bins,psth3mean,'m','LineWidth',3);
% catch
% end
%
% line([0 0], [0 50],'color','k')
% axis([-0.5 1.5 0 definepsthmax+0.2])
% xlim([-0.5 0.5])
% xlabel('Time s')
% ylabel('Firing Rate spikes/s')
% title('0.075-0.120s')
% gtext({[num2str(nn) ' neurons ' num2str(ntrsa(2)) ' trials']},'color','m', 'FontWeight', 'Bold')
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(2,2,3)
% bin_width = 0.05;  % 50 milliseconds bin
% bin_edges=-.8:bin_width:1.5;
% bins = bin_edges+0.5*bin_width;
% hold on
%
% try
%     psth5mean = sum(psth5a)/nn;
% catch
% end
% try
%     plot(bins,psth5mean,'m','LineWidth',3);
% catch
% end
%
% line([0 0], [0 50],'color','k')
% axis([-0.5 1.5 0 definepsthmax+0.2])
% xlim([-0.5 0.5])
% xlabel('Time s')
% ylabel('Firing Rate spikes/s')
% title('0.120-0.150s')
% gtext({[num2str(nn) ' neurons ' num2str(ntrsa(3)) ' trials']},'color','m', 'FontWeight', 'Bold')
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(2,2,4)
% bin_width = 0.05;  % 50 milliseconds bin
% bin_edges=-.8:bin_width:1.5;
% bins = bin_edges+0.5*bin_width;
% hold on
%
% try
%     psth7mean = sum(psth7a)/nn;
% catch
% end
% try
%     plot(bins,psth7mean,'m','LineWidth',3);
% catch
% end
%
% line([0 0], [0 50],'color','k')
% axis([-0.5 1.5 0 definepsthmax+0.2])
% xlim([-0.5 0.5])
% xlabel('Time s')
% ylabel('Firing Rate spikes/s')
% title('>0.150s')
% gtext({[num2str(nn) ' neurons ' num2str(ntrsa(4)) ' trials']},'color','m', 'FontWeight', 'Bold')

axes( 'Position', [0, 0.95, 1, 0.05] ) ;
set( gca, 'Color', 'None', 'XColor', 'None', 'YColor', 'None' ) ;
text( 0.5, 0, 'PFC neurons Align on Sacaade', 'FontSize', 12', 'FontWeight', 'Bold', ...
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