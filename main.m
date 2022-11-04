function [besty] = main(d, maxfe, runnum)

%d: dimensionality
%maxfe: maximal number of fitness evaluations
%runnum: the number of trial runs

for funcid = 1 : 13
    n = d;
    switch funcid
         case 1

            % lu: define the upper and lower bounds of the variables
            lu = [-100 * ones(1, n); 100 * ones(1, n)];
            threshold = 1e-10;
        case 2

            lu = [-10 * ones(1, n); 10 * ones(1, n)];
            threshold = 1e-10;

        case 3

            lu = [-100 * ones(1, n); 100 * ones(1, n)];
            threshold = 1e-5;

        case 4

            lu = [-100 * ones(1, n); 100 * ones(1, n)];
            threshold = 1e-10;

        case 5

            lu = [-30* ones(1, n); 30 * ones(1, n)];
            threshold = 1e2;


        case 6

            lu = [-100 * ones(1, n); 100 * ones(1, n)];
             threshold = 1e-10;

%         case 7
% 
%             lu = [-1.28 * ones(1, n); 1.28 * ones(1, n)];
%             threshold = 0.1;


        case 8

            lu = [-500 * ones(1, n); 500 * ones(1, n)];
            threshold = 2e3;

        case 9

            lu = [-5.12 * ones(1, n); 5.12 * ones(1, n)];
            threshold = 1e2;

        case 10

            lu = [-32 * ones(1, n); 32 * ones(1, n)];
             threshold = 1e-10;

        case 11

            lu = [-600 * ones(1, n); 600 * ones(1, n)];
             threshold = 1e-10;

        case 12

            lu = [-50 * ones(1, n); 50 * ones(1, n)];
             threshold = 1e-10;

        case 13

            lu = [-50 * ones(1, n); 50 * ones(1, n)];
             threshold = 1e-10;

    end


data = zeros(runnum,1);
%several runs
for run = 1 : runnum
    succornot = 0;
    %parameter setting
    %parameter initiliaztion
    M = 100;
    m = M + d/10;
    c3 = d/M*0.01;
    PL = zeros(m,1);

    for i = 1 : m
        PL(i) = (1 - (i - 1)/m)^log(sqrt(ceil(d/M)));%学习概率
    end


    %initialization
    p = zeros(m, d); 
    XRRmin = repmat(lu(1, :), m, 1);
    XRRmax = repmat(lu(2, :), m, 1);
    rand('seed', sum(100 * clock));
    p = XRRmin + (XRRmax - XRRmin) .* rand(m, d);
    v = zeros(m,d);
    bestever = 1e200;
    
    FES = 0;
    gen = 0;
    ploti = 1;
    

    tic;
    %main loop
    while(FES < maxfe)
        %rand('state', sum(100 * clock));
        FES = FES + m;
        %[fitness bestp besty rank] = update(p, funcid);
        
        %fitness evaluation
        %%%%%%此处改变fitness的获取值方法
        
        fitness = yao_func(p, funcid);
        fprintf('Best fitness: %e\n', bestever); 

        %population sorting
        [fitness, rank] = sort(fitness, 'descend');
        p = p(rank,:);
        v = v(rank,:);
        besty = fitness(m);
        bestp = p(m, :);
        bestever = min(besty, bestever);
        
        %center position
        center = ones(m,1)*mean(p);
        
        %random matrix
        %rand('seed', sum(100 * clock));
        randco1 = rand(m, d);
        %rand('seed', sum(100 * clock));
        randco2 = rand(m, d);
        %rand('seed', sum(100 * clock));
        randco3 = rand(m, d);
        winidxmask = repmat([1:m]', [1 d]);
        winidx = winidxmask + ceil(rand(m, d).*(m - winidxmask));
        %winidx = m - floor(0.5*rand(m, d).*(m - winidxmask));
        pwin = p;
        for j = 1:d
                pwin(:,j) = p(winidx(:,j),j);
        end
        
        %learning
         lpmask = repmat(rand(m,1) < PL, [1 d]);
         lpmask(m,:) = 0;
         v1 =  1*(randco1.*v + randco2.*(pwin - p) + c3*randco3.*(center - p));
         p1 =  p + v1;   
         
         
         v = lpmask.*v1 + (~lpmask).*v;         
         p = lpmask.*p1 + (~lpmask).*p;
         
         %boundary
        for i = 1:m
            p(i,:) = max(p(i,:), lu(1,:));
            p(i,:) = min(p(i,:), lu(2,:));
        end
        

        gen = gen + 1;
    end;
    fprintf('Run No.%d Done!\n', run); 
    disp(['CPU time: ',num2str(toc)]);
    %xx(run, funcid) = bestever;
end;


end;

    

