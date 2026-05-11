clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

load("../../Data/WithoutPopChange/R0/SuitabilityStatistics/suitability_2020.mat")
load("../../Data/Population_data/WorldPop2020.mat")

%% 

vector_data=readmatrix("../../Data/Vector distribution data/aegypti.csv");
vector_latitude=vector_data(:,6);
vector_longitude=vector_data(:,7);

 
%% 

pop_threshold=20;

pop2020(pop2020<=pop_threshold)=NaN;
pop2020(pop2020>pop_threshold)=1;

avg_suitability_2020=avg_suitability_2020.*pop2020;
%avg_suitability_2020(avg_suitability_2020==0)=NaN;

max_suitability_2020=max_suitability_2020.*pop2020;
%max_suitability_2020(max_suitability_2020==0)=NaN;

min_suitability_2020=min_suitability_2020.*pop2020;
%min_suitability_2020(min_suitability_2020==0)=NaN;

lon=linspace(-180.0012,179.9987,43200);
lat=linspace(-72.0004,83.9996,18720);

%% 

avg_suitability_2020(avg_suitability_2020<3)=0;
avg_suitability_2020(avg_suitability_2020>=3)=1;



%% 
load coastlines
myColorMap=[121/256,159/256,203/256;249/256,102/256,94/256];
sageGreen = [102 166 130]/256;

figure(1)
colormap(myColorMap);
imagesc(lon,fliplr(lat),avg_suitability_2020,'AlphaData',~isnan(avg_suitability_2020))
set(gca,'YDir','normal') 
hold on
xlim([-180,180])
ylim([-90,90])
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
hVector=scatter(vector_longitude,vector_latitude,0.8,'filled','MarkerFaceColor',sageGreen);
c=colorbar;
c.Label.String='';
c.Label.Interpreter = 'latex';
c.TickLabelInterpreter = 'tex';
clim([0 1]);
set(c,'YTick',[1/4,3/4])
c.TickLabels = { ...
    '< 3 months suitability', ...
    '\geq 3 months suitability'};
c.Label.String = 'Suitability';
c.Label.Interpreter = 'latex';
legend(hVector,'\textit{Aedes aegypti} occurrence records',...
    'Location','southwest')
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'FigureS23.pdf')