
function lu =SLpsogetbound(D,funcid)


% for funcid = 1 : 13
    n = D;
    switch funcid
        case 10

            lu = [-5* ones(1, n); 5 * ones(1, n)];
            threshold = 1e2;
        case 19

            lu = [-5* ones(1, n); 5 * ones(1, n)];
            threshold = 1e2;
       case 14

            lu = [-5.12* ones(1, n); 5.12 * ones(1, n)];
            threshold = 1e2;
%          case 1
% 
%             % lu: define the upper and lower bounds of the variables
%             lu = [-100 * ones(1, n); 100 * ones(1, n)];
%             threshold = 1e-10;
%         case 2
% 
%             lu = [-10 * ones(1, n); 10 * ones(1, n)];
%             threshold = 1e-10;
% 
%         case 3
% 
%             lu = [-100 * ones(1, n); 100 * ones(1, n)];
%             threshold = 1e-5;
% 
%         case 4
% 
%             lu = [-100 * ones(1, n); 100 * ones(1, n)];
%             threshold = 1e-10;
% 
%         case 5
% 
% %             lu = [-30* ones(1, n); 30 * ones(1, n)];
%              lu = [-2.048* ones(1, n); 2.048 * ones(1, n)]; 
%             threshold = 1e2;
% 
% 
%         case 6
% 
%             lu = [-100 * ones(1, n); 100 * ones(1, n)];
%              threshold = 1e-10;
% 
% %         case 7
% % 
% %             lu = [-1.28 * ones(1, n); 1.28 * ones(1, n)];
% %             threshold = 0.1;
% 
% 
%         case 8
% 
%             lu = [-500 * ones(1, n); 500 * ones(1, n)];
%             threshold = 2e3;
% 
%         case 9
% 
%             lu = [-5* ones(1, n); 5 * ones(1, n)];
%             threshold = 1e2;
% 
%         case 10
% 
%             lu = [-32 * ones(1, n); 32 * ones(1, n)];
%              threshold = 1e-10;
% 
%         case 11
% 
%             lu = [-600 * ones(1, n); 600 * ones(1, n)];
%              threshold = 1e-10;
% 
%         case 12
% 
%             lu = [-50 * ones(1, n); 50 * ones(1, n)];
%              threshold = 1e-10;
% 
%         case 13
% 
%             lu = [-50 * ones(1, n); 50 * ones(1, n)];
%              threshold = 1e-10;

    end