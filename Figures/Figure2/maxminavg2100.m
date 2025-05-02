clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

load("../../Data/WithPopChange/R0WithPop/SuitabilityStatistics/suitability_2100.mat")
load("../../Data/WithPopChange/WangMengLongPop2100.mat")
 
%% 

pop_threshold=20;

pop2100(pop2100<=pop_threshold)=NaN;
pop2100(pop2100>pop_threshold)=1;

avg_suitability_2100=avg_suitability_2100.*pop2100;
%avg_suitability_2100(avg_suitability_2100==0)=NaN;

max_suitability_2100=max_suitability_2100.*pop2100;
%max_suitability_2100(max_suitability_2100==0)=NaN;

min_suitability_2100=min_suitability_2100.*pop2100;
%min_suitability_2100(min_suitability_2100==0)=NaN;

lon=linspace(-180.0012,179.9987,43200);
lat=linspace(-72.0004,83.9996,18720);


filename = gunzip("gshhs_h.b.gz");
S = gshhs(filename{1});
coastlat = [S.Lat];
coastlon = [S.Lon];

myColorMap=parula(256);
%% 

figure(1)
colormap(myColorMap);
imagesc(lon,fliplr(lat),avg_suitability_2100,'AlphaData',~isnan(avg_suitability_2100))
set(gca,'YDir','normal') 
hold on
xlim([-12,30])
ylim([35,60])
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Average number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 9]);
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'AvgR0g1_2100_Europe.pdf')

figure(2)
colormap(myColorMap);
imagesc(lon,fliplr(lat),max_suitability_2100,'AlphaData',~isnan(max_suitability_2100))
set(gca,'YDir','normal') 
hold on
xlim([-12,30])
ylim([35,60])
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Maximum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 9]);
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'MaxR0g1_2100_Europe.pdf')

figure(3)
colormap(myColorMap);
imagesc(lon,fliplr(lat),min_suitability_2100,'AlphaData',~isnan(min_suitability_2100))
set(gca,'YDir','normal') 
hold on
xlim([-12,30])
ylim([35,60])
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Minimum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 9]);
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'MinR0g1_2100_Europe.pdf')


%% 

figure(4)
colormap(myColorMap);
imagesc(lon,fliplr(lat),avg_suitability_2100,'AlphaData',~isnan(avg_suitability_2100))
set(gca,'YDir','normal') 
hold on
xlim([40,160])
ylim([-12,45])
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Average number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'AvgR0g1_2100_Asia.pdf')

figure(5)
colormap(myColorMap);
imagesc(lon,fliplr(lat),max_suitability_2100,'AlphaData',~isnan(max_suitability_2100))
set(gca,'YDir','normal') 
hold on
xlim([40,160])
ylim([-12,45])
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Maximum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'MaxR0g1_2100_Asia.pdf')

figure(6)
colormap(myColorMap);
imagesc(lon,fliplr(lat),min_suitability_2100,'AlphaData',~isnan(min_suitability_2100))
set(gca,'YDir','normal') 
hold on
xlim([40,160])
ylim([-12,45])
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Minimum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'MinR0g1_2100_Asia.pdf')

%% 

figure(7)
colormap(myColorMap);
imagesc(lon,fliplr(lat),avg_suitability_2100,'AlphaData',~isnan(avg_suitability_2100))
set(gca,'YDir','normal') 
hold on
xlim([-130,-30])
ylim([-60,50])
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Average number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'AvgR0g1_2100_America.pdf')

figure(8)
colormap(myColorMap);
imagesc(lon,fliplr(lat),max_suitability_2100,'AlphaData',~isnan(max_suitability_2100))
set(gca,'YDir','normal') 
hold on
xlim([-130,-30])
ylim([-60,50])
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Maximum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'MaxR0g1_2100_America.pdf')

figure(9)
colormap(myColorMap);
imagesc(lon,fliplr(lat),min_suitability_2100,'AlphaData',~isnan(min_suitability_2100))
set(gca,'YDir','normal') 
hold on
xlim([-130,-30])
ylim([-60,50])
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Minimum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'MinR0g1_2100_America.pdf')

%% 

figure(10)
colormap(myColorMap);
imagesc(lon,fliplr(lat),avg_suitability_2100,'AlphaData',~isnan(avg_suitability_2100))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Average number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
xlim([-20,55])
ylim([-36,38])
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'AvgR0g1_2100_Africa.pdf')

figure(11)
colormap(myColorMap);
imagesc(lon,fliplr(lat),max_suitability_2100,'AlphaData',~isnan(max_suitability_2100))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Maximum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
xlim([-20,55])
ylim([-36,38])
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'MaxR0g1_2100_Africa.pdf')

figure(12)
colormap(myColorMap);
imagesc(lon,fliplr(lat),min_suitability_2100,'AlphaData',~isnan(min_suitability_2100))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar;
c.Label.String='Minimum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
clim([0 12]);
xlim([-20,55])
ylim([-36,38])
xlabel("Longitude")
ylabel("Latitude")

exportgraphics(gcf,'MinR0g1_2100_Africa.pdf')


%% 

load coastlines

figure(13)
colormap(myColorMap);
imagesc(lon,fliplr(lat),avg_suitability_2100,'AlphaData',~isnan(avg_suitability_2100))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.String='Average number of months for which $R_{0}>1$';
c.FontSize=18;
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

exportgraphics(gcf,'AvgR0g1_2100_World.pdf')

figure(14)
colormap(myColorMap);
imagesc(lon,fliplr(lat),max_suitability_2100,'AlphaData',~isnan(max_suitability_2100))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.String='Maximum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
c.FontSize=18;
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

exportgraphics(gcf,'MaxR0g1_2100_World.pdf')

figure(15)
colormap(myColorMap);
imagesc(lon,fliplr(lat),min_suitability_2100,'AlphaData',~isnan(min_suitability_2100))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.String='Minimum number of months for which $R_{0}>1$';
c.Label.Interpreter = 'latex';
c.FontSize=18;
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

exportgraphics(gcf,'MinR0g1_2100_World.pdf')

figure(16)
colormap(myColorMap);
imagesc(lon,fliplr(lat),max_suitability_2100-min_suitability_2100,'AlphaData',~isnan(min_suitability_2100))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.String='Difference in months between the most and least suitable climate projection';
c.Label.Interpreter = 'latex';
%c.FontSize=18;
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

exportgraphics(gcf,'DiffR0g1_2100_World.pdf')