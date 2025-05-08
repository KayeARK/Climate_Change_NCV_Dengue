clear
clc

load("../../WithPopChange/WangMengLongPop2060.mat");
pop2060(pop2060<=0)=NaN;

%% 


addpath('../../R0WithoutPop/GlobalR0WithoutPopChangeAvgBigSmal')

P='../../R0WithoutPop/GlobalR0WithoutPopChangeAvgBigSmal';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'R0Sim')
      
        c=[c,S(i)];
        
    end    
end

%% 
avg_suitability_2060=zeros(18720,43200);
min_suitability_2060=12*ones(18720,43200);
max_suitability_2060=zeros(18720,43200);

for p=1:100

p
data=load(strcat('../../R0WithoutPop/GlobalR0WithoutPopChangeAvgBigSmal/',c(p).name)).R0MedianMat;

Mat=zeros(18720,43200);

for k=13:24

x=flipud(data(:,:,k)');
x(isnan(x))=0;

for i=1:43200

    worldpop_long=-180.0012+(i)*(359.9999/43200);
    CESM_long=ceil((worldpop_long+180)*(288/360));

    for j=1:18720

        worldpop_lat=83.9996-(j-1)*(156/18720);
        CESM_lat=round((90-worldpop_lat)*(192/180));

        
        grid_area=1000^2;
        recovery_rate=1/5;

        Mat(j,i)=Mat(j,i)+(x(CESM_lat,CESM_long)*sqrt(grid_area./(pop2060(j,i)*recovery_rate))>0);

    end

end

end

avg_suitability_2060=avg_suitability_2060+Mat;
min_suitability_2060=(min_suitability_2060+Mat-abs(min_suitability_2060-Mat))/2;
max_suitability_2060=(max_suitability_2060+Mat+abs(max_suitability_2060-Mat))/2;

end
%% 

avg_suitability_2060=avg_suitability_2060/p;

%% 

save("SuitabilityStatistics/suitability_2060.mat","avg_suitability_2060","min_suitability_2060","max_suitability_2060","-v7.3")

