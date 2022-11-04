function [pool] = startparallelpool(size)
pool=[];
isstart = 0;
if isempty(gcp('nocreate'))==1
    isstart = 1;
end
if isstart==1
    if nargin==0
        pool=parpool('local');
    else
        try
            pool=parpool('local',size);
        catch ce
            pool=parpool('local');
            size = pool.NumWorkers;
            display(ce.message);
            display(strcat('restart. wrong  size=',num2str(size)));
        end
    end
end