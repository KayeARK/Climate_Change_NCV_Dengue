clc
clear

lowerT=16.0;
upperT=36.5;

addpath('../../../ClimateData/TempPrectData2100SSP2')

P='../../../ClimateData/TempPrectData2100SSP2';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TempPrect')
      
        c=[c,S(i)];
        
    end    
end

%% 

for p=1:19
    
p

TempPrect=load(strcat('../../../ClimateData/TempPrectData2100SSP2/',c(p).name));

Temp=TempPrect.T;
Temperature=circshift(Temp,144,1);
Temperature(Temperature<0)=0;

Suitability=zeros(288,192,12);

for l=1:12
    
for j=1:192

for i=1:288

T=Temperature(i,j,l);

S=double((T>=lowerT & T<=upperT));
          
Suitability(i,j,l)=S;
end

end

end

save(strcat('SuitabilityData202020602100/TransmissionClimateSim',num2str(p)),'Suitability')

end
