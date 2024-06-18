//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;     // N es un entero no negativo
  vector[N] y;          // y es un vector de longitud N de números reales
  vector[N] x;          // x es un vector de longitud N de números reales
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real beta0;  
  real beta1;  
  real<lower=0> sigma;
  real<lower=0> nuMinusOne;
} 

transformed parameters{
  real<lower=0> nu;
  nu = nuMinusOne + 1;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model { 
  y ~ student_t(nu, beta0 + beta1 * x, sigma);
  beta0 ~ normal(0, 100);
  beta1 ~ normal(0, 4);
  sigma ~ uniform(6.0 / 100.0, 6.0 * 100.0);
  nuMinusOne ~ exponential(1/29.0);
}

