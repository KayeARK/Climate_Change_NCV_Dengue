clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))


iterations=100000;
burnin=50000;

T=readtable('../../Data/MCMC/aegyptiDENVmodelTempData_2016-03-30.csv');

x=T.trait_name;
temps=T.T;
traits=T.trait;
yprime=T.ref;

y=strings(1,length(x));
for i=1:length(x)
      y(i)=num2str(cell2mat(x(i)));
end


%% 

a=load('../../Data/MCMC/aParasAegypti.mat');
burntchain=a.burntchain;
acceptance=a.acceptance;

a=[];
aT=[];

for i=1:length(x)
    if y(i)=='GCR'
        aT=[aT temps(i)];
        a=[a traits(i)];
    end
end



temp=aT;
resp=a;

testx=linspace(0,max(temp)+10,100);
cmean=mean(burntchain(1,:));
T0mean=mean(burntchain(2,:));
Tmmean=mean(burntchain(3,:));
testy3=cmean.*testx.*(testx-T0mean).*sqrt(Tmmean-testx);
testy3=max(0,real(testy3));


c=burntchain(1,:);
T0=burntchain(2,:);
Tm=burntchain(3,:);

testy2=[];
for i=1:length(testx)
testy=c.*testx(i).*(testx(i)-T0).*sqrt(Tm-testx(i));
testy=max(0,real(testy))';

testy2=[testy2, testy];
end

% C025=[];
% C975=[];
% for i=1:length(testx)
%     p=sort(testy2(:,i));
%     C025=[C025 p(1250)];
%     C975=[C975 p(48750)];
% end


C025=prctile(testy2,2.5,1);
C975=prctile(testy2,97.5,1);

testy2=median(testy2,1);


[temp,sortIdx] = sort(temp,'ascend');
resp = resp(sortIdx);


tempp=[];
count=0;
for i=unique(temp)

   count=count+1;
   temp1=(temp==i);
   temp2=resp.*temp1;
   
   if sum(temp2)>0       
       tempp(count)=mean(nonzeros(temp2));
   else
       tempp(count)=0;
   end    
    
end

resp=tempp;
temp=unique(temp);


figure(1)
subplot(3,4,1)
h1=histogram(burntchain(1,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(1,:)),max(burntchain(1,:)),1000);
range=gampdf(supp,3.5,0.0001);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(1,:)),max(burntchain(1,:))])
xlabel({"`Height', $\alpha$";''},'fontSize',12)
ylabel("Probability density",'fontSize',12);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'A','FontSize',20,'EdgeColor','none')


subplot(3,4,2)
h2=histogram(burntchain(2,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(2,:)),max(burntchain(2,:)),1000);
range=gampdf(supp,8,2);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(2,:)),max(burntchain(2,:))])
xlabel("First suitable temperature, $T_{0}$",'fontSize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'B','FontSize',20,'EdgeColor','none')


subplot(3,4,3)
h3=histogram(burntchain(3,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(3,:)),max(burntchain(3,:)),1000);
range=gampdf(supp,10,4);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(3,:)),max(burntchain(3,:))])
xlabel("Last suitable temperature, $T_{m}$",'fontSize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'C','FontSize',20,'EdgeColor','none')

subplot(3,4,4)
h4=histogram(burntchain(4,:),'Normalization','pdf');
h1.EdgeColor = 'none';
h2.EdgeColor = 'none';
h3.EdgeColor = 'none';
h4.EdgeColor = 'none';
alpha(1)
hold on
supp=linspace(min(burntchain(4,:)),max(burntchain(4,:)),1000);
range=unifpdf(supp,0,2);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(4,:)),max(burntchain(4,:))])
xlabel("Variance, $\sigma^{2}$",'fontsize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'D','FontSize',20,'EdgeColor','none')

subplot(3,4,5)
plot(burntchain(1,:))
ylabel("`Height', $\alpha$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'E','FontSize',20,'EdgeColor','none')

subplot(3,4,6)
plot(burntchain(2,:))
ylabel("First suitable temperature, $T_{0}$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'F','FontSize',20,'EdgeColor','none')

subplot(3,4,7)
plot(burntchain(3,:))
ylabel("Last suitable temperature, $T_{m}$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'G','FontSize',20,'EdgeColor','none')

subplot(3,4,8)
plot(burntchain(4,:))
ylabel("Variance, $\sigma^{2}$",'fontsize',12);
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'H','FontSize',20,'EdgeColor','none')

subplot(3,2,5)
scatter(temp,resp,'filled','MarkerFaceColor',[0.4000    0.7608    0.6471])
xlabel("Temperature,{\it T} ($^{\circ}$C)")
ylabel("Bite rate, $\kappa(T)$ (day$^{-1}$)")
box on
xlim([0 50])
ylim([0 0.45])

ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'I','FontSize',20,'EdgeColor','none')

subplot(3,2,6)
plot(testx,testy2,'color',[0.9882    0.5529    0.3843])
hold on
patch([testx testx], [C025 C975],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
scatter(temp,resp,'filled','MarkerFaceColor',[0.4000    0.7608    0.6471])
xlabel("Temperature,{\it T} ($^{\circ}$C)")
ylabel("Bite rate, $\kappa(T)$ (day$^{-1}$)")
xlim([0 50])
ylim([0 0.45])
legend("Median","$95\%$ CrI","Data",'Location','northwest');
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'J','FontSize',20,'EdgeColor','none')

set(gcf,'Units', 'centimeters', 'Position', [0 0 35 30], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS1.pdf -pdf -r300 -Opengl 


%%


b=load('../../Data/MCMC/binformativeParasAegypti.mat');
%b=load('binformativeParasAegypti.mat');
burntchain=b.burntchain;
acceptance=b.acceptance;

bT=[];
b=[];

for i=1:length(x)
    if (yprime(i)=="Watts_et_al_1987_AJTMH" || yprime(i)=="Alto&Bettinardi_2013_AJTMH" || yprime(i)=="Carrington_et_al_2013_PNTD") && y(i)=='b'
        bT=[bT temps(i)];
        b=[b traits(i)];
    end
end



temp=bT;
resp=b;

testx=linspace(0,max(temp)+10,100);
cmean=mean(burntchain(1,:));
T0mean=mean(burntchain(2,:));
Tmmean=mean(burntchain(3,:));
testy3=cmean.*testx.*(testx-T0mean).*sqrt(Tmmean-testx);
testy3=max(0,real(testy3));


c=burntchain(1,:);
T0=burntchain(2,:);
Tm=burntchain(3,:);

testy2=[];
for i=1:length(testx)
testy=c.*testx(i).*(testx(i)-T0).*sqrt(Tm-testx(i));
testy=max(0,real(testy))';

testy2=[testy2, testy];
end

% C025=[];
% C975=[];
% for i=1:length(testx)
%     p=sort(testy2(:,i));
%     C025=[C025 p(1250)];
%     C975=[C975 p(48750)];
% end

C025=prctile(testy2,2.5,1);
C975=prctile(testy2,97.5,1);

testy2=median(testy2,1);

[temp,sortIdx] = sort(temp,'ascend');
resp = resp(sortIdx);


tempp=[];
count=0;
for i=unique(temp)

   count=count+1;
   temp1=(temp==i);
   temp2=resp.*temp1;
   
   if sum(temp2)>0       
       tempp(count)=mean(nonzeros(temp2));
   else
       tempp(count)=0;
   end    
    
end

resp=tempp;
temp=unique(temp);


figure(2)
subplot(3,4,1)
h1=histogram(burntchain(1,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(1,:)),max(burntchain(1,:)),1000);
range=gampdf(supp,6,0.0001);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(1,:)),max(burntchain(1,:))])
xlabel({"`Height', $\alpha$";''},'fontSize',12)
ylabel("Probability density",'fontSize',12);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'A','FontSize',20,'EdgeColor','none')

subplot(3,4,2)
h2=histogram(burntchain(2,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(2,:)),max(burntchain(2,:)),1000);
range=gampdf(supp,8,2);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(2,:)),max(burntchain(2,:))])
xlabel("First suitable temperature, $T_{0}$",'fontSize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'B','FontSize',20,'EdgeColor','none')

subplot(3,4,3)
h3=histogram(burntchain(3,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(3,:)),max(burntchain(3,:)),1000);
range=unifpdf(supp,25,45);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(3,:)),max(burntchain(3,:))])
xlabel("Last suitable temperature, $T_{m}$",'fontSize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'C','FontSize',20,'EdgeColor','none')

subplot(3,4,4)
h4=histogram(burntchain(4,:),'Normalization','pdf');
alpha(1)
h1.EdgeColor = 'none';
h2.EdgeColor = 'none';
h3.EdgeColor = 'none';
h4.EdgeColor = 'none';
hold on
supp=linspace(min(burntchain(4,:)),max(burntchain(4,:)),1000);
range=unifpdf(supp,0,2);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(4,:)),max(burntchain(4,:))])
xlabel("Variance, $\sigma^{2}$",'fontsize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'D','FontSize',20,'EdgeColor','none')

subplot(3,4,5)
plot(burntchain(1,:))
ylabel("`Height', $\alpha$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'E','FontSize',20,'EdgeColor','none')

subplot(3,4,6)
plot(burntchain(2,:))
ylabel("First suitable temperature, $T_{0}$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'F','FontSize',20,'EdgeColor','none')

subplot(3,4,7)
plot(burntchain(3,:))
ylabel("Last suitable temperature, $T_{m}$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'G','FontSize',20,'EdgeColor','none')

subplot(3,4,8)
plot(burntchain(4,:))
ylabel("Variance, $\sigma^{2}$",'fontsize',12);
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'H','FontSize',20,'EdgeColor','none')

subplot(3,2,5)
scatter(temp,resp,'filled','MarkerFaceColor',[0.4000    0.7608    0.6471])
xlabel("Temperature,{\it T} ($^{\circ}$C)")
ylabel({"Host susceptibility,"; "$p_{h}(T)$"})
box on
xlim([0 50])

ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'I','FontSize',20,'EdgeColor','none')

subplot(3,2,6)
plot(testx,testy2,'color',[0.9882    0.5529    0.3843])
hold on
patch([testx testx], [C025 C975],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
scatter(temp,resp,'filled','MarkerFaceColor',[0.4000    0.7608    0.6471])
xlabel("Temperature,{\it T} ($^{\circ}$C)")
ylabel({"Host susceptibility,"; "$p_{h}(T)$"})
xlim([0 50])
ylim([0 1])
legend("Median","$95\%$ CrI","Data",'Location','northwest');
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'J','FontSize',20,'EdgeColor','none')

set(gcf, 'Units', 'centimeters', 'Position', [0 0 35 30], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS2.pdf -pdf -r300 -Opengl 

%%

c=load('../../Data/MCMC/cinformativeParasAegypti.mat');
burntchain=c.burntchain;
acceptance=c.acceptance;

cT=[];
c=[];

for i=1:length(x)
    if (yprime(i)=="Watts_et_al_1987_AJTMH" || yprime(i)=="Carrington_et_al_2013_PNTD") && y(i)=='c'
        cT=[cT temps(i)];
        c=[c traits(i)];
    end
end



temp=cT;
resp=c;

testx=linspace(0,max(temp)+10,100);
cmean=mean(burntchain(1,:));
T0mean=mean(burntchain(2,:));
Tmmean=mean(burntchain(3,:));
testy3=cmean.*testx.*(testx-T0mean).*sqrt(Tmmean-testx);
testy3=max(0,real(testy3));


c=burntchain(1,:);
T0=burntchain(2,:);
Tm=burntchain(3,:);

testy2=[];
for i=1:length(testx)
testy=c.*testx(i).*(testx(i)-T0).*sqrt(Tm-testx(i));
testy=max(0,real(testy))';

testy2=[testy2, testy];
end

% C025=[];
% C975=[];
% for i=1:length(testx)
%     p=sort(testy2(:,i));
%     C025=[C025 p(1250)];
%     C975=[C975 p(48750)];
% end

C025=prctile(testy2,2.5,1);
C975=prctile(testy2,97.5,1);

testy2=median(testy2,1);


[temp,sortIdx] = sort(temp,'ascend');
resp = resp(sortIdx);


tempp=[];
count=0;
for i=unique(temp)

   count=count+1;
   temp1=(temp==i);
   temp2=resp.*temp1;
   
   if sum(temp2)>0       
       tempp(count)=mean(nonzeros(temp2));
   else
       tempp(count)=0;
   end    
    
end

resp=tempp;
temp=unique(temp);


figure(3)
subplot(3,4,1)
h1=histogram(burntchain(1,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(1,:)),max(burntchain(1,:)),1000);
range=gampdf(supp,6,0.0001);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(1,:)),max(burntchain(1,:))])
xlabel({"`Height', $\alpha$";''},'fontSize',12)
ylabel("Probability density",'fontSize',12);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'A','FontSize',20,'EdgeColor','none')

subplot(3,4,2)
h2=histogram(burntchain(2,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(2,:)),max(burntchain(2,:)),1000);
range=gampdf(supp,8,2);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(2,:)),max(burntchain(2,:))])
xlabel("First suitable temperature, $T_{0}$",'fontSize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'B','FontSize',20,'EdgeColor','none')

subplot(3,4,3)
h3=histogram(burntchain(3,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(3,:)),max(burntchain(3,:)),1000);
range=unifpdf(supp,25,45);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(3,:)),max(burntchain(3,:))])
xlabel("Last suitable temperature, $T_{m}$",'fontSize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'C','FontSize',20,'EdgeColor','none')

subplot(3,4,4)
h4=histogram(burntchain(4,:),'Normalization','pdf');
alpha(1)
h1.EdgeColor = 'none';
h2.EdgeColor = 'none';
h3.EdgeColor = 'none';
h4.EdgeColor = 'none';
hold on
supp=linspace(min(burntchain(4,:)),max(burntchain(4,:)),1000);
range=unifpdf(supp,0,2);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(4,:)),max(burntchain(4,:))])
xlabel("Variance, $\sigma^{2}$",'fontsize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'D','FontSize',20,'EdgeColor','none')

subplot(3,4,5)
plot(burntchain(1,:))
ylabel("`Height', $\alpha$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'E','FontSize',20,'EdgeColor','none')

subplot(3,4,6)
plot(burntchain(2,:))
ylabel("First suitable temperature, $T_{0}$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'F','FontSize',20,'EdgeColor','none')

subplot(3,4,7)
plot(burntchain(3,:))
ylabel("Last suitable temperature, $T_{m}$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'G','FontSize',20,'EdgeColor','none')

subplot(3,4,8)
plot(burntchain(4,:))
ylabel("Variance, $\sigma^{2}$",'fontsize',12);
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'H','FontSize',20,'EdgeColor','none')

subplot(3,2,5)
scatter(temp,resp,'filled','MarkerFaceColor',[0.4000    0.7608    0.6471])
xlabel("Temperature,{\it T} ($^{\circ}$C)")
ylabel({"Vector susceptibility,"; "$p_{v}(T)$"})
xlim([0 50])
box on

ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'I','FontSize',20,'EdgeColor','none')

subplot(3,2,6)
plot(testx,testy2,'color',[0.9882    0.5529    0.3843])
hold on
patch([testx testx], [C025 C975],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
scatter(temp,resp,'filled','MarkerFaceColor',[0.4000    0.7608    0.6471])
xlabel("Temperature,{\it T} ($^{\circ}$C)")
ylabel({"Vector susceptibility,"; "$p_{v}(T)$"})
xlim([0 50])
legend("Median","$95\%$ CrI","Data",'Location','northwest');
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'J','FontSize',20,'EdgeColor','none')

set(gcf, 'Units', 'centimeters', 'Position', [0 0 35 30], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS3.pdf -pdf -r300 -Opengl 


%%

PDR=load('../../Data/MCMC/PDRinformativeParasAegypti.mat');
burntchain=PDR.burntchain;
acceptance=PDR.acceptance;

PDRT=[];
PDR=[];

for i=1:length(x)
    if yprime(i)=="Davis_1932_AmJEpidemiology" && y(i)=='PDR'
        PDRT=[PDRT temps(i)];
        PDR=[PDR traits(i)];
    elseif y(i)=='EIP'
        PDRT=[PDRT temps(i)];
        PDR=[PDR 1/traits(i)];
    end
end



temp=PDRT;
resp=PDR;

testx=linspace(0,max(temp)+10,100);
cmean=mean(burntchain(1,:));
T0mean=mean(burntchain(2,:));
Tmmean=mean(burntchain(3,:));
testy3=cmean.*testx.*(testx-T0mean).*sqrt(Tmmean-testx);
testy3=max(0,real(testy3));


c=burntchain(1,:);
T0=burntchain(2,:);
Tm=burntchain(3,:);

testy2=[];
for i=1:length(testx)
testy=c.*testx(i).*(testx(i)-T0).*sqrt(Tm-testx(i));
testy=max(0,real(testy))';

testy2=[testy2, testy];
end

% C025=[];
% C975=[];
% for i=1:length(testx)
%     p=sort(testy2(:,i));
%     C025=[C025 p(1250)];
%     C975=[C975 p(48750)];
% end

C025=prctile(testy2,2.5,1);
C975=prctile(testy2,97.5,1);

testy2=median(testy2,1);

[temp,sortIdx] = sort(temp,'ascend');
resp = resp(sortIdx);


tempp=[];
count=0;
for i=unique(temp)

   count=count+1;
   temp1=(temp==i);
   temp2=resp.*temp1;
   
   if sum(temp2)>0       
       tempp(count)=mean(nonzeros(temp2));
   else
       tempp(count)=0;
   end    
    
end

resp=tempp;
temp=unique(temp);


figure(4)
subplot(3,4,1)
h1=histogram(burntchain(1,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(1,:)),max(burntchain(1,:)),1000);
range=gampdf(supp,7,0.00001);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(1,:)),max(burntchain(1,:))])
xlabel({"`Height', $\alpha$";''},'fontSize',12)
ylabel("Probability density",'fontSize',12);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'A','FontSize',20,'EdgeColor','none')

subplot(3,4,2)
h2=histogram(burntchain(2,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(2,:)),max(burntchain(2,:)),1000);
range=gampdf(supp,5,2);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(2,:)),max(burntchain(2,:))])
xlabel("First suitable temperature, $T_{0}$",'fontSize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'B','FontSize',20,'EdgeColor','none')

subplot(3,4,3)
h3=histogram(burntchain(3,:),'Normalization','pdf');
alpha(1)
hold on
supp=linspace(min(burntchain(3,:)),max(burntchain(3,:)),1000);
range=unifpdf(supp,25,45);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(3,:)),max(burntchain(3,:))])
xlabel("Last suitable temperature, $T_{m}$",'fontSize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'C','FontSize',20,'EdgeColor','none')

subplot(3,4,4)
h4=histogram(burntchain(4,:),'Normalization','pdf');
alpha(1)
h1.EdgeColor = 'none';
h2.EdgeColor = 'none';
h3.EdgeColor = 'none';
h4.EdgeColor = 'none';
hold on
supp=linspace(min(burntchain(4,:)),max(burntchain(4,:)),1000);
range=unifpdf(supp,0,1);
plot(supp,range/(trapz(supp,range)))
xlim([min(burntchain(4,:)),max(burntchain(4,:))])
xlabel("Variance, $\sigma^{2}$",'fontsize',12);
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'D','FontSize',20,'EdgeColor','none')

subplot(3,4,5)
plot(burntchain(1,:))
ylabel("`Height', $\alpha$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'E','FontSize',20,'EdgeColor','none')

subplot(3,4,6)
plot(burntchain(2,:))
ylabel("First suitable temperature, $T_{0}$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'F','FontSize',20,'EdgeColor','none')

subplot(3,4,7)
plot(burntchain(3,:))
ylabel("Last suitable temperature, $T_{m}$",'fontSize',12)
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'G','FontSize',20,'EdgeColor','none')

subplot(3,4,8)
plot(burntchain(4,:))
ylabel("Variance, $\sigma^{2}$",'fontsize',12);
xlabel("Iterations",'fontSize',12)
xlim([0 iterations-burnin]);
ax=gca;
ax.XAxis.Exponent = 0;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'H','FontSize',20,'EdgeColor','none')

subplot(3,2,5)
scatter(temp,resp,'filled','MarkerFaceColor',[0.4000    0.7608    0.6471])
xlabel("Temperature,{\it T} ($^{\circ}$C)")
ylabel({"Extrinsic incubation rate,"; "$\delta(T)$ (day$^{-1}$)"})
xlim([0 50])
box on

ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'I','FontSize',20,'EdgeColor','none')

subplot(3,2,6)
plot(testx,testy2,'color',[0.9882    0.5529    0.3843])
hold on
patch([testx testx], [C025 C975],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
scatter(temp,resp,'filled','MarkerFaceColor',[0.4000    0.7608    0.6471])
xlabel("Temperature,{\it T} ($^{\circ}$C)")
ylabel({"Extrinsic incubation rate,"; "$\delta(T)$ (day$^{-1}$)"})
xlim([0 50])
legend("Median","$95\%$ CrI","Data",'Location','northwest');
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'J','FontSize',20,'EdgeColor','none')

set(gcf, 'Units', 'centimeters', 'Position', [0 0 35 30], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS4.pdf -pdf -r300 -Opengl 

