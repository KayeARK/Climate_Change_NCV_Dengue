clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 17)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

R0Lookup=load('../../Data/Lookup_tables/Lookup R0.mat');
MLookup=load('../../Data/Lookup_tables/Lookup M.mat');

recovery_rate=1/5;
population=15000;
area=(1000^2); %in m^2

medianR0=R0Lookup.MedianR0;
maxR0=R0Lookup.BiggestR0;
minR0=R0Lookup.SmallestR0;

medianM=MLookup.MedianM;
maxM=MLookup.BiggestM;
minM=MLookup.SmallestM;

population_density=population/area;

factor=sqrt(1/(population_density*recovery_rate));
medianR0=medianR0*factor;
maxR0=maxR0*factor;
minR0=minR0*factor;

temp=linspace(0,40,401);
rain=linspace(0,30,301);

figure(1)
imagesc(temp,rain,medianR0)
set(gca,'YDir','normal') 
clim([0 7])
xlabel("Rainfall (mm day$^{-1}$)")
ylabel("Temperature ($^{\circ}$C)")
c=colorbar("northoutside");
c.Label.String="R_{0}";
pos=get(gcf,'Position');
set(gcf,'PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
exportgraphics(gcf,'Figure1C.pdf')

figure(2)
imagesc(temp,rain,maxR0)
set(gca,'YDir','normal') 
clim([0 7])
xlabel("Rainfall (mm day$^{-1}$)")
ylabel("Temperature ($^{\circ}$C)")
colorbar("northoutside")
c.Label.String="R_{0}";
pos = get(gca,'Position');
exportgraphics(gcf,'Figure1D.pdf')

figure(3)
imagesc(temp,rain,minR0)
set(gca,'YDir','normal') 
clim([0 7])
xlabel("Rainfall (mm day$^{-1}$)")
ylabel("Temperature ($^{\circ}$C)")
colorbar("northoutside")
c.Label.String="R_{0}";
exportgraphics(gcf,'Figure1B.pdf')