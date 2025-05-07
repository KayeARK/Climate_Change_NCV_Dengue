clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 18)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

avg_suitability_2020=load("../../Data/WithoutPopChange/R0_SSP3/SuitabilityStatistics/suitability_2020.mat").avg_suitability_2020;
avg_suitability_2100=load("../../Data/WithPopChange/R0_SSP3/SuitabilityStatistics/suitability_2100.mat").avg_suitability_2100;
load("../../Data/Population_data/WorldPop2020.mat")
load("../../Data/Population_data/WangMengLongPop2100_SSP3.mat")

pop_threshold=20;

pop2020(pop2020<=pop_threshold)=0;
pop2020(pop2020>pop_threshold)=1;

pop2100(pop2100<=pop_threshold)=0;
pop2100(pop2100>pop_threshold)=1;

avg_suitability_2020=avg_suitability_2020.*pop2020;
%avg_suitability_2020(avg_suitability_2020==0)=NaN;

avg_suitability_2100=avg_suitability_2100.*pop2100;
%avg_suitability_2100(avg_suitability_2100==0)=NaN;

diff_avg_suitability=avg_suitability_2100-avg_suitability_2020;

lon=linspace(-180.0012,179.9987,43200);
lat=linspace(-72.0004,83.9996,18720);

load coastlines


%% 
myColorMap=[121/256,159/256,203/256;1,1,1;249/256,102/256,94/256]; %original

ecmap=avg_suitability_2100-avg_suitability_2020;
up=1;
ecmap(ecmap>up)=1;
ecmap(ecmap<-up)=-1;
ecmap(ecmap<up & ecmap>-up)=0;

%% 

figure(1)
colormap(myColorMap);
imagesc(lon,fliplr(lat),ecmap,'AlphaData',~isnan(ecmap))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.String='Average number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([-1 1]);
set(c,'YTick',-2/3:2/3:2/3)
set(c,'YTickLabel',{'Decrease','Stable','Increase'})
c.Label.String='Change in number of months suitable for sustained transmission';
c.FontSize=18;
x1=get(gca,'position');
colorbarpos=c.Position;
colorbarpos(4)=colorbarpos(4)*0.5;
colorbarpos(2)=colorbarpos(2)+0.07;
set(c,'Position',colorbarpos);
set(gca,'position',x1);
xticklabels({""})
yticklabels({""})
set(gca,'xtick',[])
set(gca,'ytick',[])
xlim([-180,180])
ylim([-90,90])

exportgraphics(gcf,'Figure2B.pdf')

