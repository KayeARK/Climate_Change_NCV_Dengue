clear
clc

addpath('SuitabilityData202020602100')

P='SuitabilityData202020602100';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TransmissionClimateSim')
      
        c=[c,S(i)];
        
    end    
end


MAT1=zeros(288,192,19);

for p=1:19

x=load(strcat('SuitabilityData202020602100/',c(p).name)).Suitability;

x(isnan(x))=0;

x(x>0)=1;

x1=sum(x(:,:,1:12),3);


MAT1(:,:,p)=x1;

end

Avg2100=mean(MAT1,3);
Var2100=var(MAT1,0,3);



%% 

save('SuitabilityStatistics/AvgofSims.mat','Avg2100')
save('SuitabilityStatistics/VarianceMat.mat','Var2100')

%% 

WorstCase2100=max(MAT1,[],3);
BestCase2100=min(MAT1,[],3);


save('SuitabilityStatistics/BestCase.mat','BestCase2100')
save('SuitabilityStatistics/WorstCase.mat','WorstCase2100')

