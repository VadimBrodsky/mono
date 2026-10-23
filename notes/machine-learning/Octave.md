# Octave
Like Matlab but free

Basic arithmetic operations

```matlab
5+5  % ans =  10
3-2  % ans =  1
4*3  % ans =  12
1/3  % ans =  0.33333
2^4  % ans =  16
```

Logical operations

```matlab
1 == 2   % false ans = 0
1 ~= 2   % true  ans = 1
1 && 0   % and   ans = 0
1 || 0   % or    ans = 1
xor(1,0)
```

Change the prompt

```matlab
PS1('>> ' ); % changes prompt
a = 3;       % semicolon supresses output
```

Variables

```matlab
a = 3        %  a =  3
b = 'hello';
c = (3>=1);  %  c = 1
who          % shows the variables in the current scope
whos         % like who but with more details, sizes, bytes
clear a      % clears the a variable
clear        % without an argument clears all variables
```

Printing output

```matlab
a = pi  % a =  3.1416
a       % a =  3.1416
disp(a) % 3.1416
disp(sprintf('2 decimals: %0.2f', a)) % 2 decimals: 3.14
disp(sprintf('2 decimals: %0.6f', a)) % 2 decimals: 3.141593
format long
a   %  a =  3.14159265358979
format short
a   %  a =  3.1416
```

Matrices and vectors

```matlab
A = [1 2; 3 4; 5 6]
% A =
%    1   2
%    3   4
%    5   6

A = [1 2;
> 3 4;
> 5 6]
% A =
%    1   2
%    3   4
%    5   6

V = [1 2 3]
% V =
%   1   2   3

V = [1; 2; 3]
% V =
%   1
%   2
%   3

V = 1:0.1:2
% V =
% Columns 1 through 9:
%
%    1.0000    1.1000    1.2000    1.3000    1.4000    1.5000    1.6000    1.7000    1.8000
% Columns 10 and 11:
%
%    1.9000    2.0000

V = 1:6
% V =
%   1   2   3   4   5   6

ones(2,3)
% ans =
%   1   1   1
%   1   1   1

c = 2*ones(2,3)
% c =
%   2   2   2
%   2   2   2

w = ones(1,3)
% w =
%   1   1   1

w = zeros(1,3)
% w =
%   0   0   0

I = eye(4)
% I =
% Diagonal Matrix
%
%   1   0   0   0
%   0   1   0   0
%   0   0   1   0
%   0   0   0   1

A = [1 2; 3 4; 5 6]
% A =
%   1   2
%   3   4
%   5   6

size(A)
% ans =
%   3   2

size(A,1)  % ans =  3
size(A,2)  % ans =  2

v = [1 2 3 4]
% v =
%   1   2   3   4

length(v)    % ans =  4
length(A)    % size of the longest dimension %  ans =  3
length([1;2;3;4;5])    %  ans = 5

s = v(1:2) % fist 2 elements of the vector
% s =
%   1
%   2

A = [1 2; 3 4; 5 6]
% A =
%   1   2
%   3   4
%   5   6

A(3,2)  %  ans =  6

A(2,:)  % ":" means every element along that row / column
% ans =
%   3   4

A(:,2)
% ans =
%   2
%   4
%   6

A([1 3], :)
% ans =
%   1   2
%   5   6

A(:,2) = [10; 11; 12]    % replaces the first column
% A =
%    1   10
%    3   11
%    5   12

A = [A, [100; 101; 102]]  % append another column vector to right
% A =
%     1    10   100
%     3    11   101
%     5    12   102

A(:)  % put all elements of A into a single vector
% ans =
%     1
%     3
%     5
%    10
%    11
%    12
%   100
%   101
%   102
```

```matlab
A = [1 2; 3 4; 5 6]
% A =
%   1   2
%   3   4
%   5   6

B = [11 12; 13 14; 15 16]
% B =
%   11   12
%   13   14
%   15   16

C = [A B]
% C =
%    1    2   11   12
%    3    4   13   14
%    5    6   15   16

C = [A; B]
% C =
%    1    2
%    3    4
%    5    6
%   11   12
%   13   14
%   15   16

C = [A; B]
% C =
%    1    2
%    3    4
%    5    6
%   11   12
%   13   14
%   15   16

size(C)
% ans =
%   6   2

[A B]   % same as [A, B]
% ans =
%    1    2   11   12
%    3    4   13   14
%    5    6   15   16
```

Matrix arithmetic

```matlab
A = [1 2; 3 4; 5 6]
% A =
%   1   2
%   3   4
%   5   6

B = [11 12; 13 14; 15 16]
% B =
%   11   12
%   13   14
%   15   16

C = [1 1; 2 2]
% C =
%   1   1
%   2   2

A*C     % matrix multiplication
% ans =
%    5    5
%   11   11
%   17   17

A .* B  % element wise multiplication, A .^ B for squaring
% ans =
%   11   24
%   39   56
%   75   96

% v = [1; 2; 3;]
% v =
%   1
%   2
%   3

1 ./ v  % element wise reciprocal of a vector
% ans =
%   1.00000
%   0.50000
%   0.33333

log(v)  % log of each element
% ans =
%   0.00000
%   0.69315
%   1.09861

exp(v)  % exponential of each element
% ans =
%    2.7183
%    7.3891
%   20.0855

abs(v)  % absolute value of each element
% ans =
%   1
%   2
%   3

-v      % negation of each element
% ans =
%  -1
%  -2
%  -3

v + ones(length(v),1)  % increment each value in the vector by one
% ans =
%   2
%   3
%   4

v + 1  % same as above

A'     % matrix transpose
% ans =
%   1   3   5
%   2   4   6

(A')'  % transpose of a transpose return back A

a = [1 15 2 0.5]
% a =
%    1.00000   15.00000    2.00000    0.50000

val = max(a)  %  val =  15
[val, indx] = max(a)
% val =  15
% indx =  2

max(A)  % column wise maximum
% ans =
%   5   6

a < 3    % element wise comparison
% ans =
%  1  0  1  1

% find(a < 3)  % which the index of the elements
% ans =
%   1   3   4

A = magic(3)
% A =
%   8   1   6
%   3   5   7
%   4   9   2

[r, c] = find(A >= 7)
% r =
%   1
%   3
%   2
%
% c =
%   1
%   2
%   3

A(2, 3) % ans =  7

sum(a)  %  ans =  18.500  % sum(a, 1) by row  % sum(a, 2) by column
prod(a) %  ans =  15

floor(a)
% ans =
%    1   15    2    0

ceil(a)
% ans =
%    1   15    2    1

max(A, [], 1)  % per column maximum
% ans =
%   8   9   7

max(A, [], 2)  % per row maxumum
% ans =
%   8
%   7
%   9

max(max(A)) % ans =  9  % of the whole matrix

sum(sum(A .* eye(9)))   % sum of the diagonal, using identity
sum(sum(A .* flipud(eye(9))))  % sum of the other diagonal, using flipud

pinv(A)     % inverse of the matrix A
% ans =
%   0.147222  -0.144444   0.063889
%  -0.061111   0.022222   0.105556
%  -0.019444   0.188889  -0.102778

pinv(A) * A % inverse multiplied by inteself yield the identity matrix
% ans =
%   1.00000   0.00000  -0.00000
%  -0.00000   1.00000   0.00000
%   0.00000   0.00000   1.00000
```

Random numbers

```matlab
w = rand(1,3)
% w =
%   0.929673   0.335081   0.071794

w = rand(3,3)
% w =
%   0.169280   0.861922   0.581426
%   0.811334   0.792225   0.879152
%   0.568244   0.019950   0.709208

w = randn(1,3)
% w =
%  -0.44849   1.36413  -0.48032
```

Getting help

```matlab
help rand
help hist
help help
```

Moving around

```matlab
pwd   %  ans = /scripts
ls
cd '/home/'
load featureX.dat
load('featureY.dat')
save hello.mat variable;
save hello.txt variable -ascii  % saves as a text file
```

Control flow

```matlab
v = zeros(10,1)  % create a vector of 10 zeroes

for i=1:10,      % for loop
> v(i) = 2^i;
> end;

indices = 1:10;  % using premade array
for i=indices,
> disp(i);
> end;

i = 1;
while i <= 5,    % while loop
> v(i) = 100;
> i = i + 1;
> end;

i=1;
while true,
> v(i) = 999;
> i = i+1;
>  if i == 6,    % conditional
>    break;      % breaking out of the loop
>  end;
> end;

v(1) = 2;
if v(1)==1,
>   disp('The value is one');
>  elseif v(1) == 2,
>   disp('The value is two');
>  else
>   disp('The value is not one or two');
> end;
% The value is two
```

Functions

```matlab
% squareThisNumber.m in the search path
% addpath('/home/octave')
function y = squareThisNumber(x)

y = x^2;
```

```matlab
% squareAndCubeThisNumber.m
% returning 2 values
function [y1, y2] = squareAndCubeThisNumber(x)

y1 = x^2;
y2 = x^3;
```

```matlab
fuction J = costFunctionJ(X, y, theta)

% X is the "design matrix" containing our training examples
% y is the class labels

m = size(X,1);            % number of training examples
predictions = X * theta;  % predictions of hypothesis on all m examples
sqErrors = (predictions-y).^2;  % squared errors

J = 1/(2*m) * sum(sqErrors);
```

```matlab
% usage of cost function
X = [1 1; 1 2; 1 3]
% X =
%   1   1
%   1   2
%   1   3

y = [1; 2; 3]
% y =
%   1
%   2
%   3

theta = [0:1]
% theta =
%   0   1

j = costFunctionJ(X, y, theta)
```

```matlab
function theta = gradientDescent(X, y, theta, alpha, num_iters)

m = length(y);                              % number of training examples

for iter = 1:num_iters
  predictions = X * theta;                  % hypothesis
  errors = predictions - y;                 % hypothesis - y
  delta = (1 / m) * sum(errors .* X(2));    % col1 is 1's

  theta = theta - alpha * delta;
end
```

Vectorization

```matlab
% unvectorized implementation
prediction = 0.0;
for j = 1:n+1,
  prediction = prediction + theta(j) * x(j)
end;

% vectorized implmentation
prediction = theta' * x;
```

Plotting data

```matlab
t = [0:0.01:0.98];

y1 = sin(2*pi*4*t);
plot(t,y1)

y2 = cos(2*pi*4*t);
plot(t,y2)

plot(t,y1)
hold on;
plot(t,y2)

xlabel('time')
ylabel('value')
legend('sin','cos')
title('my plot')
print -dpng 'myPlot.png'
close

figure(1): plot(t,y1);
figure(2): plot(t, y2);
subplot(1,2,1);
plot(t, y1)
subplot(1,2,2);
plot(t, y2)
axis([0.5 1 -1 1])
clf;

A = magic(5)
imagesc(A)
imagesc(A), colorbar, colormap gray;
```

Advanced optimization algorithm

```matlab
function [jVal, gradient] = costFunction(theta)

jVal = (theta(1) - 5)^2 + (theta(2) - 5)^2; % code to compute J(theta)

gradient(1) = 2 * (theta(1) - 5);           % derivative for theta_0
gradient(2) = 2 * (theta(2) - 5);           % derivative for theta_1

options = optimset('GradObj', 'on', 100);
initialTheta = zeroes(2,1);
% function minimization unconstrained
[optTheta, functionVal, exitFlag] = fminunc(@costFunction, initialTheta, options);
```

Unrolling parameters into a vector

```matlab
thetaVector = [ Theta1(:); Theta2(:); Theta3(:); ]
deltaVector = [ D1(:); D2(:); D3(:) ]
```

Reshape the matrix back from the unrolled vector

```matlab
% if the dimensions of Theta1 is 10x11, Theta2 is 10x11 and Theta3 is 1x11
Theta1 = reshape(thetaVector(1:110),10,11)
Theta2 = reshape(thetaVector(111:220),10,11)
Theta3 = reshape(thetaVector(221:231),1,11)
```

Gradient checking

```matlab
epsilon = 1e-4;
for i = 1:n,
  thetaPlus = theta;
  thetaPlus(i) += epsilon;
  thetaMinus = theta;
  thetaMinus(i) -= epsilon;
  gradApprox(i) = (J(thetaPlus) - J(thetaMinus))/(2*epsilon)
end;
```

Random initialization: symmetry breaking

```matlab
% if the dimensions of Theta1 is 10x11, Theta2 is 10x11 and Theta3 is 1x11.

Theta1 = rand(10,11) * (2 * INIT_EPSILON) - INIT_EPSILON;
Theta2 = rand(10,11) * (2 * INIT_EPSILON) - INIT_EPSILON;
Theta3 = rand(1,11) * (2 * INIT_EPSILON) - INIT_EPSILON;
```
