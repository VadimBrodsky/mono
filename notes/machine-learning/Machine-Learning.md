## Definition of Machine Learning

Older informal definition:

> Machine Learning: A Field of study that gives computers the ability to learn without being explicitly programmed.
Arthur Samuel (1959)


Modern definition:

> Well-posed Learning Problem: A computer program is said to _learn_ from experience E with respect to some task T and some performance P, if its performance on T, as measured by P, improves with experience E.
Tom Mitchell (1998)

Example: playing checkers:
- E = the experience of playing many games of checkers
- T = the task of playing checkers.
- P = the probability that the program will win the next game.


## Types of Machine Learning Algorithms:
- Supervised learning - teach the computer to do something
- Unsupervised learning - let the computer to learn by itself
- Reinforcement learning
- Recommender systems


## Supervised Learning - right answers given

In supervised learning, we are given a data set and already know what our correct output should look like, having the idea that there is a relationship between the input and the output.

Can scale up to infinite number of input features or properties.

Supervised learning problems categories:
- *Regression problem*: trying to predict results within a continuous output (price), map input variables to some continuous function.
- *Classification problem*: trying to predict results in a discrete output (0 or 1). map input variables into discrete categories.


## Unsupervised Learning - no right answers or labels given

Unsupervised learning approaches problems with little or no idea what our results should look like. Derive structure from data where not necessarily know the effect of the variables. No feedback based on the prediction results.

- *Clustering*: Derive structure that the data based on relationships among the variables in the data. Finds a way to automatically create group that are somehow similar or related by different variable.
- *Non-clustering*: The "Cocktail Party Algorithm", find structure in a chaotic environment. (i.e. identifying individual voices and music from a mesh of sounds).


## Model Representation - Linear regression with one variable

Description of a supervised learning problem more, given a training set, to learn a function h : X → Y so that h(x) is a “good” predictor for the corresponding value of y.

Notation:
- *m* - number of training examples, training set
- *x*'s' - input variable / feature
- *y*'s' - output variable / feature
- *x,y*  - one training set example
- *x^(i),y^(i)* - ith training example

Training Set => 
 |> Learning Algorithm, x
 |> h (hypothesis function)
 |> Estimated value of y
 
h maps from x's to y's

#### Linear regression with one variable x
Also called univariate linear regression

Choose `/theta_0`, `/theta_1` so that `h_/theta(x)` is close to `y` for our training set `(x,y)`

![hypothesis function](http://chart.apis.google.com/chart?cht=tx&chl=h_%5Ctheta%20%3D%20%5Ctheta_0%20%2B%20%5Ctheta_1x)

```tex
h_\theta = \theta_0 + \theta_1x
```

#### Cost function
Also called squared error function

Measure the accuracy of the hypothesis function. This takes an average difference of all the results of the hypothesis with inputs from x's and the actual output y's.

![cost funcion](http://chart.apis.google.com/chart?cht=tx&chl=J(%5Ctheta_0%2C%20%5Ctheta_1)%20%3D%20%5Cfrac%20%7B1%7D%7B2m%7D%20%5Cdisplaystyle%20%5Csum%20_%7Bi%3D1%7D%5Em%20%5Cleft%20(%20%5Chat%7By%7D_%7Bi%7D-%20y_%7Bi%7D%20%5Cright)%5E2%20%3D%20%5Cfrac%20%7B1%7D%7B2m%7D%20%5Cdisplaystyle%20%5Csum%20_%7Bi%3D1%7D%5Em%20%5Cleft%20(h_%5Ctheta%20(x_%7Bi%7D)%20-%20y_%7Bi%7D%20%5Cright)%5E2%0A)

```tex
J(\theta_0, \theta_1) = \frac {1}{2m} \displaystyle \sum _{i=1}^m \left ( \hat{y}_{i}- y_{i} \right)^2 = \frac {1}{2m} \displaystyle \sum _{i=1}^m \left (h_\theta (x_{i}) - y_{i} \right)^2
```
- it is `{1}\over{2}\bar{x}` where `\bar{x}` is the mean of the squares of `h_\theta(x_i) - y_i`
- or the difference between the predicted value and the actual value

The objective is to get the best possible line. The best possible line is the average squared vertical distances of the scattered points from the line will be the least. Ideally, the line should pass through all the points of our training data set. Value of `J(\theta_0, \theta_1)` will be 0. Try to minimize the cost function.


### Gradient Descent
Used to estimate the parameters in the hypothesis function. To minimize the cost function with any number of input variables.

The way we do this is by taking the derivative (the tangential line to a function) of our cost function. The slope of the tangent is the derivative at that point and it will give us a direction to move towards. We make steps down the cost function in the direction with the steepest descent. The size of each step is determined by the parameter `α`, which is called the learning rate.

The direction in which the step is taken is determined by the partial derivative of `J(\theta_0, \theta_1)`. Depending on where one starts on the graph, one could end up at different points

The gradient descent algorithm is repeated repeat until convergence:

![gradient descent](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta_j%20%3A%3D%20%5Ctheta_j%20-%20%5Calpha%20%5Cfrac%7B%5Cpartial%7D%7B%5Cpartial%20%5Ctheta_j%7D%20J(%5Ctheta_0%2C%20%5Ctheta_1))

```tex
\theta_j := \theta_j - \alpha \frac{\partial}{\partial \theta_j} J(\theta_0, \theta_1)
```

- `j=0,1` represents the feature index number.
- At each iteration `j`, one should simultaneously update the parameters `\theta_1, \theta_2...\theta_n`. 
- Updating a specific parameter prior to calculating another one on the `j^{(th)}` iteration would yield to a wrong implementation.
- Should adjust our parameter `/alpha` to ensure that the gradient descent algorithm converges in a reasonable time. Failure to converge or too much time to obtain the minimum value imply that our step size is wrong.
- Gradient descent can converge to a local minimum, even with the learning rate `/alpha` fixed.
- As we approach a local minimum, gradient descent will automatically takes smaller steps. So no need to decrease `/alpha` over time.


### "Batch" Gradient Descent
- Combining gradient descent and linear regression.
- "Batch": Each step of gradient descent uses all the training examples.

Repeat until convergence:

![theta_0](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta_0%20%3A%3D%20%5Ctheta_0%20-%20%5Calpha%20%5Cfrac%7B1%7D%7Bm%7D%20%5Csum%5Climits_%7Bi%3D1%7D%5E%7Bm%7D(h_%5Ctheta(x_%7Bi%7D)%20-%20y_%7Bi%7D)%20)

![theta_1](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta_1%20%3A%3D%20%5Ctheta_1%20-%20%5Calpha%20%5Cfrac%7B1%7D%7Bm%7D%20%5Csum%5Climits_%7Bi%3D1%7D%5E%7Bm%7D%5Cleft((h_%5Ctheta(x_%7Bi%7D)%20-%20y_%7Bi%7D)%20x_%7Bi%7D%5Cright)%20)

```tex
\begin{align*} \text{repeat until convergence: } \lbrace & \newline \theta_0 := & \theta_0 - \alpha \frac{1}{m} \sum\limits_{i=1}^{m}(h_\theta(x_{i}) - y_{i}) \newline \theta_1 := & \theta_1 - \alpha \frac{1}{m} \sum\limits_{i=1}^{m}\left((h_\theta(x_{i}) - y_{i}) x_{i}\right) \newline \rbrace& \end{align*}
```
While gradient descent can be susceptible to local minima in general, the optimization problem we have posed here for linear regression has only one global, and no other local, optima; thus gradient descent always converges (assuming the learning rate α is not too large) to the global minimum.


## Matrices and Vectors

- Matrices are two dimensional arrays.
- If a matrix had 4 rows and 3 columns, its a 4 x 3 matrix.
- Vector is a matrix with one column and many rows, vectors are a subset of matrices.


### Notation
- `A_{ij}`  refers to the element in the ith row and jth column of matrix A.
- A vector with 'n' rows is referred to as an 'n'-dimensional vector.
- `v_i` refers to the element in the ith row of the vector.
- Matrices can be 1-indexed, or like in some programming languages, 0-indexed.
- Matrices are usually denoted by uppercase names while vectors are lowercase.
- "Scalar" means that an object is a single value, not a vector or matrix.
- `\mathbb{R}` refers to the set of scalar real numbers.
- `\mathbb{R^n}` refers to the set of n-dimensional vectors of real numbers.


### Addition and Scalar Multiplication
- Addition and subtraction are element-wise, so you simply add or subtract each corresponding element.
- To add or subtract two matrices, their dimensions must be the same.
- In scalar multiplication, we simply multiply every element by the scalar value.
- In scalar division, we simply divide every element by the scalar value.

### Matrix Vector Multiplication
- We map the column of the vector onto each row of the matrix, multiplying each element and summing the result.
- The result is a vector. The number of columns of the matrix must equal the number of rows of the vector.
- An m x n matrix multiplied by an n x 1 vector results in an m x 1 vector.

### Matrix Matrix Multiplication
- We multiply two matrices by breaking it into several vector multiplications and concatenating the result.
- an m x n matrix multiplied by an n x o matrix results in an m x o matrix.
- To multiply two matrices, the number of columns of the first matrix must equal the number of rows of the second matrix.

```tex
\begin{bmatrix} a & b \newline c & d \newline e & f \end{bmatrix} *\begin{bmatrix} w & x \newline y & z \newline \end{bmatrix} =\begin{bmatrix} a*w + b*y & a*x + b*z \newline c*w + d*y & c*x + d*z \newline e*w + f*y & e*x + f*z\end{bmatrix}
```

### Matrix Multiplication Properties
- Matrices are not commutative: `A * B !== B * A`
- Matrices are associative: `( A * B ) * C =  A * ( B * C )`
- The identity matrix: when multiplied by any matrix of the same dimensions, results in the original matrix.
- It's just like multiplying numbers by 1. The identity matrix simply has 1's on the diagonal and 0's elsewhere.
- When multiplying the identity matrix after some matrix (A∗I), the square identity matrix's dimension should match the other matrix's columns.
- When multiplying the identity matrix before some other matrix (I∗A), the square identity matrix's dimension should match the other matrix's rows.

```tex
\begin{bmatrix} 1 & 0 & 0 \newline 0 & 1 & 0 \newline 0 & 0 & 1 \newline \end{bmatrix}
```

### Inverse and Transpose
- The inverse of a matrix A is denoted `A^{-1}`. Multiplying by the inverse results in the identity matrix.
- A non square matrix does not have an inverse matrix.
- We can compute inverses of matrices in octave with the `pinv(A)` function and in Matlab with the `inv(A)` function.
- Matrices that don't have an inverse are singular or degenerate.
- The transposition of a matrix is like rotating the matrix 90° in clockwise direction and then reversing it.
- We can compute transposition of matrices in matlab with the `transpose(A)` function or `A'`.

```tex
A_{ij} = A^T_{ji}
```

## Multivariate Linear Regression
Linear regression with multiple variables is also known as "multivariate linear regression".

Notation for equations where we can have any number of input variables:
- `x^{(i)_j}` - value of feature `j` in the `i`'th training example
- `x^{(i)}` - the input (features) of the `i`'th training example
- `m` - the number of training examples
- `n` - the number of features

The multivariable form of the hypothesis function accommodating these multiple features is as follows:

![multivariable hypothesis](http://chart.apis.google.com/chart?cht=tx&chl=h_%5Ctheta%20(x)%20%3D%20%5Ctheta_0%20%2B%20%5Ctheta_1%20x_1%20%2B%20%5Ctheta_2%20x_2%20%2B%20%5Ctheta_3%20x_3%20%2B%20%5Ccdots%20%2B%20%5Ctheta_n%20x_n)

```
h_\theta (x) = \theta_0 + \theta_1 x_1 + \theta_2 x_2 + \theta_3 x_3 + \cdots + \theta_n x_n
```

Using the definition of matrix multiplication, the multivariable hypothesis function can be concisely represented as a vector. This is a vectorization of the hypothesis function for one training example

![vectorization of hypothesis](http://latex.codecogs.com/png.latex?%5Cdpi%7B0%7D%20%5Cbg_white%20%5Cbegin%7Balign*%7Dh_%5Ctheta(x)%20%3D%5Cbegin%7Bbmatrix%7D%5Ctheta_0%20%5Chspace%7B2em%7D%20%5Ctheta_1%20%5Chspace%7B2em%7D%20...%20%5Chspace%7B2em%7D%20%5Ctheta_n%5Cend%7Bbmatrix%7D%5Cbegin%7Bbmatrix%7Dx_0%20%5Cnewline%20x_1%20%5Cnewline%20%5Cvdots%20%5Cnewline%20x_n%5Cend%7Bbmatrix%7D%3D%20%5Ctheta%5ET%20x%5Cend%7Balign*%7D)

```tex
\begin{align*}h_\theta(x) =\begin{bmatrix}\theta_0 \hspace{2em} \theta_1 \hspace{2em} ... \hspace{2em} \theta_n\end{bmatrix}\begin{bmatrix}x_0 \newline x_1 \newline \vdots \newline x_n\end{bmatrix}= \theta^T x\end{align*}
```

For convenience reasons we assume `x_{0}^{(i)} =1 \text{ for } (i\in { 1,\dots, m } )`. This allows us to do matrix operations with theta and x. Hence making the two vectors 'θ' and x(i) match each other element-wise, (that is, have the same number of elements: n+1).]


### Gradient Descent For Multiple Variables

The gradient descent equation itself is generally the same form; we just have to repeat it for our 'n' features:

Repeat until convergence {

![theta0](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta_0%20%3A%3D%20%5Ctheta_0%20-%20%5Calpha%20%5Cfrac%7B1%7D%7Bm%7D%20%5Csum%5Climits_%7Bi%3D1%7D%5E%7Bm%7D%20(h_%5Ctheta(x%5E%7B(i)%7D)%20-%20y%5E%7B(i)%7D)%20%5Ccdot%20x_0%5E%7B(i)%7D)

![theta1](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta_1%20%3A%3D%20%5Ctheta_1%20-%20%5Calpha%20%5Cfrac%7B1%7D%7Bm%7D%20%5Csum%5Climits_%7Bi%3D1%7D%5E%7Bm%7D%20(h_%5Ctheta(x%5E%7B(i)%7D)%20-%20y%5E%7B(i)%7D)%20%5Ccdot%20x_1%5E%7B(i)%7D%20)

![theta2](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta_2%20%3A%3D%20%5Ctheta_2%20-%20%5Calpha%20%5Cfrac%7B1%7D%7Bm%7D%20%5Csum%5Climits_%7Bi%3D1%7D%5E%7Bm%7D%20%0A%0A(h_%5Ctheta(x%5E%7B(i)%7D)%20-%20y%5E%7B(i)%7D)%20%5Ccdot%20x_2%5E%7B(i)%7D%20)
}


```tex
\begin{align*} & \text{repeat until convergence:} \; \lbrace \newline \; & \theta_0 := \theta_0 - \alpha \frac{1}{m} \sum\limits_{i=1}^{m} (h_\theta(x^{(i)}) - y^{(i)}) \cdot x_0^{(i)}\newline \; & \theta_1 := \theta_1 - \alpha \frac{1}{m} \sum\limits_{i=1}^{m} (h_\theta(x^{(i)}) - y^{(i)}) \cdot x_1^{(i)} \newline \; & \theta_2 := \theta_2 - \alpha \frac{1}{m} \sum\limits_{i=1}^{m} (h_\theta(x^{(i)}) - y^{(i)}) \cdot x_2^{(i)} \newline & \cdots \newline \rbrace \end{align*}
```

In other words:

![gradient descent for multiple variables](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta_j%20%3A%3D%20%5Ctheta_j%20-%20%5Calpha%20%5Cfrac%7B1%7D%7Bm%7D%20%5Csum%5Climits_%7Bi%3D1%7D%5E%7Bm%7D%20(h_%5Ctheta(x%5E%7B(i)%7D)%20-%20y%5E%7B(i)%7D)%20%5Ccdot%20x_j%5E%7B(i)%7D%20%5C%3B%20%20%20%20%5Ctext%7Bfor%20j%20%3A%3D%200...n%7D)

```tex
\begin{align*}& \text{repeat until convergence:} \; \lbrace \newline \; & \theta_j := \theta_j - \alpha \frac{1}{m} \sum\limits_{i=1}^{m} (h_\theta(x^{(i)}) - y^{(i)}) \cdot x_j^{(i)} \; & \text{for j := 0...n}\newline \rbrace\end{align*}
```

### Feature Scaling
Speed up gradient descent by normalizing each input value to roughly the same range. This is because `θ` will descend quickly on small ranges and slowly on large ranges, oscillate inefficiently down to the optimum when the variables are very uneven.

The way to prevent this is to modify the ranges of our input variables so that they are all roughly the same:
`-1 <= x_{(i)} <= 1` or `-0.5 <= x_{(i)} <= 0.5`


- Feature scaling involves dividing the input values by the range (i.e. the maximum value minus the minimum value) of the input variable, resulting in a new range of just 1.
- Mean normalization involves subtracting the average value for an input variable from the values for that input variable resulting in a new average value for the input variable of just zero. 

![feature scailing](http://chart.apis.google.com/chart?cht=tx&chl=x_i%20%3A%3D%20%5Cfrac%7Bx_i%20-%20%5Cmu_i%7D%7Bs_i%7D)

```tex
:= \dfrac{x_i - \mu_i}{s_i}
```

Where `μi `is the average of all the values for feature `(i)` and `si `is the range of values (max - min), or `si `is the standard deviation.


### Learning Rate
- *Debugging gradient descent*. Make a plot with number of iterations on the x-axis.
- Plot the cost function, `J(θ)` over the number of iterations of gradient descent. If `J(θ)` ever increases, you probably need to decrease `α`.
- *Automatic convergence test*. Declare convergence if `J(θ)` decreases by less than `E` in one iteration, where `E` is some small value such as `10^−3`. In practice it's difficult to choose this threshold value.
- It was proved that if learning rate `α` is sufficiently small, then `J(θ)` will decrease on every iteration.
- If `α` is too small: slow convergence.
- If `α` is too large: ￼may not decrease on every iteration and thus may not converge.


### Features and Polynomial Regression
We can improve our features and the form of our hypothesis by combining multiple features into one. For example, we can combine `x1 `and `x2 `into a new feature `x3 ` by taking `x1⋅x2`.

#### Polynomial Regression
Our hypothesis function need not be linear (a straight line) if that does not fit the data well. We can change the behavior or curve of our hypothesis function by making it a quadratic, cubic or square root function (or any other form).

Hypothesis function:

![](http://chart.apis.google.com/chart?cht=tx&chl=h_%5Ctheta(x)%20%3D%20%5Ctheta_0%20%2B%20%5Ctheta_1%20x_1)

```tex
h_\theta(x) = \theta_0 + \theta_1 x_1
```

Create additional features based on x1, to get the Quadratic function:

![](http://chart.apis.google.com/chart?cht=tx&chl=h_%5Ctheta(x)%20%3D%20%5Ctheta_0%20%2B%20%5Ctheta_1%20x_1%20%2B%20%5Ctheta_2%20x_1%5E2)

```tex
h_\theta(x) = \theta_0 + \theta_1 x_1 + \theta_2 x_1^2
```

Cubic function

![](http://chart.apis.google.com/chart?cht=tx&chl=h_%5Ctheta(x)%20%3D%20%5Ctheta_0%20%2B%20%5Ctheta_1%20x_1%20%2B%20%5Ctheta_2%20x_1%5E2%20%2B%20%5Ctheta_3%20x_1%5E3)

```tex
h_\theta(x) = \theta_0 + \theta_1 x_1 + \theta_2 x_1^2 + \theta_3 x_1^3
```

Square root function

![](http://chart.apis.google.com/chart?cht=tx&chl=h_%5Ctheta(x)%20%3D%20%5Ctheta_0%20%2B%20%5Ctheta_1%20x_1%20%2B%20%5Ctheta_2%20%5Csqrt%7Bx_1%7D)

```tex
h_\theta(x) = \theta_0 + \theta_1 x_1 + \theta_2 \sqrt{x_1}
```

If you choose your features this way then feature scaling becomes very important. if `x1 ` has range `1 - 1000` then range of `x^21` becomes `1 - 1000000` and that of `x^31` becomes `1 - 1000000000`.


#### Normal Equation
Performing the minimization explicitly and without resorting to an iterative algorithm. In the "Normal Equation" method, will minimize `J` by explicitly taking its derivatives with respect to the `θj`’s, and setting them to zero. This allows us to find the optimum theta without iteration.

The normal equation formula:

![normal function](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta%20%3D%20(X%5ET%20X)%5E%7B-1%7DX%5ET%20y)

```tex
\theta = (X^T X)^{-1}X^T y
```

There is no need to do feature scaling with the normal equation.

#### Pros and Cons

| Gradient Descent           | Normal Equation                            |
|----------------------------|--------------------------------------------|
| Need to choose alpha       | No need to choose alpha                    |
| Needs many iterations      | No need to iterate                         |
| O (kn^2)                   | O (n^3), need to calculate inverse of X^TX |
| Works well when n is large | Slow if n is very large                    |

If we have a very large number of features, the normal equation will be slow. In practice, when n exceeds 10,000 it might be a good time to go from a normal solution to an iterative process.


#### Normal Equation Noninvertibility
When implementing the normal equation in octave we want to use the `pinv` function rather than `inv` The `pinv` function will give you a value of `θ` even if `X^TX` is not invertible.

If X^TX is noninvertible, the common causes:
- Redundant features, where two features are very closely related (linearly dependent).
- Too many features (e.g. m ≤ n). In this case, delete some features or use "regularization".

Solutions to the above problems include deleting a feature that is linearly dependent with another or deleting one or more features when there are too many features.


## Classification
To attempt classification, one method is to use linear regression and map all predictions greater than 0.5 as a 1 and all less than 0.5 as a 0. However, this method doesn't work well because classification is not actually a linear function.

- The classification problem is just like the regression problem, except that the values we now want to predict take on only a small number of discrete values
- *Binary classification* problem in which y can take on only two values, 0 and 1.
- Values `y ∈ {0,1}`. 0 is also called the negative class, and 1 the positive class,
- Denoted by the symbols `-` and `+` Given `x^{(i)}`, the corresponding `y^{(i)}` called the label for the training example.

### Classification Hypothesis Representation

- Change the form for our hypotheses `hθ(x)` to satisfy `0 ≤ hθ(x) ≤ 1` 
- Plug the hypothesis into the Logistic Function / Sigmoid Function

![Hypothesis](http://chart.apis.google.com/chart?cht=tx&chl=h_%5Ctheta%20(x)%20%3D%20g%20(%20%5Ctheta%5ET%20x%20)%20)

![Sigmoid Function](http://chart.apis.google.com/chart?cht=tx&chl=g(z)%20%3D%20%5Cfrac%7B1%7D%7B1%20%2B%20e%5E%7B-z%7D%7D)

```tex
\begin{align*}& h_\theta (x) = g ( \theta^T x ) \newline \newline& z = \theta^T x \newline& g(z) = \dfrac{1}{1 + e^{-z}}\end{align*}
```
- The function g(z), maps any real number to the (0, 1) interval, making it useful for transforming an arbitrary-valued function into a function better suited for classification.
- `hθ(x)` gives us the probability that our output is 1.
- `hθ(x) = 0.7` gives us a probability of 70% that our output is 1.
- Probability that our prediction is 0 is just the complement of our probability that it is 1.

![Classification Probability](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta(x)%20%3D%20P(y%3D1%20%7C%20x%20%3B%20%5Ctheta)%20%3D%201%20-%20P(y%3D0%20%7C%20x%20%3B%20%5Ctheta))

```tex
\begin{align*}& h_\theta(x) = P(y=1 | x ; \theta) = 1 - P(y=0 | x ; \theta) \newline& P(y = 0 | x;\theta) + P(y = 1 | x ; \theta) = 1\end{align*}
```

## Decision Boundary
In order to get our discrete 0 or 1 classification, we can translate the output of the hypothesis function as follows:

![classification](http://chart.apis.google.com/chart?cht=tx&chl=%20h_%5Ctheta(x)%20%5Cgeq%200.5%20%5Crightarrow%20y%20%3D%201%20%5Chspace%7B30pt%7D%20h_%5Ctheta(x)%20%3C%200.5%20%5Crightarrow%20y%20%3D%200%20)

```tex
\begin{align*}& h_\theta(x) \geq 0.5 \rightarrow y = 1 \newline& h_\theta(x) < 0.5 \rightarrow y = 0 \newline\end{align*}
```

The *decision boundary* is the line that separates the area where y = 0 and where y = 1. It is created by our hypothesis function.

![decision boundary](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta%5ET%20x%20%5Cgeq%200%20%5CRightarrow%20y%20%3D%201%20%20%5Chspace%7B30pt%7D%20%5Ctheta%5ET%20x%20%3C%200%20%5CRightarrow%20y%20%3D%200)

```tex
\begin{align*}& \theta^T x \geq 0 \Rightarrow y = 1 \newline& \theta^T x < 0 \Rightarrow y = 0 \newline\end{align*}
```

```matlab
theta = [5; -1; 0]
% y = 1 if 5 + (-1) * x(1) + 0 * x(2) >= 0
% 5 - x(1) >= 0
% -x(1) >= -5
% x(1) <= 5
```

The boundary is a straight vertical line placed on the graph where `x(1) == 5`, and everything to the left of that denotes `y == 1`, while everything to the right denotes `y == 0`.


## Cost Function
We cannot use the same cost function that we use for linear regression because the Logistic Function will cause the output to be wavy, causing many local optima. In other words, it will not be a convex function.

![cost for classification](http://chart.apis.google.com/chart?cht=tx&chl=%20J(%5Ctheta)%20%3D%20%5Cfrac%7B1%7D%7Bm%7D%20%5Csum_%7Bi%3D1%7D%5Em%20%5Cmathrm%7BCost%7D(h_%5Ctheta(x%5E%7B(i)%7D)%2Cy%5E%7B(i)%7D))

![cost for classification](http://chart.apis.google.com/chart?cht=tx&chl=%5Cmathrm%7BCost%7D(h_%5Ctheta(x)%2Cy)%20%3D%20-%5Clog(h_%5Ctheta(x))%20%5C%3B%20%26%20%5Ctext%7Bif%20y%20%3D%201%7D%0A)

![cost for classification](http://chart.apis.google.com/chart?cht=tx&chl=%20%5Cmathrm%7BCost%7D(h_%5Ctheta(x)%2Cy)%20%3D%20-%5Clog(1-h_%5Ctheta(x))%20%5C%3B%20%26%20%5Ctext%7Bif%20y%20%3D%200%7D)

```tex
\begin{align*}& J(\theta) = \dfrac{1}{m} \sum_{i=1}^m \mathrm{Cost}(h_\theta(x^{(i)}),y^{(i)}) \newline & \mathrm{Cost}(h_\theta(x),y) = -\log(h_\theta(x)) \; & \text{if y = 1} \newline & \mathrm{Cost}(h_\theta(x),y) = -\log(1-h_\theta(x)) \; & \text{if y = 0}\end{align*}
```

Which translates to:

![cost of classification](http://chart.apis.google.com/chart?cht=tx&chl=%20%5Cmathrm%7BCost%7D(h_%5Ctheta(x)%2Cy)%20%3D%200%20%5Ctext%7B%20if%20%7D%20h_%5Ctheta(x)%20%3D%20y%20%5C%0A)

![cost of classification](http://chart.apis.google.com/chart?cht=tx&chl=%7BCost%7D(h_%5Ctheta(x)%2Cy)%20%5Crightarrow%20%5Cinfty%20%5Ctext%7B%20if%20%7D%20y%20%3D%200%20%5C%3B%20%5Cmathrm%7Band%7D%20%5C%3B%20h_%5Ctheta(x)%20%5Crightarrow%201)

![cost of classification](http://chart.apis.google.com/chart?cht=tx&chl=%20%5Cmathrm%7BCost%7D(h_%5Ctheta(x)%2Cy)%20%5Crightarrow%20%5Cinfty%20%5Ctext%7B%20if%20%7D%20y%20%3D%201%20%5C%3B%20%5Cmathrm%7Band%7D%20%5C%3B%20h_%5Ctheta(x)%20%5Crightarrow%200)

- If our correct answer `y` is 0, then the cost function will be 0 if our hypothesis function also outputs 0.
- If our hypothesis approaches 1, then the cost function will approach infinity.
- If our correct answer `y` is 1, then the cost function will be 0 if our hypothesis function outputs 1.
- If our hypothesis approaches 0, then the cost function will approach infinity.

```tex
\begin{align*}& \mathrm{Cost}(h_\theta(x),y) = 0 \text{ if } h_\theta(x) = y \newline & \mathrm{Cost}(h_\theta(x),y) \rightarrow \infty \text{ if } y = 0 \; \mathrm{and} \; h_\theta(x) \rightarrow 1 \newline & \mathrm{Cost}(h_\theta(x),y) \rightarrow \infty \text{ if } y = 1 \; \mathrm{and} \; h_\theta(x) \rightarrow 0 \newline \end{align*}
```

### Simplified Logistic Regression Cost Function and Gradient Descent

Compress our cost function's two conditional cases into one case:

![compressed cost function](http://chart.apis.google.com/chart?cht=tx&chl=%5Cmathrm%7BCost%7D(h_%5Ctheta(x)%2Cy)%20%3D%20-%20y%20%5C%3B%20%5Clog(h_%5Ctheta(x))%20-%20(1%20-%20y)%20%5Clog(1%20-%20h_%5Ctheta(x)))

```tex
\mathrm{Cost}(h_\theta(x),y) = - y \; \log(h_\theta(x)) - (1 - y) \log(1 - h_\theta(x))
```

When `y` is equal to 1, then the second term will be zero and will not affect the result. If `y` is equal to `0`, then the first term will be zero and will not affect the result.

Entire cost function:

![entire cost function](http://chart.apis.google.com/chart?cht=tx&chl=J(%5Ctheta)%20%3D%20-%20%5Cfrac%7B1%7D%7Bm%7D%20%5Cdisplaystyle%20%5Csum_%7Bi%3D1%7D%5Em%20%5By%5E%7B(i)%7D%5Clog%20(h_%5Ctheta%20(x%5E%7B(i)%7D))%20%2B%20(1%20-%20y%5E%7B(i)%7D)%5Clog%20(1%20-%20h_%5Ctheta(x%5E%7B(i)%7D))%5D)

```tex
J(\theta) = - \frac{1}{m} \displaystyle \sum_{i=1}^m [y^{(i)}\log (h_\theta (x^{(i)})) + (1 - y^{(i)})\log (1 - h_\theta(x^{(i)}))]
```

Vectorized implementation:

![vectorized cost function](http://chart.apis.google.com/chart?cht=tx&chl=%5Cbegin%7Balign*%7D%20%26%20h%20%3D%20g(X%5Ctheta)%26%20J(%5Ctheta)%20%3D%20%5Cfrac%7B1%7D%7Bm%7D%20%5Ccdot%20%5Cleft(-y%5E%7BT%7D%5Clog(h)-(1-y)%5E%7BT%7D%5Clog(1-h)%5Cright)%20%5Cend%7Balign*%7D)

```tex
\begin{align*} & h = g(X\theta)\newline & J(\theta) = \frac{1}{m} \cdot \left(-y^{T}\log(h)-(1-y)^{T}\log(1-h)\right) \end{align*}
```

#### Gradient Descent
This algorithm is identical to the one we used in linear regression. We still have to simultaneously update all values in theta.

![gradient descent](http://chart.apis.google.com/chart?cht=tx&chl=%5Cbegin%7Balign*%7D%20%26%20Repeat%20%5C%3B%20%5Clbrace%20%26%20%5C%3B%20%5Ctheta_j%20%3A%3D%20%5Ctheta_j%20-%20%5Cfrac%7B%5Calpha%7D%7Bm%7D%20%5Csum_%7Bi%3D1%7D%5Em%20(h_%5Ctheta(x%5E%7B(i)%7D)%20-%20y%5E%7B(i)%7D)%20x_j%5E%7B(i)%7D%20%26%20%5Crbrace%20%5Cend%7Balign*%7D)

```tex
\begin{align*} & Repeat \; \lbrace \newline & \; \theta_j := \theta_j - \frac{\alpha}{m} \sum_{i=1}^m (h_\theta(x^{(i)}) - y^{(i)}) x_j^{(i)} \newline & \rbrace \end{align*}
```

Vectorized implementation:

![vectorized gradient descent](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta%20%3A%3D%20%5Ctheta%20-%20%5Cfrac%7B%5Calpha%7D%7Bm%7D%20X%5E%7BT%7D%20(g(X%20%5Ctheta%20)%20-%20%5Cvec%7By%7D))

```tex
\theta := \theta - \frac{\alpha}{m} X^{T} (g(X \theta ) - \vec{y})
```

### Advanced Optimization

"Conjugate gradient", "BFGS", and "L-BFGS" are more sophisticated, faster ways to optimize `θ` that can be used instead of gradient descent.

First need to provide a function that evaluates the J value of theta, and the gradient functions for a given input value theta

There is no need for alpha when using `fminunc`, therefore the gradient formula is simpler:

```matlab
grad = (1 / m) * X' * (hypothesis - y)
```

A single function that returns both of these:

```matlab
function [jVal, gradient] = costFunction(theta)
  jVal = [...code to compute J(theta)...];
  gradient = [...code to compute derivative of J(theta)...];
end
```

```matlab
options = optimset('GradObj', 'on', 'MaxIter', 100);
initialTheta = zeros(2,1);
[optTheta, functionVal, exitFlag] = fminunc(@costFunction, initialTheta, options);
```

Then we can use octave's `fminunc()` optimization algorithm along with the `optimset()` function that creates an object containing the options we want to send to `fminunc()`.

We give to the function `fminunc()` our cost function, our initial vector of theta values, and the "options" object that we created beforehand.

### Multiclass Classification: One-vs-all
Classification of data when we have more than two categories. Instead of `y = {0,1}` we will expand our definition so that `y = {0,1...n}`.

![multiclass prediction](http://chart.apis.google.com/chart?cht=tx&chl=%5Cbegin%7Balign*%7D%26%20y%20%5Cin%20%5Clbrace0%2C%201%20...%20n%5Crbrace%20%26%20%20h_%5Ctheta%5E%7B(n)%7D(x)%20%3D%20P(y%20%3D%20n%20%7C%20x%20%3B%20%5Ctheta)%20%26%20%5Cmathrm%7Bprediction%7D%20%3D%20%5Cmax_i(%20h_%5Ctheta%20%5E%7B(i)%7D(x)%20)%5Cend%7Balign*%7D)

```tex
\begin{align*}& y \in \lbrace0, 1 ... n\rbrace \newline& h_\theta^{(0)}(x) = P(y = 0 | x ; \theta) \newline& h_\theta^{(1)}(x) = P(y = 1 | x ; \theta) \newline& \cdots \newline& h_\theta^{(n)}(x) = P(y = n | x ; \theta) \newline& \mathrm{prediction} = \max_i( h_\theta ^{(i)}(x) )\newline\end{align*}
```

Choosing one class and then lumping all the others into a single second class. We do this repeatedly, applying binary logistic regression to each case, and then use the hypothesis that returned the highest value as our prediction.

- Train a logistic regression classifier `hθ(x)` for each class￼ to predict the probability that `￼y = i￼`.
- To make a prediction on a new x, pick the class ￼that maximizes `hθ(x)`

### Problem of Overfitting

**Underfitting** - data clearly shows structure not captured by the model, underfitting, or high bias, is when the form of our hypothesis function h maps poorly to the trend of the data. It is usually caused by a function that is too simple or uses too few features.

**Overfitting** - high variance, is caused by a hypothesis function that fits the available data but does not generalize well to predict new data. It is usually caused by a complicated function that creates a lot of unnecessary curves and angles unrelated to the data.

This terminology is applied to both linear and logistic regression. There are two main options to address the issue of overfitting:

1. Reduce the number of features:
  - Manually select which features to keep.
  - Use a model selection algorithm
2. Regularization
  - Keep all the features, but reduce the magnitude of parameters `θj`
  - Regularization works well when we have a lot of slightly useful features.


### Regularization
If we have overfitting from our hypothesis function, we can reduce the weight that some of the terms in our function carry by increasing their cost.

We could also regularize all of our theta parameters in a single summation as:

![regularized cost function](http://chart.apis.google.com/chart?cht=tx&chl=min_%5Ctheta%5C%20%5Cfrac%7B1%7D%7B2m%7D%5C%20%20%5Csum_%7Bi%3D1%7D%5Em%20(h_%5Ctheta(x%5E%7B(i)%7D)%20-%20y%5E%7B(i)%7D)%5E2%20%2B%20%5Clambda%5C%20%5Csum_%7Bj%3D1%7D%5En%20%5Ctheta_j%5E2)

```tex
min_\theta\ \dfrac{1}{2m}\  \sum_{i=1}^m (h_\theta(x^{(i)}) - y^{(i)})^2 + \lambda\ \sum_{j=1}^n \theta_j^2
```

The `λ`, or lambda, is the regularization parameter. It determines how much the costs of our theta parameters are inflated. With the extra summation, we can smooth the output of our hypothesis function to reduce overfitting. If lambda is chosen to be too large, it may smooth out the function too much and cause underfitting.


### Regularized Linear Regression
We can apply regularization to both linear regression and logistic regression.

#### Gradient Descent

![regularized linear gradient descent](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta_j%20%3A%3D%20%5Ctheta_j(1%20-%20%5Calpha%5Cfrac%7B%5Clambda%7D%7Bm%7D)%20-%20%5Calpha%5Cfrac%7B1%7D%7Bm%7D%5Csum_%7Bi%3D1%7D%5Em(h_%5Ctheta(x%5E%7B(i)%7D)%20-%20y%5E%7B(i)%7D)x_j%5E%7B(i)%7D)

The first term in the above equation, `1−α(λ/m)` will always be less than 1. Intuitively you can see it as reducing the value of `θj` by some amount on every update.

```tex
\theta_j := \theta_j(1 - \alpha\frac{\lambda}{m}) - \alpha\frac{1}{m}\sum_{i=1}^m(h_\theta(x^{(i)}) - y^{(i)})x_j^{(i)}
```

#### Normal Equation
Regularization using the alternate method of the non-iterative normal equation. To add in regularization, the equation is the same as our original, except that we add another term inside the parentheses:

![regularized normal equation](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctheta%20%3D%20(%20X%5ETX%20%2B%20%5Clambda%20%5Ccdot%20L%20%5Cright)%5E%7B-1%7D%20X%5ETy)

Where L = `[0 0 0; 0 1 0; 0 0 1]`. `L` is a matrix with 0 at the top left and 1's down the diagonal, with 0's everywhere else. It should have dimension `(n+1)×(n+1)`. Intuitively, this is the identity matrix (though we are not including `x0`), multiplied with a single real number `λ`.

```tex
\begin{align*}& \theta = \left( X^TX + \lambda \cdot L \right)^{-1} X^Ty \newline& \text{where}\ \ L = \begin{bmatrix} 0 & & & & \newline & 1 & & & \newline & & 1 & & \newline & & & \ddots & \newline & & & & 1 \newline\end{bmatrix}\end{align*}
```
Recall that if `m < n`, then `X^TX` is non-invertible. However, when we add the term `λ⋅L`, then `X^TX + λ⋅L` becomes invertible.


### Regularized Logistic Regression
We can regularize logistic regression in a similar way that we regularize linear regression. As a result, we can avoid overfitting.

### Cost Function
We can regularize this equation by adding a term to the end:

![regularized cost logistic regression function](http://chart.apis.google.com/chart?cht=tx&chl=J(%5Ctheta)%20%3D%20-%20%5Cfrac%7B1%7D%7Bm%7D%20%5Csum_%7Bi%3D1%7D%5Em%20%5Clarge%5B%20y%5E%7B(i)%7D%5C%20%5Clog%20(h_%5Ctheta%20(x%5E%7B(i)%7D))%20%2B%20(1%20-%20y%5E%7B(i)%7D)%5C%20%5Clog%20(1%20-%20h_%5Ctheta(x%5E%7B(i)%7D))%5Clarge%5D%20%2B%20%5Cfrac%7B%5Clambda%7D%7B2m%7D%5Csum_%7Bj%3D1%7D%5En%20%5Ctheta_j%5E2)


```tex
J(\theta) = - \frac{1}{m} \sum_{i=1}^m \large[ y^{(i)}\ \log (h_\theta (x^{(i)})) + (1 - y^{(i)})\ \log (1 - h_\theta(x^{(i)}))\large] + \frac{\lambda}{2m}\sum_{j=1}^n \theta_j^2
```

The second sum, means to explicitly exclude the bias term, this sum explicitly skips `θ0`, by running from `1` to `n`, skipping `0`. Thus, when computing the equation we should continuously update the two following equations:

![Regularized Gradient Descent](http://latex.codecogs.com/png.latex?%5Cdpi%7B0%7D%20%5Cbg_white%20%5Cbegin%7Balign*%7D%20%26%20%5Ctext%7BRepeat%7D%5C%20%5Clbrace%20%5Cnewline%20%26%20%5C%20%5C%20%5C%20%5C%20%5Ctheta_0%20%3A%3D%20%5Ctheta_0%20-%20%5Calpha%5C%20%5Cfrac%7B1%7D%7Bm%7D%5C%20%5Csum_%7Bi%3D1%7D%5Em%20(h_%5Ctheta(x%5E%7B(i)%7D)%20-%20y%5E%7B(i)%7D)x_0%5E%7B(i)%7D%20%5Cnewline%20%26%20%5C%20%5C%20%5C%20%5C%20%5Ctheta_j%20%3A%3D%20%5Ctheta_j%20-%20%5Calpha%5C%20%5Cleft%5B%20%5Cleft(%20%5Cfrac%7B1%7D%7Bm%7D%5C%20%5Csum_%7Bi%3D1%7D%5Em%20(h_%5Ctheta(x%5E%7B(i)%7D)%20-%20y%5E%7B(i)%7D)x_j%5E%7B(i)%7D%20%5Cright)%20%2B%20%5Cfrac%7B%5Clambda%7D%7Bm%7D%5Ctheta_j%20%5Cright%5D%20%26%20%5Crbrace%20%5Cend%7Balign*%7D)

```tex
\begin{align*} & \text{Repeat}\ \lbrace \newline & \ \ \ \ \theta_0 := \theta_0 - \alpha\ \frac{1}{m}\ \sum_{i=1}^m (h_\theta(x^{(i)}) - y^{(i)})x_0^{(i)} \newline & \ \ \ \ \theta_j := \theta_j - \alpha\ \left[ \left( \frac{1}{m}\ \sum_{i=1}^m (h_\theta(x^{(i)}) - y^{(i)})x_j^{(i)} \right) + \frac{\lambda}{m}\theta_j \right] &\ \ \ \ \ \ \ \ \ \ j \in \lbrace 1,2...n\rbrace\newline & \rbrace \end{align*}
```


## Neural Networks

Neurons are computational units that take inputs (dendrites) as electrical inputs (called "spikes") that are channeled to outputs (axons). In our model, our dendrites are like the input features `x1...xn`, and the output is the result of our hypothesis function. 

In this model our `x0` input node is sometimes called the "bias unit." It is always equal to 1. In neural networks, we use the same logistic function as in classification, yet it is sometimes called the sigmoid (logistic) activation function. Our Theta parameters are sometimes called weights.

```
[x0; x1; x2] => [  ] => h_/theta(x)
```

- Input nodes (layer 1), also known as the "input layer", go into another node (layer 2), which finally outputs the hypothesis function, known as the "output layer").
- Intermediate layers of nodes between the input and output layers called the "hidden layers."
- We label the intermediate or hidden layer nodes `a^2_0...a^2_n`, and call the activation units.

![activation of unit i in layer j](http://chart.apis.google.com/chart?cht=tx&chl=a_i%5E%7B(j)%7D%20%3D%20%5Ctext%7B%22activation%22%20of%20unit%20%24i%24%20in%20layer%20%24j%24%7D)

![matrix of weights controlling function mapping from j to layer j+1](http://chart.apis.google.com/chart?cht=tx&chl=%20%5CTheta%5E%7B(j)%7D%20%3D%20%5Ctext%7Bmatrix%20of%20weights%20controlling%20function%20mapping%20from%20layer%20%24j%24%20to%20layer%20%24j%2B1)

```tex
\begin{align*}& a_i^{(j)} = \text{"activation" of unit $i$ in layer $j$} \newline& \Theta^{(j)} = \text{matrix of weights controlling function mapping from layer $j$ to layer $j+1$}\end{align*}
```

The values for each of the "activation" nodes is obtained as follows:

```
[x0; x1; x2; x3] => [a^(2)_1; a^(2)_2; a^(2)_3] => h_/theta(x)
```

![a^(2)_1](http://chart.apis.google.com/chart?cht=tx&chl=a_1%5E%7B(2)%7D%20%3D%20g(%5CTheta_%7B10%7D%5E%7B(1)%7Dx_0%20%2B%20%5CTheta_%7B11%7D%5E%7B(1)%7Dx_1%20%2B%20%5CTheta_%7B12%7D%5E%7B(1)%7Dx_2%20%2B%20%5CTheta_%7B13%7D%5E%7B(1)%7Dx_3))

![a^(2)_2](http://chart.apis.google.com/chart?cht=tx&chl=%20a_2%5E%7B(2)%7D%20%3D%20g(%5CTheta_%7B20%7D%5E%7B(1)%7Dx_0%20%2B%20%5CTheta_%7B21%7D%5E%7B(1)%7Dx_1%20%2B%20%5CTheta_%7B22%7D%5E%7B(1)%7Dx_2%20%2B%20%5CTheta_%7B23%7D%5E%7B(1)%7Dx_3))

![a^(2)_3](http://chart.apis.google.com/chart?cht=tx&chl=%20a_3%5E%7B(2)%7D%20%3D%20g(%5CTheta_%7B30%7D%5E%7B(1)%7Dx_0%20%2B%20%5CTheta_%7B31%7D%5E%7B(1)%7Dx_1%20%2B%20%5CTheta_%7B32%7D%5E%7B(1)%7Dx_2%20%2B%20%5CTheta_%7B33%7D%5E%7B(1)%7Dx_3)%20)

![h/Theta(x)](http://chart.apis.google.com/chart?cht=tx&chl=%20h_%5CTheta(x)%20%3D%20a_1%5E%7B(3)%7D%20%3D%20g(%5CTheta_%7B10%7D%5E%7B(2)%7Da_0%5E%7B(2)%7D%20%2B%20%5CTheta_%7B11%7D%5E%7B(2)%7Da_1%5E%7B(2)%7D%20%2B%20%5CTheta_%7B12%7D%5E%7B(2)%7Da_2%5E%7B(2)%7D%20%2B%20%5CTheta_%7B13%7D%5E%7B(2)%7Da_3%5E%7B(2)%7D)%20)

```tex
\begin{align*} a_1^{(2)} = g(\Theta_{10}^{(1)}x_0 + \Theta_{11}^{(1)}x_1 + \Theta_{12}^{(1)}x_2 + \Theta_{13}^{(1)}x_3) \newline a_2^{(2)} = g(\Theta_{20}^{(1)}x_0 + \Theta_{21}^{(1)}x_1 + \Theta_{22}^{(1)}x_2 + \Theta_{23}^{(1)}x_3) \newline a_3^{(2)} = g(\Theta_{30}^{(1)}x_0 + \Theta_{31}^{(1)}x_1 + \Theta_{32}^{(1)}x_2 + \Theta_{33}^{(1)}x_3) \newline h_\Theta(x) = a_1^{(3)} = g(\Theta_{10}^{(2)}a_0^{(2)} + \Theta_{11}^{(2)}a_1^{(2)} + \Theta_{12}^{(2)}a_2^{(2)} + \Theta_{13}^{(2)}a_3^{(2)}) \newline \end{align*}
```

- We compute our activation nodes by using a 3×4 matrix of parameters.
- We apply each row of the parameters to our inputs to obtain the value for one activation node.
- Our hypothesis output is the logistic function applied to the sum of the values of our activation nodes, which have been multiplied by yet another parameter matrix `Θ(2)` containing the weights for our second layer of nodes.
- Each layer gets its own matrix of weights, `Θ(j)`.

![dimensions of these matrices of wegihts](http://chart.apis.google.com/chart?cht=tx&chl=%5Ctext%7BIf%20network%20has%20%24s_j%24%20units%20in%20layer%20%24j%24%20and%20%24s_%7Bj%2B1%7D%24%20units%20in%20layer%20%24j%2B1%24%2C%20then%20%24%5CTheta%5E%7B(j)%7D%24%20will%20be%20of%20dimension%20%24s_%7Bj%2B1%7D%20%5Ctimes%20(s_j%20%2B%201)%24.%7D)

```tex
\text{If network has $s_j$ units in layer $j$ and $s_{j+1}$ units in layer $j+1$, then $\Theta^{(j)}$ will be of dimension $s_{j+1} \times (s_j + 1)$.}
```

The +1 comes from the addition in `Θ(j)` of the "bias nodes," `x0` and `Θ(j)0`. In other words the output nodes will not include the bias nodes.

> Example: If layer 1 has 2 input nodes and layer 2 has 4 activation nodes. Dimension of `Θ(1)` is going to be `4×3` where `sj=2` and `sj+1=4`, so `sj+1×(sj+1)=4×3`.


Vectorized implementation of the above functions.

- We're going to define a new variable `z_k^{(j)}` that encompasses the parameters inside our `g` function.

```tex
\begin{align*}a_1^{(2)} = g(z_1^{(2)}) \newline a_2^{(2)} = g(z_2^{(2)}) \newline a_3^{(2)} = g(z_3^{(2)}) \newline \end{align*}
```

For layer `j=2` and node `k`, the variable `z` will be:

![zk](http://chart.apis.google.com/chart?cht=tx&chl=z_k%5E%7B(2)%7D%20%3D%20%5CTheta_%7Bk%2C0%7D%5E%7B(1)%7Dx_0%20%2B%20%5CTheta_%7Bk%2C1%7D%5E%7B(1)%7Dx_1%20%2B%20%5Ccdots%20%2B%20%5CTheta_%7Bk%2Cn%7D%5E%7B(1)%7Dx_n)

```tex
z_k^{(2)} = \Theta_{k,0}^{(1)}x_0 + \Theta_{k,1}^{(1)}x_1 + \cdots + \Theta_{k,n}^{(1)}x_n
```

Setting `x=a(1),` we can rewrite the equation as:

![zj](http://chart.apis.google.com/chart?cht=tx&chl=z%5E%7B(j)%7D%20%3D%20%5CTheta%5E%7B(j-1)%7Da%5E%7B(j-1)%7D)

```tex
z^{(j)} = \Theta^{(j-1)}a^{(j-1)}
```

- We are multiplying our matrix `Θ(j−1)` with dimensions `sj×(n+1)` (where `sj` is the number of our activation nodes)
- By our vector `a(j−1)` with height `(n+1)` 
- This gives us our vector `z(j)` with height `sj`

Now we can get a vector of our activation nodes for layer j as follows. Where our function `g` can be applied element-wise to our vector `z(j)`.

![vector of activation nodes for layer j](http://chart.apis.google.com/chart?cht=tx&chl=a%5E%7B(j)%7D%20%3D%20g(z%5E%7B(j)%7D))

```tex
a^{(j)} = g(z^{(j)})
```

- Add a bias unit (equal to 1) to layer `j` after we have computed `a(j)`.
- This will be element `a(j)0` and will be equal to 1.
- To compute our final hypothesis, first compute another z vector

![z vector](http://chart.apis.google.com/chart?cht=tx&chl=z%5E%7B(j%2B1)%7D%20%3D%20%5CTheta%5E%7B(j)%7Da%5E%7B(j)%7D)

```tex
z^{(j+1)} = \Theta^{(j)}a^{(j)}
```

- We get this final `z` vector by multiplying the next theta matrix after `Θ(j−1)` with the values of all the activation nodes we just got. 
- This last theta matrix `Θ(j)` will have only one row which is multiplied by one column `a(j)` so that our result is a single number.
- We then get our final result with:

![h theta](http://chart.apis.google.com/chart?cht=tx&chl=h_%5CTheta(x)%20%3D%20a%5E%7B(j%2B1)%7D%20%3D%20g(z%5E%7B(j%2B1)%7D))

```tex
h_\Theta(x) = a^{(j+1)} = g(z^{(j+1)})
```

- In this last step, between layer `j` and layer `j+1,` we are doing exactly the same thing as we did in logistic regression.
- Adding all these intermediate layers in neural networks allows us to more elegantly produce interesting and more complex non-linear hypotheses.


## Neural Networks Cost Function

- `L` = total number of layers in the network
- `sl` = number of units (not counting bias unit) in layer `l`
- `K` = number of output units/classes

Denote `h_\Theta(x)_k` as being a hypothesis that results in the k'th output. Cost function for neural networks is going to be a generalization of the one we used for logistic regression.

![cost function](http://latex.codecogs.com/png.latex?%5Cdpi%7B0%7D%20%5Cbg_white%20J(%5CTheta)%20%3D%20-%20%5Cfrac%7B1%7D%7Bm%7D%20%5Csum_%7Bi%3D1%7D%5Em%20%5Csum_%7Bk%3D1%7D%5EK%20%5Cleft%5By%5E%7B(i)%7D_k%20%5Clog%20((h_%5CTheta%20(x%5E%7B(i)%7D))_k)%20%2B%20(1%20-%20y%5E%7B(i)%7D_k)%5Clog%20(1%20-%20(h_%5CTheta(x%5E%7B(i)%7D))_k)%5Cright%5D%20%2B%20%5Cfrac%7B%5Clambda%7D%7B2m%7D%20%5Csum_%7Bl%3D1%7D%5E%7BL-1%7D%20%5Csum_%7Bi%3D1%7D%5E%7Bs_l%7D%20%5Csum_%7Bj%3D1%7D%5E%7Bs_%7Bl%2B1%7D%7D%20(%20%5CTheta_%7Bj%2Ci%7D%5E%7B(l)%7D)%5E2)

```tex
\begin{gather*} J(\Theta) = - \frac{1}{m} \sum_{i=1}^m \sum_{k=1}^K \left[y^{(i)}_k \log ((h_\Theta (x^{(i)}))_k) + (1 - y^{(i)}_k)\log (1 - (h_\Theta(x^{(i)}))_k)\right] + \frac{\lambda}{2m}\sum_{l=1}^{L-1} \sum_{i=1}^{s_l} \sum_{j=1}^{s_{l+1}} ( \Theta_{j,i}^{(l)})^2\end{gather*}
```

We have added a few nested summations to account for our multiple output nodes. In the first part of the equation, before the square brackets, we have an additional nested summation that loops through the number of output nodes.

In the regularization part, after the square brackets, we must account for multiple theta matrices. The number of columns in our current theta matrix is equal to the number of nodes in our current layer (including the bias unit). The number of rows in our current theta matrix is equal to the number of nodes in the next layer (excluding the bias unit). As before with logistic regression, we square every term.

- the double sum simply adds up the logistic regression costs calculated for each cell in the output layer
- the triple sum simply adds up the squares of all the individual `Θ`s in the entire network.
- the `i` in the triple sum does **not** refer to training example `i`

To minimize the cost function, we need to compute `J(\Theta)`, and the derivative.


## Backpropagation Algorithm

"Backpropagation" is neural-network terminology for minimizing our cost function, just like what we were doing with gradient descent in logistic and linear regression. Our goal is to compute `\min_\Theta J(\Theta)`. That is, we want to minimize our cost function J using an optimal set of parameters in theta.

To compute the partial derivative of `J(Θ)`:

![partial derivative of j theta](http://chart.apis.google.com/chart?cht=tx&chl=%5Cfrac%7B%5Cpartial%7D%7B%5Cpartial%20%5CTheta_%7Bi%2Cj%7D%5E%7B(l)%7D%7DJ(%5CTheta))

```tex
\dfrac{\partial}{\partial \Theta_{i,j}^{(l)}}J(\Theta)
```

Given training set `{(x1, y1) ... (xm, ym)}`

- Set `\Delta^{(l)}_{i,j}` := 0 for all (l,i,j)
- For training example t = 1 to m:

1. Set `a^{(1)} := x^{(t)}`
2. Perform forward propagation to compute `a^{(l)}` for l=2,3...,L
3. Using `y^{(t)}` compute `\delta^{(L)} = a^{(L)} - y^{(t)}`

Where `L` is our total number of layers and `a^{(L)}` is the vector of outputs of the activation units for the last layer. So our "error values" for the last layer are simply the differences of our actual results in the last layer and the correct outputs in y. To get the delta values of the layers before the last layer, we can use an equation that steps us back from right to left:

4. Compute `\delta^{(L-1)}, \delta^{(L-2)},\dots,\delta^{(2)}`, using:

![delta l](http://chart.apis.google.com/chart?cht=tx&chl=%5Cdelta%5E%7B(l)%7D%20%3D%20((%5CTheta%5E%7B(l)%7D)%5ET%20%5Cdelta%5E%7B(l%2B1)%7D)%5C%20.*%5C%20a%5E%7B(l)%7D%5C%20.*%5C%20(1%20-%20a%5E%7B(l)%7D))

```tex
\delta^{(l)} = ((\Theta^{(l)})^T \delta^{(l+1)})\ .*\ a^{(l)}\ .*\ (1 - a^{(l)})
```

The delta values of layer `l` are calculated by multiplying the delta values in the next layer with the theta matrix of layer `l`. We then element-wise multiply that with a function called `g'`, or g-prime, which is the derivative of the activation function `g` evaluated with the input values given by `z^{(l)}`

The g-prime derivative terms can also be written out as:

![g prime](http://chart.apis.google.com/chart?cht=tx&chl=g'(z%5E%7B(l)%7D)%20%3D%20a%5E%7B(l)%7D%5C%20.*%5C%20(1%20-%20a%5E%7B(l)%7D))

```tex
g'(z^{(l)}) = a^{(l)}\ .*\ (1 - a^{(l)})
```

Combining individual deltas into Delta:

![Delta](  http://chart.apis.google.com/chart?cht=tx&chl=%5CDelta%5E%7B(l)%7D_%7Bi%2Cj%7D%20%3A%3D%20%5CDelta%5E%7B(l)%7D_%7Bi%2Cj%7D%20%2B%20a_j%5E%7B(l)%7D%20%5Cdelta_i%5E%7B(l%2B1)%7D)

```tex
\Delta^{(l)}_{i,j} := \Delta^{(l)}_{i,j} + a_j^{(l)} \delta_i^{(l+1)}
```

or with vectorization:

![Vectorized Delta](http://chart.apis.google.com/chart?cht=tx&chl=%5CDelta%5E%7B(l)%7D%20%3A%3D%20%5CDelta%5E%7B(l)%7D%20%2B%20%5Cdelta%5E%7B(l%2B1)%7D(a%5E%7B(l)%7D)%5ET)

```tex
\Delta^{(l)} := \Delta^{(l)} + \delta^{(l+1)}(a^{(l)})^T
```

Update the new Delta matrix:

![](http://chart.apis.google.com/chart?cht=tx&chl=D%5E%7B(l)%7D_%7Bi%2Cj%7D%20%3A%3D%20%5Cfrac%7B1%7D%7Bm%7D%5Cleft(%5CDelta%5E%7B(l)%7D_%7Bi%2Cj%7D%20%2B%20%5Clambda%5CTheta%5E%7B(l)%7D_%7Bi%2Cj%7D%5Cright)), if j != 0

```tex
D^{(l)}_{i,j} := \dfrac{1}{m}\left(\Delta^{(l)}_{i,j} + \lambda\Theta^{(l)}_{i,j}\right)
```

![](http://chart.apis.google.com/chart?cht=tx&chl=D%5E%7B(l)%7D_%7Bi%2Cj%7D%20%3A%3D%20%5Cfrac%7B1%7D%7Bm%7D%5CDelta%5E%7B(l)%7D_%7Bi%2Cj%7D), if j=0

```tex
D^{(l)}_{i,j} := \dfrac{1}{m}\Delta^{(l)}_{i,j}
```

The capital-delta matrix D is used as an "accumulator" to add up our values as we go along and eventually compute our partial derivative

![derivative](http://chart.apis.google.com/chart?cht=tx&chl=%5Cfrac%20%5Cpartial%20%7B%5Cpartial%20%5CTheta_%7Bij%7D%5E%7B(l)%7D%7D%20J(%5CTheta)%20%3D%20D_%7Bij%7D%5E%7B(l)%7D)

```tex
\frac \partial {\partial \Theta_{ij}^{(l)}} J(\Theta) = D_{ij}^{(l)}
```







### Resources

- [Deep Learning](https://www.deeplearning.ai/)
- [Machine Learning Stanford](https://www.coursera.org/learn/machine-learning)
- [Mahine Learning Nano Degree](https://www.udacity.com/course/machine-learning-engineer-nanodegree--nd009)
- [Super Harsh Guide to Machine Learnig](https://www.reddit.com/r/MachineLearning/comments/5z8110/d_a_super_harsh_guide_to_machine_learning/)
- [Open AI Gym](https://github.com/openai/gym)
- [Octave Docker Image](https://hub.docker.com/r/compdatasci/octave-desktop/)
- [Tex functions](https://khan.github.io/KaTeX/function-support.html#annotation)
- [Tex Formula Editor](http://atomurl.net/math/)
- [Octave Doumentation](http://www.gnu.org/software/octave/doc/interpreter/)
- [Matlab Documentation](http://www.mathworks.com/help/matlab/index.html?refresh=true&s_tid=gn_loc_drop)
