function [count, final_weights] = all_comb(b,n)

count = [];
final_weights = [];

class1 =  [1 7; 6 3; 7 8; 8 9; 4 5; 7 5];
class2 =  [3 1; 4 3; 2 4; 7 1; 1 3; 4 2];

% data points
s = cat(2, ones(1,6), -1*ones(1,6));
data = [s; cat(2,class1',-class2')];
r = size(data,2);
p = randperm(r);
data = data(:,p);
data = data';

[size_data, size_feature] = size(data);

% Initialize
a = rand(1,size_feature);
initial = a;
disp(initial);

% single sample perceptron-----------------------------------------------------------------------------------------------------------------

flag = 1;
count1=1;

while (flag)
   flag = 0;
   
   %find a misclassified sample and update a, n
   for k=1:size_data 
      yk = data(k,:);      
      if a*yk'<=b
         a = a + n*yk;
         flag=1;
         %disp(count1);
         count1=count1+1; 
         break;
      end
   end
   
end
count = [count; count1];
final_weights = [final_weights; a];

% answer
figure(5)
plot(class1(:,1),class1(:,2),'or');
hold on;
plot(class2(:,1),class2(:,2),'+b');
hold on;
x = [1 2 3 4 5 6 7 8 9 10];
y = -(a(2)*x + a(1))/a(3);
plot(x,y,'g--*');
hold on;

% single sample perceptron with margin ----------------------------------------------------------------------------------------------------

flag = 1;
count1=1;
b = 0.075;

while (flag)
   flag = 0;
   
   %find a misclassified sample and update a, n
   for k=1:size_data 
      yk = data(k,:);      
      if a*yk'<=b
         a = a + n*yk;
         flag=1;
         %disp(count1);
         count1=count1+1; 
         break;
      end
   end
   
end
count = [count; count1];
final_weights = [final_weights; a];

% answer
y = -(a(2)*x + a(1))/a(3);
plot(x,y,'k');
hold on;


% relaxation procedure---------------------------------------------------------------------------------------------------------------------

a = initial;
aprev=zeros(1,size_feature);
flag=1;
count1 = 1;
theta=.0001;

while (flag && pdist([a;aprev])>theta)
   flag = 0;
   
   %find the sum of all the misclassified samples
   %multiply each misclassified sample with a factor
   for k=1:size_data
      yk = data(k,:);
      if a*yk'<=b
         value = yk*(b-(a*yk'))/power(pdist([zeros(1,size_feature);yk]),2);
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
count = [count; count1];
final_weights = [final_weights; a];

% answer
y = -(a(2)*x + a(1))/a(3);
plot(x,y,'c');
hold on;

% widrow haff------------------------------------------------------------------------------------------------------------------------------

a = initial;
aprev=zeros(1,size_feature);
count1=1;
theta=.0001;
flag = 1;
margin = b * ones(1,12);

while (flag && pdist([a;aprev])>theta)
   
   flag = 0;
   
   %find the sum of all the misclassified samples
   %multiply each misclassified sample with a factor
   for k=1:size_data
      yk = data(k,:);
      if a*yk'<=margin(k)
         value = yk*(margin(k)-(a*yk'));
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
count = [count; count1];
final_weights = [final_weights; a];

% answer
y = -(a(2)*x + a(1))/a(3);
plot(x,y,'m');
legend('class1','class2','ssp','sspm','relax','widrow','Location','northwest');
xlabel('X');
ylabel('Y');
title('classifier');
hold off
