%                fitest=zeros(ps,1);%每一代的对应的个体被估计时为1，否则为0
               fiteva=zeros(ps,1);%每一代的对应的个体被实际计算时为1，否则为0 
        
  GPglobal;
        for mj=1:m
        k=ismember(p(mj,:),pastpos,'rows');
          if k==1
            pastid=find((ismember(p(mj,:),pastpos,'rows')));
            fiteva(mj,1)=1;%此处仅代表实际计算过，因为是赋值，所以并没有增加计算次数
            posfit(mj,1)=pastposfit(pastid(1),1);
            posmse(mj,1)=minmse;
          end
        end
  Gbest=repmat(gbestval,ps,1);
EI=(Gbest-posfit).*normcdf((Gbest-posfit)./posmse)+posmse.*normpdf((Gbest-posfit)./posmse);
%      [FrontNo,MaxFNo] = NDSort(PopObj,m);
%        MinFNo=min(FrontNo);
%        minmse=min(posmse);
%        [~, gbestsort] = sort(posfit, 'descend'); 
      
       [maxEI,maxEIid]=max(EI);
       if fiteva(maxEIid,1)==0
         posfit(maxEIid,1)=benchmark_func(p(maxEIid,:),problem);
             evacount=evacount+1;
             fiteva(maxEIid,1)=1;
             pastpos=[pastpos;p(maxEIid,:)];%%%更新历史数据
             pastposfit=[pastposfit;posfit(maxEIid,1)];
             posmse(maxEIid)=minmse;  
              minevafitnow = min(pastposfit);
            everyEVA=[everyEVA;evacount];
            everyGBEST=[everyGBEST;minevafitnow ];
        end

      [posfit, gbestmid] = sort(posfit, 'descend');%%gbestmid为适应值由大到小排序，
      p=p(gbestmid,:);
      fiteva=fiteva(gbestmid,1);
%       fitest=fitest(gbestmid,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%这一段是确保最好的个体已经被实际计算
% while fiteva(m,1)==0
% %    [posfit, gbestmid] = sort(posfit, 'descend');%%gbestmid为适应值由大到小排序，
% %    p=p(gbestmid,:);
% % %    posfit=posfit(gbestmid,1);%本来就排好了，不用再排
% %    fiteva=fiteva(gbestmid,1);
% %    fitest=fitest(gbestmid,1);
%    posfit(m,1)=benchmark_func(p(m,:),problem);
%    evacount=evacount+1;
%    pastpos=[pastpos;p(m,:)];%%%更新历史数据
%    pastposfit=[pastposfit;posfit(m,1)];
%    fiteva(m,1)=1;
%    posmse= posmse(gbestmid,:);%将 posmse的下标与调整顺序后的pos对应 
%    posmse(m)=minmse; %把实际计算过的个体的mse改为与当前最小的mse相等
% %    fitest(m,1)=0;
%    [posfit, gbestmid] = sort(posfit, 'descend');
%     fiteva=fiteva(gbestmid,1);
% end 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     besty = posfit(m);
    gbestval = min(pastposfit);
    fprintf('Best fitness: %e\n',gbestval);
%     pastpos=[pastpos;pos];%%%更新历史数据
%     pastposfit=[pastposfit;posfit];
%     FITEVAALL=[FITEVAALL;fiteva];
    Itergbest(i2,1)=gbestval;
    itereva(i2,1)=evacount;
%     POSMSE = posmse./sum(posmse(:));










