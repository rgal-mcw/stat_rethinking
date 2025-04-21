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

## Testing
### Test Before You Est(imate)

### Code a generative simulation
sim_globe = function (p = 0.7, N = 9) { # Code our generative simulation (with defaults)
  sample(c("W", "L"), size=N, prob=c(p, 1-p), replace=T)
}
sim_globe() # Each output is a new draw of samples from our experiment
            # i.e. 9 new tosses

replicate(sim_globe(p=0.5, N=9), n=10) # Make 10 pulls



