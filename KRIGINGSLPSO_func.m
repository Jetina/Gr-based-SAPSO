% function [gbest,gbestval,evacount,estcount,Itergbest,itereva,internum,convergegbest,convergeeva]= KRIGINGSLPSO_func(Dimension,Max_Gen,VRmin,VRmax,varargin)
function [gbestval,everyEVA,everyGBEST,time_output]=  KRIGINGSLPSO_func(Dimension,Max_Gen,VRmin,VRmax,problem)
%[gbest,gbestval,fitcount]= PSO_func('f8',3500,200000,30,30,-5.12,5.12)
 initial_time=cputime;
rng(sum(100*clock),'twister');
everyEVA=[];
everyGBEST=[];
pastpos=[];%一列是一行数
pastposfit=[];
maxEVA=Max_Gen;%z最大迭代次数
%ps=Particle_Number;%种群个数
D=Dimension;

func_num=problem;
if D>30
    ID=3;%%%%%%%%%%ID是构建数据库的代数
else
    ID=2;
end

%   alpha=0.5;%%样本选取范围
%%%%初始slpso参数
%%%%初始slpso参数
 M = 100;
    m = M + D/10;
    c3 = D/M*0.01;
    PL = zeros(m,1);

    for i = 1 : m
        PL(i) = (1 - (i - 1)/m)^log(sqrt(ceil(D/M)));%学习概率
    end
 ps=m;  
 fitest=zeros(ps,1);%每一代的对应的个体被估计时为1，否则为0
fiteva=zeros(ps,1);%每一代的对应的个体被实际计算时为1，否则为0 
%%%%%%%%%
%%%%%%%%%拉丁超立方体初始化
if length(VRmin)==1
    VRmin=repmat(VRmin,1,D);
    VRmax=repmat(VRmax,1,D);
end
mv=0.5*(VRmax-VRmin);%初始化
VRmin=repmat(VRmin,ps,1);
VRmax=repmat(VRmax,ps,1);
% Vmin=repmat(-mv,ps,1);
% Vmax=-Vmin;
 v = zeros(m,D);
% p=VRmin+(VRmax-VRmin).*rand(ps,D);  %用rand函数生成随机数
p=VRmin+(VRmax-VRmin).*lhsdesign(ps,D); %%%用拉丁超立方生成随机数

  evacount=0;
i2=1;
    while(evacount < maxEVA)
     if i2<ID
         e(:,1)=benchmark_func(p,func_num);%计算出的适应值是一个行向量
         fiteva(:,1)=1;
        fitest(:,1)=0;
        posfit=e;
        pastpos=[pastpos;p];%一列是一行数
        pastposfit=[pastposfit;e];
        evacount=i2*ps;%实际计算次数
        gbestval=min(pastposfit);
        everyEVA=[everyEVA;evacount];
        everyGBEST=[everyGBEST;gbestval];
        fprintf('Best fitness: %e\n', gbestval); 
        else
          GPfitness;
        end
        
        i2=i2+1
        %population sorting
        [posfit, gbestmid] = sort(posfit, 'descend');
        p = p(gbestmid,:);
        v = v(gbestmid,:);

        center = ones(m,1)*mean(p);
        
        %random matrix
        %rand('seed', sum(100 * clock));
        randco1 = rand(m, D);
        %rand('seeD', sum(100 * clock));
        randco2 = rand(m, D);
        %rand('seed', sum(100 * clock));
        randco3 = rand(m, D);
        winidxmask = repmat([1:m]', [1 D]);
        winidx = winidxmask + ceil(rand(m, D).*(m - winidxmask));
        %winidx = m - floor(0.5*rand(m, D).*(m - winidxmask));
        pwin = p;
        for j = 1:D
                pwin(:,j) = p(winidx(:,j),j);
        end
        
        %learning
         lpmask = repmat(rand(m,1) < PL, [1 D]);
         lpmask(m,:) = 0;
         v1 =  1*(randco1.*v + randco2.*(pwin - p) + c3*randco3.*(center - p));
         p1 =  p + v1;   
         
         
         v = lpmask.*v1 + (~lpmask).*v;         
         p = lpmask.*p1 + (~lpmask).*p;
         
         %boundary
%         for i = 1:m
            p = max(p, VRmin);
            p = min(p, VRmax);
%         end
%          itereva(i2,1)=FES;  
 
%         gen = gen + 1;
    end
    
    
  
   

time_output = cputime - initial_time;
iternum=i2;
 fprintf('iternum: %d\n',iternum);

end
