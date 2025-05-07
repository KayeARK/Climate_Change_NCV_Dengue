clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 18)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

PropUnc2060=load('../../Data/WithPopChange/ProportionOfUncertainty/PropUnc2060').PropUnc2060;
PropUnc2100=load('../../Data/WithPopChange/ProportionOfUncertainty/PropUnc2100').PropUnc2100;

load('../../Data/Population_data/WangMengLongPop2100_SSP3.mat')

load coastlines
lon=linspace(-180,180,288);
lat=linspace(-90,90,192);

lono=linspace(-180,180,1000);
lato=fliplr(linspace(-90,90,1000));

lonpop=linspace(-180.0012,179.9987,43200);
latpop=linspace(-72.0004,83.9996,18720);

PropUnc2100(pop2100<20)=NaN;
PropUnc2100=flipud(PropUnc2100);

%% 



figure(2)

myColorMap=parula(256);
%myColorMap(1,:)=1;
colormap(myColorMap);
imagesc(lonpop,latpop,PropUnc2100,'AlphaData',~isnan(PropUnc2100))
set(gca,'YDir','normal')
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.Interpreter = 'latex';
caxis([0,1])
set(c,'YTick',0:0.1:1)
c.Label.String='Proportion of uncertainty in $R_{0}$ from NCV in 2100';
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

exportgraphics(gcf,'Figure4A.pdf')

%% 

%zero=(PropUnc2100==0);
PropUnc2100(PropUnc2100<0.5)=-1;
PropUnc2100(PropUnc2100>0.5)=1;
%PropUnc2100(zero)=0;


%% 

myColorMap=[225/256,110/256,224/256;1,1,1;30/256,145/256,31/256]; %original

figure(4)
colormap(myColorMap);
imagesc(lonpop,latpop,PropUnc2100,'AlphaData',~isnan(PropUnc2100))
set(gca,'YDir','normal') 
hold on
plot(coastlon,coastlat,'color','k','LineWidth',0.7)
c=colorbar('SouthOutside');
c.Label.Interpreter = 'latex';
clim([-1 1]);
set(c,'YTick',-2/3:2/3:2/3)
set(c,'YTickLabel',{'Parameter','No transmission','NCV'})
c.Label.String='Dominant source of uncertainty in $R_{0}$ in 2100';
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

exportgraphics(gcf,'Figure4B.pdf')
