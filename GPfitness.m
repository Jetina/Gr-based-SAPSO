%                fitest=zeros(ps,1);%ÿһ���Ķ�Ӧ�ĸ��屻����ʱΪ1������Ϊ0
               fiteva=zeros(ps,1);%ÿһ���Ķ�Ӧ�ĸ��屻ʵ�ʼ���ʱΪ1������Ϊ0 
        
  GPglobal;
        for mj=1:m
        k=ismember(p(mj,:),pastpos,'rows');
          if k==1
            pastid=find((ismember(p(mj,:),pastpos,'rows')));
            fiteva(mj,1)=1;%�˴�������ʵ�ʼ��������Ϊ�Ǹ�ֵ�����Բ�û�����Ӽ������
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
             pastpos=[pastpos;p(maxEIid,:)];%%%������ʷ����
             pastposfit=[pastposfit;posfit(maxEIid,1)];
             posmse(maxEIid)=minmse;  
              minevafitnow = min(pastposfit);
            everyEVA=[everyEVA;evacount];
            everyGBEST=[everyGBEST;minevafitnow ];
        end

      [posfit, gbestmid] = sort(posfit, 'descend');%%gbestmidΪ��Ӧֵ�ɴ�С����
      p=p(gbestmid,:);
      fiteva=fiteva(gbestmid,1);
%       fitest=fitest(gbestmid,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��һ����ȷ����õĸ����Ѿ���ʵ�ʼ���
% while fiteva(m,1)==0
% %    [posfit, gbestmid] = sort(posfit, 'descend');%%gbestmidΪ��Ӧֵ�ɴ�С����
% %    p=p(gbestmid,:);
% % %    posfit=posfit(gbestmid,1);%�������ź��ˣ���������
% %    fiteva=fiteva(gbestmid,1);
% %    fitest=fitest(gbestmid,1);
%    posfit(m,1)=benchmark_func(p(m,:),problem);
%    evacount=evacount+1;
%    pastpos=[pastpos;p(m,:)];%%%������ʷ����
%    pastposfit=[pastposfit;posfit(m,1)];
%    fiteva(m,1)=1;
%    posmse= posmse(gbestmid,:);%�� posmse���±������˳����pos��Ӧ 
%    posmse(m)=minmse; %��ʵ�ʼ�����ĸ����mse��Ϊ�뵱ǰ��С��mse���
% %    fitest(m,1)=0;
%    [posfit, gbestmid] = sort(posfit, 'descend');
%     fiteva=fiteva(gbestmid,1);
% end 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     besty = posfit(m);
    gbestval = min(pastposfit);
    fprintf('Best fitness: %e\n',gbestval);
%     pastpos=[pastpos;pos];%%%������ʷ����
%     pastposfit=[pastposfit;posfit];
%     FITEVAALL=[FITEVAALL;fiteva];
    Itergbest(i2,1)=gbestval;
    itereva(i2,1)=evacount;
%     POSMSE = posmse./sum(posmse(:));










