clear
clc

%load("../../WithoutPopChange/WorldPop2020.mat");
%pop2020(pop2020<=0)=NaN;

load("SuitabilityStatistics/AvgofSims.mat")
Avg2020=flipud(Avg2020');
Avg2020(isnan(Avg2020))=0;
Avg2060=flipud(Avg2060');
Avg2060(isnan(Avg2060))=0;
Avg2100=flipud(Avg2100');
Avg2100(isnan(Avg2100))=0;

load("SuitabilityStatistics/BestCase.mat")
BestCase2020=flipud(BestCase2020');
BestCase2020(isnan(BestCase2020))=0;
BestCase2060=flipud(BestCase2060');
BestCase2060(isnan(BestCase2060))=0;
BestCase2100=flipud(BestCase2100');
BestCase2100(isnan(BestCase2100))=0;

load("SuitabilityStatistics/WorstCase.mat")
WorstCase2020=flipud(WorstCase2020');
WorstCase2020(isnan(WorstCase2020))=0;
WorstCase2060=flipud(WorstCase2060');
WorstCase2060(isnan(WorstCase2060))=0;
WorstCase2100=flipud(WorstCase2100');
WorstCase2100(isnan(WorstCase2100))=0;

%% 

Mat2020=zeros(18720,43200);
Mat2060=zeros(18720,43200);
Mat2100=zeros(18720,43200);

for i=1:43200

    worldpop_long=-180.0012+(i)*(359.9999/43200);
    CESM_long=ceil((worldpop_long+180)*(288/360));

    for j=1:18720

        worldpop_lat=83.9996-(j-1)*(156/18720);
        CESM_lat=round((90-worldpop_lat)*(192/180));

        Mat2020(j,i)=Avg2020(CESM_lat,CESM_long);
        Mat2060(j,i)=Avg2060(CESM_lat,CESM_long);
        Mat2100(j,i)=Avg2100(CESM_lat,CESM_long);

    end

end

Avg2020=Mat2020;
Avg2060=Mat2060;
Avg2100=Mat2100;

save('SuitabilityStatisticsWithPop/AvgofSims.mat','Avg2020','Avg2060','Avg2100','-v7.3')


%% 

Mat2020=zeros(18720,43200);
Mat2060=zeros(18720,43200);
Mat2100=zeros(18720,43200);

for i=1:43200

    worldpop_long=-180.0012+(i)*(359.9999/43200);
    CESM_long=ceil((worldpop_long+180)*(288/360));

    for j=1:18720

        worldpop_lat=83.9996-(j-1)*(156/18720);
        CESM_lat=round((90-worldpop_lat)*(192/180));

        Mat2020(j,i)=BestCase2020(CESM_lat,CESM_long);
        Mat2060(j,i)=BestCase2060(CESM_lat,CESM_long);
        Mat2100(j,i)=BestCase2100(CESM_lat,CESM_long);

    end

end

BestCase2020=Mat2020;
BestCase2060=Mat2060;
BestCase2100=Mat2100;

save('SuitabilityStatisticsWithPop/BestCase.mat','BestCase2020','BestCase2060','BestCase2100','-v7.3')


%% 

Mat2020=zeros(18720,43200);
Mat2060=zeros(18720,43200);
Mat2100=zeros(18720,43200);

for i=1:43200

    worldpop_long=-180.0012+(i)*(359.9999/43200);
    CESM_long=ceil((worldpop_long+180)*(288/360));

    for j=1:18720

        worldpop_lat=83.9996-(j-1)*(156/18720);
        CESM_lat=round((90-worldpop_lat)*(192/180));

        Mat2020(j,i)=WorstCase2020(CESM_lat,CESM_long);
        Mat2060(j,i)=WorstCase2060(CESM_lat,CESM_long);
        Mat2100(j,i)=WorstCase2100(CESM_lat,CESM_long);

    end

end

WorstCase2020=Mat2020;
WorstCase2060=Mat2060;
WorstCase2100=Mat2100;

save('SuitabilityStatisticsWithPop/WorstCase.mat','WorstCase2020','WorstCase2060','WorstCase2100','-v7.3')
