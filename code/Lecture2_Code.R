# Ryan Gallagher
# 04.14.2025

# Exploring some of the code used in the second lecture


## The Probability of Proportion is our Posterior
### Proportions of Water on the globe from our example, that is

samples = c("W", "L", "W", "W", "W", "L", "W", "L", "W")
W = sum(samples == "W") # number of W observed
L = sum(samples == "L") # number of L observed
p = c(0, 0.25, 0.50, 0.75, 1) # Possible Proportions of L given a 4 sided globe
ways = sapply(p, function(q) (q*4)^W * ((1-q) * 4)^L) # This is our function, coded
prob = ways / sum(ways)
cbind(p,ways,prob) # We're simply counts the ways that the data can occur!

###
# Grid Approximation

# define grid
## Hypothetically, these are values for the proportion of water on the globe.
## This is the grid that we use instead of considering every possible value between 0 and 1.
## The more points we have on our grid, the better our approximation.
grid_points = 20
p_grid = seq(from=0, to=1, length.out=grid_points)

# define prior
## We are using the uniform prior, meaning we assign the same initial plausibility to every value of p in our grid.
## The value 1 is arbitrary here, what matters is that they're the same.
prior = rep(1,grid_points)

## Other priors
prior = ifelse( p_grid < 0.5, 0, 1)
prior = exp( -5*abs( p_grid - 0.5))

# compute likelihood at each value in grid
## This is the likelihood of observing our data for each possible proportion of water.
## dbinom() uses binomial probability mass function. This is appropriate here because
## each globe toss is a binary outcome (W or L), and we assume the tosses are independent
## with a constant prob of water.
likelihood = dbinom(6, size = 9, prob = p_grid)

# compute product of likelihood and prior
unstd.posterior = likelihood * prior

# standardize the posterior, so it sums to 1
posterior = unstd.posterior / sum(unstd.posterior)

plot( p_grid, posterior, type="b",
      xlab = "prob of water", ylab = "posterior prob")
mtext( "20 points" )

###
# Quadratic Approximation
library(rethinking)

globe.qa = quap(
  alist(
    W ~ dbinom( W+L, p), # binomial likelihood
    p ~ dunif(0,1) # uniform prior
  ),
  data = list(W = 6, L = 3) )

# Display summary of quadratic approximation
precis( globe.qa )

# See how this matches an analytical calculation
# analytical calc
W = 6
L = 3
curve( dbeta(x, W+1, L+1), from = 0, to = 1)
# quadratic approximation
curve( dnorm(x, 0.67, 0.16), lty = 2, add=T)

###
# MCMC Globe Tossing
nsample = 1000 # 1000 draws from posterior
p = rep(NA, nsample) # 1000 empty spaces in a vector
p[1] = 0.5 # our prior, where we will start from
W = 6
L = 3

for (i in 2:nsample) {
  p_new = rnorm(1, p[i-1], 0.1)
  if (p_new < 0) p_new = abs(p_new)
  if (p_new > 1) p_new = 2-p_new
  q0 = dbinom(W, W+L, p[i-1])
  q1 = dbinom(W, W+L, p_new)
  p[i] = ifelse( runif(1) < q1/q0, p_new, p[i-1])
}

dens(p, xlim=c(0,1))
curve(dbeta(x, W+1, L+1), lty=2, add=T)
