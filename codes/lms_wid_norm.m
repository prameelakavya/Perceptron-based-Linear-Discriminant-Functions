function [a]= lms_wid_norm(b,n)


class1 =  [1 6; 7 2; 8 9; 9 9; 4 8; 8 5];
class2 =  [2 1; 3 3; 2 4; 7 1; 1 3; 5 2];

%class1 =  [1 7; 6 3; 7 8; 8 9; 4 5; 7 5];
%class2 =  [3 1; 4 3; 2 4; 7 1; 1 3; 4 2];

% data points
s = cat(2, ones(1,6), -1*ones(1,6));
data = [s; cat(2,class1',-class2')];
r = size(data,2);
p = randperm(r);
data = data(:,p);
data = data';

[size_data, size_feature] = size(data);

% Initialize
%a = rand(1,size_feature);
%disp(a);
a = [1 1 1];
aprev=zeros(1,size_feature);
count1=1;
theta=.0001;
flag = 1;

%Algorithm
%loop until the criterion function is satisfied or 
%all sample is correctly classified

while (flag && pdist([a;aprev])>theta)
   
   flag = 0;
   
   %find the sum of all the misclassified samples
   %multiply each misclassified sample with a factor
   for k=1:size_data
      yk = data(k,:);
      if a*yk'<=b(k)
         value = yk*(b(k)-(a*yk'));
         aprev = a;
         a = a + n*value;
         flag = 1;
      end
   end
   
   %update eta
   if flag==1
     count1=count1+1;
     n=n*0.9;
     %disp (count1)
   end 
   
end

disp(count1);
% answer
figure(5)
plot(class1(:,1),class1(:,2),'og');
hold on;
plot(class2(:,1),class2(:,2),'+r');
hold on;
x = [1 2 3 4 5 6 7 8 9 10];
y = -(a(2)*x + a(1))/a(3);
plot(x,y);
hold off

end

