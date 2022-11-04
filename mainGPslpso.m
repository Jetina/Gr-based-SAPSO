% 10.Shifted Rotated Rastrign's Function 
%19.Rotated Hybrid Composition Function 2 with a Narrow Basin for the Global Optimum


clc
 clear all
  x='用EI规则来选个体';
 fp=fopen('celue.txt','a');%'a'表示打开文件a.txt,如果不存在就新建一个
fprintf(fp,'%d',x);
fclose(fp);
clc
 clear all
 addpath(genpath(pwd));
 x='该方法，当mse不能分层时计算第一个面上的值，当mse能分层时，计算两个面上的值';
 fp=fopen('celue.txt','a');%'a'表示打开文件a.txt,如果不存在就新建一个
fprintf(fp,'%d',x);
fclose(fp);
path =[cd,'\alldata10D2M']; %创建数据文件夹
if ~isdir(path) 
    mkdir(path);
end
for i=10:12
 pool = startparallelpool(4);
 tic

%  mex cec13_func.cpp -DWINDOWS
% for problem = 1 : 13


% D=100;%%%%%%%%%%确定维数
PNUM=[30 6
     50  6
     100 6
     30  7
     50   7
     100  7
     30 8
     50  8
     100  8
     30  10
     50  10
     100  10
     200 10
     30  19
     50   19
     100  19
     200 19
     ];

D=PNUM(i,1)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%此处对照SLPSO的论文中函数序号确定函数
 problem=PNUM(i,2)
 func_num=problem;
 switch i
      case 1
         Filename='\alldata10D2M\GPSLPSOdataF6_30_EI';
      case 2
          Filename='\alldata10D2M\GPSLPSOdataF6_50_EI';
       case 3
         Filename='\alldata10D2M\GPSLPSOdataF6_100_EI';
         case 4
          Filename='\alldata10D2M\GPSLPSOdataF7_30_EI';
           case 5
             Filename='\alldata10D2M\GPSLPSOdataF7_50_EI';
             case 6
                 Filename='\alldata10D2M\GPSLPSOdataF7_100_EI';
     
     case 7
          Filename='\alldata10D2M\GPSLPSOdataF8_30_EI';
           case 8
             Filename='\alldata10D2M\GPSLPSOdataF8_50_EI';
             case 9
                 Filename='\alldata10D2M\GPSLPSOdataF8_100_EI';
     
     case 10
         Filename='\alldata10D2M\GPSLPSOdataF10_30_EI';
      case 11
          Filename='\alldata10D2M\GPSLPSOdataF10_50_EI';
       case 12
         Filename='\alldata10D2M\GPSLPSOdataF10_100_EI';
         
        case 13
                 Filename='\alldata10D2M\GPSLPSOdataF10_200_EI';
         case 14
          Filename='\alldata10D2M\GPSLPSOdataF19_30_EI';
           case 15
             Filename='\alldata10D2M\GPSLPSOdataF19_50_EI';
             case 16
                 Filename='\alldata10D2M\GPSLPSOdataF19_100_EI';

                   case 17
                 Filename='\alldata10D2M\GPSLPSOdataF19_200_EI';
                 
                 
                 
                 
 end

%shifted Rosenbrock6 
%shifted rotated Griewank7 
%shifted rotated Ackley8 
%shifted rotated Rastrigin14 GPSLPSO中的F5
% GPSLPSO中的F6
lu =SLpsogetbound(D,problem);
xmin=lu(1,:);
xmax=lu(2,:);
pop_size=110;
% iter_max=100;
maxEVA=10*D;
runs=30;
col_str ='ABCDEFGHIJKLMNOPQRSTUVWXYZAAABACADAE';
% for i=1:1
fbest= zeros(1,runs);
time=zeros(1,runs);
   parfor j=1:runs
        j,
       [gbest1,everyEVA1,everyGBEST1,time_output]= KRIGINGSLPSO_func(D,maxEVA,xmin,xmax,problem);
        gbest{:,j}=gbest1;
        everyEVA{:,j}=everyEVA1;
        everyGBEST{:,j}=everyGBEST1;
        everytime{:,j}=time_output;
   end 
    for j=1:runs
        if j>26
            jj=27+2*(j-27);
        xlswrite(Filename,everyEVA{:,j},1,[col_str(jj:jj+1),num2str(1)]);
        xlswrite(Filename,everyGBEST{:,j},2,[col_str(jj:jj+1),num2str(1)]);
        fbest(:,j)= gbest{:,j};
        time(:,j)=everytime{:,j}; 
        else
        xlswrite(Filename,everyEVA{:,j},1,[col_str(j),num2str(1)]);
        xlswrite(Filename,everyGBEST{:,j},2,[col_str(j),num2str(1)]);
        fbest(:,j)= gbest{:,j};
        time(:,j)=everytime{:,j};
        end
    end 
        best_fit=min(fbest);
        worst_fit=max(fbest);
        f_mean=mean(fbest);
        f_median=median(fbest);
        std_fit=std(fbest);
         meantime=mean(time);
       out=[best_fit',worst_fit',f_mean',f_median',std_fit'];

       xlswrite(Filename,out,3);

      xlswrite(Filename,meantime,4);
      xlswrite(Filename,time,5);
      closeparallelpool;
end