% classes

class1 =  [1 6; 7 2; 8 9; 9 9; 4 8; 8 5];
class2 =  [2 1; 3 3; 2 4; 7 1; 1 3; 5 2];

%class1 =  [1 7; 6 3; 7 8; 8 9; 4 5; 7 5];
%class2 =  [3 1; 4 3; 2 4; 7 1; 1 3; 4 2];

% a ---> weight vector

a = [];
a(1) = range(1);
a(2) = range(1);
a(3) = range(1);

% data points
data = [cat(2,class1',class2'); ones(1,12)];

n = size(data,2);
p = randperm(n);
data = data(:,p);

% classes
classes = [zeros(6,1); ones(6,1)];
classes = classes(p,:);
expected_classes = 2*ones(12,1);
k = 0;
n = size(data,2)+1;
b = 0;

while 1
    count_miss = 0;
    for i = 1 : size(classes, 1)
      if classes(i) ~= expected_classes(i)
         count_miss = count_miss + 1;
         break
      end
   end    
   if count_miss == 0
       break
   end
   if k == n-1
        k = 0;
   end
   k = mod( k+1, n);
   value = a * data(:,k);
   if value > b
       expected_classes(k) = 0;
   else
       expected_classes(k) = 1;
   end
   if expected_classes(k) ~= classes(k)
       if value > b
            a = a - data(:,k)';
       else
           a = a + data(:,k)';
       end
   end
   
   %if a(1) < 0
    %    a = -1 * a;
   %end
end

% answer
figure(5)
plot(class1(:,1),class1(:,2),'og');
hold on;
plot(class2(:,1),class2(:,2),'+r');
hold on;
x = 0 : 1 :10;
y = -(a(1)*x + a(3))/a(2);
plot(x,y);
hold off





