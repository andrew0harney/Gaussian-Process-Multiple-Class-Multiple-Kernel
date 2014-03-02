%Andrew O'Harney
%19/04/2013
%Filters out data to get a balance of classes

function [xs,ys] = get_class_quota(x,y,amounts)
global num_latents

counts = zeros([1 num_latents]);
xs =[];
ys = [];

for i=1:length(x)
   
    class = find(y(i,:),1);
    
    if(counts(class)<amounts(class))
        xs = [xs,x(i)];
        ys = [ys;y(i,:)];
        counts(class) = counts(class)+1;
    end
    
end
