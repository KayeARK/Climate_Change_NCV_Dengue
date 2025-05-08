clear
clc

%First, load the MCMC data (chains for each temperature dependent variable)

aAeg=load('../MCMC/aParasAegypti.mat');
aAeg.burntchain=aAeg.burntchain(:,1:20:end);
bAeg=load('../MCMC/binformativeParasAegypti.mat');
bAeg.burntchain=bAeg.burntchain(:,1:20:end);
cAeg=load('../MCMC/cinformativeParasAegypti.mat');
cAeg.burntchain=cAeg.burntchain(:,1:20:end);
a=load('../MCMC/a_MCMC_results.mat');
a.burntchain=a.burntchain(:,1:20:end);
gamma=load('../MCMC/gamma_MCMC_results.mat');
gamma.burntchain=gamma.burntchain(:,1:20:end);
invg=load('../MCMC/invg_MCMC_results.mat');
invg.burntchain=invg.burntchain(:,1:20:end);
PDRAeg=load('../MCMC/PDRinformativeParasAegypti.mat');
PDRAeg.burntchain=PDRAeg.burntchain(:,1:20:end);
p=load('../MCMC/p_MCMC_results.mat');
p.burntchain=p.burntchain(:,1:20:end);


Temperatures=linspace(0,40,401);
Rainfalls=linspace(0,30,301);

MeanR0=zeros(length(Temperatures),length(Rainfalls));
BiggestR0=zeros(length(Temperatures),length(Rainfalls));
SmallestR0=zeros(length(Temperatures),length(Rainfalls));
MedianR0=zeros(length(Temperatures),length(Rainfalls));

MeanM=zeros(length(Temperatures),length(Rainfalls));
BiggestM=zeros(length(Temperatures),length(Rainfalls));
SmallestM=zeros(length(Temperatures),length(Rainfalls));
MedianM=zeros(length(Temperatures),length(Rainfalls));


for i=1:length(Temperatures)
    
    i
    
    for j=1:length(Rainfalls)

        T=Temperatures(i);
        R=Rainfalls(j);

        R0Mat=R0(T,R,aAeg,bAeg,cAeg,a,gamma,invg,PDRAeg,p);
        MMat=M(T,R,a,gamma,invg,p);

        x=[prctile(R0Mat,2.5),mean(R0Mat),prctile(R0Mat,97.5),prctile(R0Mat,50)];
        y=[prctile(MMat,2.5),mean(MMat),prctile(MMat,97.5),prctile(MMat,50)];


        MeanR0(i,j)=x(2);
        SmallestR0(i,j)=x(1);
        BiggestR0(i,j)=x(3);
        MedianR0(i,j)=x(4);
        
        MeanM(i,j)=y(2);
        SmallestM(i,j)=y(1);
        BiggestM(i,j)=y(3);
        MedianM(i,j)=y(4);

    end
    
end

save('Lookup R0','MeanR0','SmallestR0','BiggestR0','MedianR0','Temperatures','Rainfalls')
save('Lookup M','MeanM','SmallestM','BiggestM','MedianM','Temperatures','Rainfalls')
