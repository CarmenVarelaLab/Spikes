function [PETH, h] = periEvHistogram(spiketimes,evTimestamps,width,bin)
% calculate the average peri-event histogram in spikes/sec given the spike
% times and event times (provide event timestamps in a column vector) 
% width -- determines the x-axis of the histogram (from - width to  + width)
% bin -- bin size

edges = -width:bin:width;
evTimestamps= reshape(evTimestamps,length(evTimestamps),1);  % column vector

% calculate average histogram
%%%%%%%%%%%%%%%%%%%%%%%%%%
% keep results
periEvHist = zeros(size(evTimestamps,1),size(edges,2)-1);
%  keep the spike times for raster plots
PeakTriggSpks = cell(size(evTimestamps,1),1);

for i= 1:size(evTimestamps,1)
    temp1= (spiketimes(spiketimes> (evTimestamps(i)-width) & spiketimes < (evTimestamps(i)+width)))-evTimestamps(i);  
    PeakTriggSpks{i,:}= temp1;
    periEvHist(i,:)= histcounts(PeakTriggSpks{i,:}',edges);      
end
% average across K-complexes in spks/s
PETH = mean(periEvHist,1)./bin;   

%%   PLOT
scrsz=get(0,'screensize'); 
h = figure('Position',[70 50 scrsz(3)./2 scrsz(4)/1.2]); 

subplot(2,1,1);  % Raster
cs= 1;
for n= 1:size(evTimestamps,1)  
    spikesd= PeakTriggSpks{n,:}';
    x= repmat(spikesd,2,1);
    sx=size(x,2);
    y1 = cs+0.5 *(ones(1,sx));
    y2= cs-0.5 *(ones(1,sx));
    y3= NaN(1,sx);
    y= [y1;y2;y3];
    notnum= NaN(1,sx);
    x= cat(1,x,notnum);
    sss= size(x);
    x = reshape(x,1,sss(1)*sss(2));
    y = reshape(y,1,sss(1)*sss(2));
    subplot(2,1,1);
    hold on;
    plot(x,y,'k','linewidth',1);
    cs=cs+1;
end
xlabel('Time (s)'); ylabel('Event number');
set(gca,'linewidth',1.5);
set(gca,'TickDir','out');
set(gca,'fontsize',12); 

subplot(2,1,2);  % histogram
plot(edges(1:end-1)+(bin./2),(PETH),'linewidth',1.5); 
xlabel('Time (s)'); ylabel('Spikes/s');
set(gcf, 'color', 'white'); 
set(gca,'linewidth',1.5);
set(gca,'TickDir','out');
set(gca,'fontsize',12); 


