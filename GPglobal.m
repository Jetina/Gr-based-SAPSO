SampleL=2;
 trainnum=SampleL*m;
% trainnum=4*m;%%%�����趨��������4*m
  [TrainL,TrainD]=size(pastpos); 
IP_train = pastpos;
OT_train = pastposfit;
INput=[ OT_train IP_train];

 if TrainL<=trainnum
     [INput,~,~] = unique(INput,'rows');
     PREIN=INput;
      [PRETrainL,PRETrainD]=size(PREIN); 
 else
      [INput,~,~] = unique(INput,'rows');
      PREIN=INput;
      [PRETrainL,PRETrainD]=size(PREIN); 
      if PRETrainL>trainnum
                   
       PREIN=INput(((PRETrainL-trainnum):PRETrainL),:);%%�Է����ظ��ģ�����������Ϊ����
      [PREIN,~,~] = unique(PREIN,'rows');
      [PRETrainL,PRETrainD]=size(PREIN);
      end
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P_train =PREIN(:,(2:D+1));
T_train =PREIN(:,1);
T_test = p;
%% GP����/ѵ��
% gprMdl = fitrgp(Pn_train,Tn_train,'KernelFunction','ardsquaredexponential', 'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
%     struct('AcquisitionFunctionName','expected-improvement-plus'));

 gprMdl = fitrgp(P_train,T_train,'KernelFunction','matern32','BasisFunction','pureQuadratic','Optimizer','fmincon');
%%%%%%%%%%%%%%%%�ⲿ������dace�Ĵ���
% lob=repmat(1e-3,1,D);
% upb=repmat(1e3,1,D);
% theta=std(pastpos);
% [dmodel,perf]=dacefit(P_train,T_train,@regpoly0,@corrgauss,theta,lob,upb);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GP�������

[t_sim,mse]=predict(gprMdl,T_test);
% [t_sim,mse]=predictor(T_test,dmodel);
% % ����һ��
% T_sim = mapminmax('reverse',tn_sim,outputps);
% else
%     T_test = p;
% %     Tn_test = mapminmax(T_test);
% %     [t_sim,mse]=predict(gprMdl,T_test);
%     [t_sim,mse]==predictor(T_test,dmodel);
% %     T_sim = mapminmax('reverse',t_sim,outputps);
% end
posfit=t_sim;
posmse=mse;
PopObj=[t_sim mse];
% estcount=estcount+ps;%���ƴ���
% fiteva=zeros(ps,1);
% fitest=ones(ps,1);
minmse=min(posmse);