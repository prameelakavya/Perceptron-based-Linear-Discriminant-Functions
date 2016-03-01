% begin
% init a, η(*), b, k = 0
% do k=(k+1) mod n
% Yk = {}
% j = 0
% do j = j+1
% if at yj <= b then append yj to Yk
% until j = n
% a = a + η(k) ΣyЄY ((b-aty).y) / |y|2
% until Yk = {}
% return a
% end

% classes

class1 =  [1 6; 7 2; 8 9; 9 9; 4 8; 8 5];
class2 =  [2 1; 3 3; 2 4; 7 1; 1 3; 5 2];

%class1 =  [1 7; 6 3; 7 8; 8 9; 4 5; 7 5];
%class2 =  [3 1; 4 3; 2 4; 7 1; 1 3; 4 2];

% a ---> weight vector

a = [];
% a(1) = 2.*rand(1)-1;
% a(2) = 2.*rand(1)-1;
% a(3) = 2.*rand(1)-1;
a(1) = 4;
a(2) = 3;
a(3) = 20;
stored = a(3);

% data points
s = cat(2, ones(1,6), -1*ones(1,6));
data = [s; cat(2,class1',-class2')];
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
m = 0;

while 1
      miss_class = [];
%     if k == n-1
%         k = 0;
%     end
%     k = mod( k+1 , n);
%     for j = 1 : 12
%         if a * data(:,j) > b
%             expected_classes(j) = 0;
%         else
%             expected_classes(j) = 1;
%         end
%     end
%     for j = 1 : 12
%         if expected_classes(j) ~= classes(j)
%             miss_class = cat(2, miss_class, data(:,j));
%         end
%     end
    
    for j = 1 : 12
        if a * data(:,j) <= b
            miss_class = cat(2, miss_class, data(:,j));
        end
    end
    if isempty(miss_class)
        break
    end
    value = a;
    for i = 1 : size(miss_class, 2)
        y = miss_class(:,i);
%         if a*y - b > 0
%             value = value + (eta * ((b - a*y) * y)/ (y(1)^2+y(2)^2))';
%         else
%             value = value - (eta * ((b - a*y) * y)/ (y(1)^2+y(2)^2))';
%         end
       value = value + (eta * ((b - a*y) * y)/ (y(1)^2+y(2)^2+y(3)^2))';
    end
    a = value;
    if a(1) < 0
        a = -1 * a;
    end
    m = m + 1;
end
% answer
figure(5)
plot(class1(:,1),class1(:,2),'og');
hold on;
plot(class2(:,1),class2(:,2),'+r');
hold on;
x = [1 2 3 4 5 6 7 8 9 10];
y = -(a(1)*x + a(3))/a(2);
plot(x,y);
hold off
