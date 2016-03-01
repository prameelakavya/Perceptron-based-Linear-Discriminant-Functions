% begin
% init a, k = 0
% do 
% k = ( k + 1) mod n
% if y k is misclassified by a
% then a = a + yk
% until all patterns classified
% return a
% end

% ω 1 = [(1, 7); (6, 3); (7, 8); (8, 9); (4, 5); (7, 5)]
% ω 2 = [(3, 1); (4, 3); (2, 4); (7, 1); (1, 3); (4, 2)]

% classes
%(1; 6); (7; 2); (8; 9); (9; 9); (4; 8); (8; 5)
%(2; 1); (3; 3); (2; 4); (7; 1); (1; 3); (5; 2)
class1 =  [1 6; 7 2; 8 9; 9 9; 4 8; 8 5];
class2 =  [2 1; 3 3; 2 4; 7 1; 1 3; 5 2];

% a ---> weight vector

a = [];
% a(1) = 2.*rand(1)-1;
% a(2) = 2.*rand(1)-1;
% a(3) = 2.*rand(1)-1;
a(1) = range(1);
a(2) = range(1);
a(3) = range(1);
stored = a(3);
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
eta = 1;

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
   y = data(:,k);
   if value > b
       expected_classes(k) = 0;
   else
       expected_classes(k) = 1;
   end
   if expected_classes(k) ~= classes(k)
       if value > b
            a = a - (eta * ((b - value) * y)/ (y(1)^2+y(2)^2+y(3)^2))';
       else
            a = a + (eta * ((b - value) * y)/ (y(1)^2+y(2)^2+y(3)^2))';
       end
   end
   
   if a(1) < 0
        a = -1 * a;
   end
end
% answer
figure(5)
plot(12*class1(:,1),12*class1(:,2),'og');
hold on;
plot(12*class2(:,1),12*class2(:,2),'+r');
hold on;
x = -10 : 1 :10;
y = -(a(1)*x + 12*a(3))/a(2);
plot(x,y);
hold off





