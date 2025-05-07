clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

load("../../../Data/Literature_niches/SSP3/Villena_Stephensi_Vivax/SuitabilityStatisticsWithPop/BestCase.mat")

min_suitability_2100=BestCase2100;

load("../../../Data/Population_data/WangMengLongPop2100_SSP3.mat")

pop_threshold=20;

pop2100(pop2100<=pop_threshold)=NaN;
pop2100(pop2100>pop_threshold)=1;

min_suitability_2100=min_suitability_2100.*pop2100;

lon=linspace(-180.0012,179.9987,43200);
lat=linspace(-72.0004,83.9996,18720);

myColorMap=parula(256); 

load coastlines

figure(1)
colormap(myColorMap);
imagesc(lon,fliplr(lat),min_suitability_2100,'AlphaData',~isnan(min_suitability_2100))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.String='Minimum number of months for which $R_{0}>0$';
c.Label.Interpreter = 'latex';
clim([0 12]);
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

exportgraphics(gcf,'FigureS15C.pdf')

%% 

clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

load("../../../Data/Literature_niches/SSP3/Villena_Stephensi_Vivax/SuitabilityStatisticsWithPop/WorstCase.mat")

max_suitability_2100=WorstCase2100;

load("../../../Data/Population_data/WangMengLongPop2100_SSP3.mat")

pop_threshold=20;

pop2100(pop2100<=pop_threshold)=NaN;
pop2100(pop2100>pop_threshold)=1;

max_suitability_2100=max_suitability_2100.*pop2100;

lon=linspace(-180.0012,179.9987,43200);
lat=linspace(-72.0004,83.9996,18720);


myColorMap=parula(256);

load coastlines

figure(2)
colormap(myColorMap);
imagesc(lon,fliplr(lat),max_suitability_2100,'AlphaData',~isnan(max_suitability_2100))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.String='Maximum number of months for which $R_{0}>0$';
c.Label.Interpreter = 'latex';
clim([0 12]);
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

exportgraphics(gcf,'FigureS15D.pdf')
