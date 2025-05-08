%%2020

clear
clc

load("../../WithoutPopChange/WorldPop2020.mat");
pop2020(pop2020<=0)=NaN;

addpath('SuitabilityData202020602100')

P='SuitabilityData202020602100';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TransmissionClimateSim')
      
        c=[c,S(i)];
        
    end    
end


mat_pop_at_risk_R00=zeros(100,12);

for p=1:100

p
data=load(strcat('SuitabilityData202020602100/',c(p).name)).Suitability;

for k=1:12

x=flipud(data(:,:,k)');
x(isnan(x))=0;

pop_at_risk_R00=0;

for i=1:43200

    worldpop_long=-180.0012+(i)*(359.9999/43200);
    CESM_long=ceil((worldpop_long+180)*(288/360));

    for j=1:18720

        worldpop_lat=83.9996-(j-1)*(156/18720);
        CESM_lat=round((90-worldpop_lat)*(192/180));

        pop=pop2020(j,i);
        if isnan(pop) || pop<20
            pop=0; 
        end

        R0=x(CESM_lat,CESM_long);

        pop_at_risk_R00=pop_at_risk_R00+(pop*(R0));

    end

end

mat_pop_at_risk_R00(p,k)=pop_at_risk_R00;

end

end

save("PopulationAtRisk/pop_at_risk_2020_all_sims.mat","mat_pop_at_risk_R00","-v7.3")

%% 2060

clear
clc

load("../../WithPopChange/WangMengLongPop2060.mat");
pop2060(pop2060<=0)=NaN;

addpath('SuitabilityData202020602100')

P='SuitabilityData202020602100';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TransmissionClimateSim')
      
        c=[c,S(i)];
        
    end    
end

mat_pop_at_risk_R00=zeros(100,12);

for p=1:100

p
data=load(strcat('SuitabilityData202020602100/',c(p).name)).Suitability;

for k=13:24

x=flipud(data(:,:,k)');
x(isnan(x))=0;

pop_at_risk_R00=0;

for i=1:43200

    worldpop_long=-180.0012+(i)*(359.9999/43200);
    CESM_long=ceil((worldpop_long+180)*(288/360));

    for j=1:18720

        worldpop_lat=83.9996-(j-1)*(156/18720);
        CESM_lat=round((90-worldpop_lat)*(192/180));

        pop=pop2060(j,i);
        if isnan(pop) || pop<20
            pop=0; 
        end

        R0=x(CESM_lat,CESM_long);

        pop_at_risk_R00=pop_at_risk_R00+(pop*(R0));

    end

end

mat_pop_at_risk_R00(p,k)=pop_at_risk_R00;

end

end

save("PopulationAtRisk/pop_at_risk_2060_all_sims.mat","mat_pop_at_risk_R00","-v7.3")


%% 2100

clear
clc

load("../../WithPopChange/WangMengLongPop2100.mat");
pop2100(pop2100<=0)=NaN;

addpath('SuitabilityData202020602100')

P='SuitabilityData202020602100';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TransmissionClimateSim')
      
        c=[c,S(i)];
        
    end    
end

mat_pop_at_risk_R00=zeros(100,12);

for p=1:100

p
data=load(strcat('SuitabilityData202020602100/',c(p).name)).Suitability;

for k=25:36

x=flipud(data(:,:,k)');
x(isnan(x))=0;

pop_at_risk_R00=0;

for i=1:43200

    worldpop_long=-180.0012+(i)*(359.9999/43200);
    CESM_long=ceil((worldpop_long+180)*(288/360));

    for j=1:18720

        worldpop_lat=83.9996-(j-1)*(156/18720);
        CESM_lat=round((90-worldpop_lat)*(192/180));

        pop=pop2100(j,i);
        if isnan(pop) || pop<20
            pop=0; 
        end

        R0=x(CESM_lat,CESM_long);

        pop_at_risk_R00=pop_at_risk_R00+(pop*(R0));

    end

end

mat_pop_at_risk_R00(p,k)=pop_at_risk_R00;

end

end

save("PopulationAtRisk/pop_at_risk_2100_all_sims.mat","mat_pop_at_risk_R00","-v7.3")


