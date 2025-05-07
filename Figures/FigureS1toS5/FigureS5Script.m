clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))




kappa=load('../../Data/MCMC/aParasAegypti.mat');
ph=load('../../Data/MCMC/binformativeParasAegypti.mat');
pv=load('../../Data/MCMC/cinformativeParasAegypti.mat');
delta=load('../../Data/MCMC/PDRinformativeParasAegypti.mat');

L=101;
kappamat=[];
phmat=[];
pvmat=[];
deltamat=[];



for T=linspace(0,50,L)
MParams=TempFit(T,kappa,ph,pv,delta);
kappamat=[kappamat, MParams.kappa];
phmat=[phmat, MParams.ph];
pvmat=[pvmat, MParams.pv];
deltamat=[deltamat, MParams.delta];
end

x=linspace(0,50,L);

subplot(2,2,1)
plot(x,median(kappamat,1),'color',[0.9882    0.5529    0.3843])
hold on
patch([x x], [prctile(kappamat,2.5,1) prctile(kappamat,97.5,1)],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
xlabel('Temperature, T ($^{\circ}$C)')
ylabel({'Bite rate';'$\kappa$ (day$^{-1}$)'})
legend('Median','$95\%$ CrI','box','off','location','northwest')
ylim([0 0.4])
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'A','FontSize',20,'EdgeColor','none')


subplot(2,2,2)
plot(x,median(deltamat,1),'color',[0.9882    0.5529    0.3843])
hold on
patch([x x], [prctile(deltamat,2.5,1) prctile(deltamat,97.5,1)],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
xlabel('Temperature, T ($^{\circ}$C)')
ylabel({'Extrinsic incubation rate';'$\delta$ (day$^{-1}$)'})
legend('Median','$95\%$ CrI','box','off','location','northwest')
ylim([0 0.2])
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'B','FontSize',20,'EdgeColor','none')



subplot(2,2,3)
plot(x,median(phmat,1),'color',[0.9882    0.5529    0.3843])
hold on
patch([x x], [prctile(phmat,2.5,1) prctile(phmat,97.5,1)],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
xlabel('Temperature, T ($^{\circ}$C)')
ylabel({'Host susceptibility';'$p_{h}$'})
legend('Median','$95\%$ CrI','box','off','location','northwest')
ylim([0 1])
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'C','FontSize',20,'EdgeColor','none')


subplot(2,2,4)
plot(x,median(pvmat,1),'color',[0.9882    0.5529    0.3843])
hold on
patch([x x], [prctile(pvmat,2.5,1) prctile(pvmat,97.5,1)],[0.9882    0.5529    0.3843],'LineStyle','none')
alpha(0.3)
xlabel('Temperature, T ($^{\circ}$C)')
ylabel({'Vector susceptibility';'$p_{v}$'})
legend('Median','$95\%$ CrI','box','off','location','northwest')
ylim([0 1])
ax=gca;
p=get(ax,'Position');
annotation('textbox', p+[-0.03,0.05,0,0], 'string', 'D','FontSize',20,'EdgeColor','none')


set(gcf, 'Units', 'centimeters', 'Position', [0 0 35 30], 'PaperUnits', 'centimeters', 'PaperSize', [15 20]);
export_fig FigureS5.pdf -pdf -r300 -Opengl 



function MParams=TempFit(T,aAeg,bAeg,cAeg,PDRAeg)

chain=aAeg.burntchain;
c=chain(1,:);
T0=chain(2,:);
Tm=chain(3,:);
kappa = max(0,real(c.*T.*(T-T0).*sqrt(Tm-T)))';

chain=bAeg.burntchain;
c=chain(1,:);
T0=chain(2,:);
Tm=chain(3,:);
ph = min(1,max(0,real(c.*T.*(T-T0).*sqrt(Tm-T))))';

chain=cAeg.burntchain;
pv = max(0,real(chain(1,:).*T.*(T-chain(2,:)).*sqrt(chain(3,:)-T)))';

chain=PDRAeg.burntchain;
delta = max(0,real(chain(1,:).*T.*(T-chain(2,:)).*sqrt(chain(3,:)-T)))';




MParams=struct('kappa',kappa,'ph',ph,'pv',pv,'delta',delta);

end
