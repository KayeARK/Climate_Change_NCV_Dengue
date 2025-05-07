clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

load("../../Data/WithPopChange/R0_SSP3/SuitabilityStatistics/suitability_2060.mat")
load("../../Data/Population_data/WangMengLongPop2060_SSP3.mat")

pop_threshold=20;

pop2060(pop2060<=pop_threshold)=NaN;
pop2060(pop2060>pop_threshold)=1;

avg_suitability_2060=avg_suitability_2060.*pop2060;
%avg_suitability_2060(avg_suitability_2060==0)=NaN;

max_suitability_2060=max_suitability_2060.*pop2060;
%max_suitability_2060(max_suitability_2060==0)=NaN;

min_suitability_2060=min_suitability_2060.*pop2060;
%min_suitability_2060(min_suitability_2060==0)=NaN;

lon=linspace(-180.0012,179.9987,43200);
lat=linspace(-72.0004,83.9996,18720);


filename = gunzip("../../Data/Border_data/gshhs_h.b.gz");
S = gshhs(filename{1});
coastlat = [S.Lat];
coastlon = [S.Lon];

myColorMap=parula(256);
%myColorMap(1,:)=1;


%% 

load coastlines

figure(13)
colormap(myColorMap);
imagesc(lon,fliplr(lat),avg_suitability_2060,'AlphaData',~isnan(avg_suitability_2060))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.String='Average number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
x1=get(gca,'position');
colorbarpos=c.Position;
colorbarpos(4)=colorbarpos(4)*0.5;
colorbarpos(2)=colorbarpos(2)+0.07;
set(c,'Position',colorbarpos);
set(gca,'position',x1);
%xlabel("Longitude")
%ylabel("Latitude")
xticklabels({""})
yticklabels({""})
set(gca,'xtick',[])
set(gca,'ytick',[])
xlim([-180,180])
ylim([-90,90])

exportgraphics(gcf,'FigureS17C.pdf')

figure(14)
colormap(myColorMap);
imagesc(lon,fliplr(lat),max_suitability_2060,'AlphaData',~isnan(max_suitability_2060))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.String='Maximum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
x1=get(gca,'position');
colorbarpos=c.Position;
colorbarpos(4)=colorbarpos(4)*0.5;
colorbarpos(2)=colorbarpos(2)+0.07;
set(c,'Position',colorbarpos);
set(gca,'position',x1);
%xlabel("Longitude")
%ylabel("Latitude")
xticklabels({""})
yticklabels({""})
set(gca,'xtick',[])
set(gca,'ytick',[])
xlim([-180,180])
ylim([-90,90])

exportgraphics(gcf,'FigureS17B.pdf')

figure(15)
colormap(myColorMap);
imagesc(lon,fliplr(lat),min_suitability_2060,'AlphaData',~isnan(min_suitability_2060))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.String='Minimum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
x1=get(gca,'position');
colorbarpos=c.Position;
colorbarpos(4)=colorbarpos(4)*0.5;
colorbarpos(2)=colorbarpos(2)+0.07;
set(c,'Position',colorbarpos);
set(gca,'position',x1);
%xlabel("Longitude")
%ylabel("Latitude")
xticklabels({""})
yticklabels({""})
set(gca,'xtick',[])
set(gca,'ytick',[])
xlim([-180,180])
ylim([-90,90])

exportgraphics(gcf,'FigureS17A.pdf')