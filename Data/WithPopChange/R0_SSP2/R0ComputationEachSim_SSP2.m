clc
clear

R0Lookup=load('Lookup R0.mat');
%Area=load('GridCellAreas.mat').DMat;
%GlobalPop=load('HumanPopulation2006to2100.mat').HumanPop;
%GlobalPop=pagetranspose(flipud(GlobalPop));

MeanR0=R0Lookup.MeanR0;
MedianR0=R0Lookup.MedianR0;
BiggestR0=R0Lookup.BiggestR0;
SmallestR0=R0Lookup.SmallestR0;

%% 


P='Data/ClimateData/TempPrectData2100SSP2';
S=dir(fullfile(P,'*'));

c=[];

for i=1:length(S)
   
    if strfind(S(i).name,'TempPrect')
      
        c=[c,S(i)];
        
    end    
end


for p=1:19
p

TempPrect=load(strcat('Data/ClimateData/TempPrectData2100SSP2/',c(p).name));

Prect=TempPrect.R;
Temp=TempPrect.T;


Temperature=circshift(Temp,144,1);
Rainfall=circshift(Prect,144,1);
Temperature(Temperature<0)=0;



R0MedianMat=zeros(288,192,12);
R0SmallestMat=zeros(288,192,12);
R0BiggestMat=zeros(288,192,12);

for l=1:12
    
for j=1:192

for i=1:288


T=Temperature(i,j,l);
R=Rainfall(i,j,l);
%R=3;


%Fixed Rainfall
% T=Temperature(i,j,l);
% R1=squeeze(Rainfall(i,j,13:24));
% R=R1(mod(l-1,12)+1);

%Fixed Temperature
%R=Rainfall(i,j,l);
%T1=squeeze(Temperature(i,j,13:24));
%T=T1(mod(l-1,12)+1);

% if l<13
% G=GlobalPop(:,:,1);
% elseif l>12 && l<25G=GlobalPop(:,:,15);
% elseif l>24
% G=GlobalPop(:,:,95);
% end

%N=G(i,j);

% D=1e6*Area(j,i);
% k=carrcap(R,N,D);
% r=1/5;
% 
% if N==0
%     prefactor=0;
% else
% prefactor=sqrt((k*D)/(N*r));
% end

R0Median=MedianR0(min(401,int64(10*T)+1),min(301,int64(10*R)+1));
R0Biggest=BiggestR0(min(401,int64(10*T)+1),min(301,int64(10*R)+1));
R0Smallest=SmallestR0(min(401,int64(10*T)+1),min(301,int64(10*R)+1));
           
R0MedianMat(i,j,l)=R0Median;
R0SmallestMat(i,j,l)=R0Smallest;
R0BiggestMat(i,j,l)=R0Biggest;

end

end

end

%save(strcat('/home/alexkaye/Desktop/Thesis Chapter 1/Final Code/Results/GlobalR0WithoutN/R0Sim',num2str(p)),'R0MedianMat')
save(strcat('Data/R0WithoutPop/GlobalR0WithoutPopChangeAvgBigSmal_SSP2/R0Sim',num2str(p)),'R0MedianMat','R0SmallestMat','R0BiggestMat')


end








% 
% function k=carrcap(R,N,D)
% 
%     %density needs to be in km^2 for this equation so convert
%     D=D*1e-6;
%     rho=N/D; %human population density
% 
%     %TI=min(0.1505.*(rho^0.69),78);
%     %I=245*(1-(TI/100));
%     if rho==0
%         I=100000;
%     else
%          I=(1000000)/rho;
%     end
% 
%     %k=(300/4.59)*R*(1/25)/(5+I+R);
%     k=(300/4.59)*R*(1/25)/I;
% 
% end
% 
% 
% function grid=CESMGrid(lat,long)
% 
% lat=lat+90;
% long=long+180;
% 
% xcoord=ceil((192/180)*lat);
% ycoord=ceil((288/360)*long);
% 
% grid=[xcoord,ycoord];
% 
% end
