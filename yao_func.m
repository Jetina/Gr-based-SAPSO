function fit=yao_func(p,problem)

[popsize D] = size(p);


switch problem

    case 1

        fit=sum(p.^2,2);
        
    case 2
        
        fit=sum(abs(p), 2) + prod(abs(p), 2);
        
    case 3
        fit = zeros(popsize,1);
        for j = 1:D
            fit = fit + sum(p(:, 1:j), 2).^2;
        end
        
    case 4
        fit = zeros(popsize,1);
        for i = 1:popsize
            fit(i) = max(abs(p(i,1:D)));
        end;
        
    case 5
        
        fit=100*sum((p(:,2:D)-(p(:,1:D-1)).^2).^2,2)+sum((p(:,1:(D-1))-1).^2,2);
        
    case 6
        
        fit = sum( floor(p(:,1:D) + 0.5).^2, 2);
        
%     case 7
%         
%         fit = zeros(popsize,1);
%         for i = 1:popsize
%             for j = 1:D
%                 fit(i) = fit(i) + j*p(i,j)^4;
%             end
%             fit(i) = fit(i) + rand();
%         end
        
    case 8

        fit=418.9828872724338*D-sum(p.*sin((abs(p)).^0.5),2);
        
    case 9
        
        fit=sum(p(:, 1:D).^ 2 - 10 .* cos(2 .* pi .*p(:,1:D)) + 10, 2);

    case 10

        fit=20+exp(1)-20*exp(-0.2*(1/D*sum(p.^2,2)).^0.5)-exp(1/D*sum(cos(2*pi*p),2));

    case 11

        fit=sum(p.^2,2)/4000-prod(cos(p./(repmat(1:D,popsize,1)).^0.5),2)+1;

    case 12

        p_=1+1/4*(p+1);
        p_1=p_(:,1:D-1);
        p_2=p_(:,2:D);
        p_3=p;
        temp_1=find(p>10);
        temp_2=find(p<-10);
        temp_3=find(p>=-10&p<=10);
        p_3(temp_1)=100*(p(temp_1)-10).^4;
        p_3(temp_2)=100*(-p(temp_2)-10).^4;
        p_3(temp_3)=0;
        fit=pi/D*(10*(sin(pi*p_(:,1))).^2+sum((p_1-1).^2.*(1+10*(sin(pi*p_2)).^2),2)+(p_(:,D)-1).^2)+sum(p_3,2);

    case 13

        p_1=p(:,1:D-1);
        p_2=p(:,2:D);
        p_3=p;
        temp_1=find(p>5);
        temp_2=find(p<-5);
        temp_3=find(p>=-5&p<=5);
        p_3(temp_1)=100*(p(temp_1)-5).^4;
        p_3(temp_2)=100*(-p(temp_2)-5).^4;
        p_3(temp_3)=0;
        fit=0.1*((sin(pi*3*p(:,1))).^2+sum((p_1-1).^2.*(1+(sin(3*pi*p_2)).^2),2)+(p(:,D)-1).^2.*(1+(sin(2*pi*p(:,D))).^2))+sum(p_3,2);
      
    case 14%Ellipsoid problem 
        
          f1=0;
         for i=1:D 
           f1 = i.* p(:,i)^2;
           fit = fit + f1;
         end
 

end