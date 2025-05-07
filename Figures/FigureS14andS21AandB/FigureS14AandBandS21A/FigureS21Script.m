clear
clc

set(0,'DefaultFigureColor',[1 1 1])
set(0, 'defaultaxesfontsize', 15)
set(0, 'defaultlinelinewidth', 2)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'defaultAxesTickLabelInterpreter','latex');
set(0, 'defaultLegendInterpreter','latex')
set(0,'DefaultAxesColorOrder',brewermap(NaN,'Set2'))

R0g0_2020_all=load("../../../Data/Literature_niches/SSP3/Mordecai_Aegypti_dengue/PopulationAtRisk/pop_at_risk_2020_all_sims.mat").mat_pop_at_risk_R00;
R0g0_2100_all=load("../../../Data/Literature_niches/SSP2/Mordecai_Aegypti_dengue/PopulationAtRisk/pop_at_risk_2100_all_sims.mat").mat_pop_at_risk_R00;
R0g0_2100_all=R0g0_2100_all(:,end-11:end);
R0g0_2100_all=R0g0_2100_all(1:19,:);

t1=[1,2,3,4,5,6,7,8,9,10,11,12]-0.1;
t3=[1,2,3,4,5,6,7,8,9,10,11,12]+0.1;


figure(1)

errorbar(t1,prctile(R0g0_2020_all,50),prctile(R0g0_2020_all,50)-prctile(R0g0_2020_all,2.5),prctile(R0g0_2020_all,97.5)-prctile(R0g0_2020_all,50),'color',[ 0.4000    0.7608    0.6471])
hold on
scatter(t1,prctile(R0g0_2020_all,50),40,[ 0.4000    0.7608    0.6471],'filled')

errorbar(t3,prctile(R0g0_2100_all,50),prctile(R0g0_2100_all,50)-prctile(R0g0_2100_all,2.5),prctile(R0g0_2100_all,97.5)-prctile(R0g0_2100_all,50),'color',[ 0.5529    0.6275    0.7961])
scatter(t3,prctile(R0g0_2100_all,50),40,[0.5529    0.6275    0.7961],'filled')

xticks([1,2,3,4,5,6,7,8,9,10,11,12])
xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'})
legend("","2020","","2100","boxoff")
xlabel("Time (months)")
ylabel("Population at risk ($R_{0}>0$)")
xlim([0,13])
ylim([0,8e9])

exportgraphics(gcf,'FigureS21A.pdf')
