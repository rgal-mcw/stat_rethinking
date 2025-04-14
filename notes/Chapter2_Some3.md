Ryan Gallagher (04-13-2025)

# Chapter 2 - Small Worlds and Large Worlds

These are notes from the second video lecture - [Statistical Rethinking 2023 - 02 - The Garden of Forking Data](https://www.youtube.com/watch?v=R1vcdhPBlXA&list=PLDcUM9US4XdPz-KxHM4XHt7uUVGWWVSus&index=2)

NOTE: I found the updated lecuture midway through. So the marble explanation is old, and he uses a 4-sided globe to explain the same idea in the 2023 lectures. 

### Bayesian Data Analysis

> *Count all the ways data can happen according to assumptions.* 
>
> *Assumptions with more ways to cause the data are more probable.*
>
> *Explanations with more ways to produce the sample are more plausible.*



## Garden of Forking Data

We learn about the basics of probability in the full analytical approach of counting all possible ways to draw the seen draw of marbles (either blue or white) and comparing the plausability of what the contents of the bag could be.



Ways to produce [Blue, White, Blue] if the bag contains:

[W, W, W, W] = 0 x 4 x 4 = 0

[B, W, W, W]  = 1 x 3 x 1 = 3

[B, B, W, W]   = 2 x 2 x 2 = 8

[B, B, B, W]    = 3 x 1 x 3 = 9

[B, B, B, B]     = 4 x 0 x 4 = 0



We get this just by counting how many possible ways get can get [B, W, B] given the bag.



#### **Bayesian Updating - Draw another marble from the bag**

Ways to obtain another [B] given you've chosen [B, W, B]



[W, W, W, W] = 0 x 4 x 4 = 0  | 0 x 0 = 0

[B, W, W, W]  = 1 x 3 x 1 = 3  | 3 x 1 = 3

[B, B, W, W]   = 2 x 2 x 2 = 8  | 8 x 2 = 16

[B, B, B, W]    = 3 x 1 x 3 = 9  | 9 x 3 = 27

[B, B, B, B]     = 4 x 0 x 4 = 0  | 0 x 4 = 0



*You could keep drawing data, and you'll see that one of the options draw ahead.*

( We make some assumptions here on the independce of the data & such)

We'd likely select the [B, B, B, W] configuration, but it's not overwhelmingly convincing. We could continue drawing data before claiming anything definitive.



#### Using Other Information

What if the factory said:

> "B marbles are rare, but every bag contains at least one. For everyone 1 bag that has 3 B marbles, there are 3 bags that only have one B marble."

| **Conjecture** | Prior Ways | Factory Count | New Count   |
| -------------- | ---------- | ------------- | ----------- |
| [W, W, W, W]   | 0          | 0             | 0 x 0 = 0   |
| [B, W, W, W]   | 3          | 3             | 3 x 3 = 9   |
| [B, B, W, W]   | 16         | 2             | 16 x 2 = 32 |
| [B, B, B, W]   | 27         | 1             | 27 x 1 = 27 |
| [B, B, B, B]   | 0          | 0             | 0 x 0 = 0   |

Now our interpretation shifts with this new information, but we wouldn't bet the house on just this data. 



#### Counts to Plausibility

> "Things that can happen more ways are more plausible."

| Possible Composition | *p*  | ways to produce data | Plausibility |
| -------------------- | ---- | -------------------- | ------------ |
| [W, W, W, W]         | 0    | 0                    | 0            |
| [B, W, W, W]         | 0.25 | 3                    | 0.15         |
| [B, B, W, W]         | 0.5  | 8                    | 0.40         |
| [B, B, B, W]         | 0.75 | 9                    | 0.45         |
| [B, B, B, B]         | 1    | 0                    | 0            |

*p* = the proportion of blue marbles in the bag

*plausbility* is the normalized ways to produce the data
$$
plausbility = \frac{ways}{sum(ways)}
$$

> "Plausibility is *probability*: Set of non-negative real numbers that sum to one"
>
> "Probability theory is just a set of shortcuts for counting possiblities."



## Building a Model

How to use probability to do typical statistical modeling?

1. Design the Model (data story)
   1. Tells a story of how the data is generated. Helps set-up what the model looks like. 
2. Condition on the data (update)
   1. Update our previous conjectures on the different possibilities.
3. Evaluate the model (critique)
   1. Compare to the "Large World". Does the model make any sense at all?
4. Repeat



#### Example - Tossing an Inflatable Globe

Idea: Imagine you didn't know what the proportion of water was on the earth, but you do have an inflatable globe! What if we tossed the globe a sufficient amount of times - each time recording where our right index-finger landed and recording it as Water (W) or Land (L). The more we do this, we should get an increasingly precise proportion of Water or Land on Eather. 



We toss it 10 times: **[L, W, L, L, W, W, W, L, W, W]**



Questions:

1. How should we use the sample to produce an estimate?
2. How to produce a summary of the estimate?
3. How to represent uncertainty of estimate?

**Estimates in Bayesian Inference are never points, they are distributions!**



### Workflow

1. Define generative model of the sample
2. Define a specific estimand
   1. Estimand is *the proportion of water to land covering the earth*
3. Design a statistical way to produce estimate
4. Test (3) using (1)
5. Analyze sample, summarize



#### Generative Model of the Globe

Begin conceptually: How do the variables influence one another?

p = proportion of water (estimand)

W = water observations

L = land observations

N = number of tosses



We will first think about how N influences our variables. 

​	N influences L

​	N influences W

Since the more N leads to more W and L, but W and L don't influence N. An intervention on N would be an intervention on W and L.



And p

​	p influences W

​	p influences L

If p becomes greater or smaller, then that changes the expectations on W and L



**Generative Assumptions: What do the arrows mean exactly?**

The causal influences described above can be summarized in a function. W and L are some function of p and N.
$$
W,L = f(p,N)
$$
But what is this function f()? 



**Bayesian Inference for the Globe:**

> *For each possible proportion of water on the globe,*
>
> *count all the ways the sample of tosses could happen.*

> *Proportions with more ways to produce the sample are more plausible.*

### Produce an Estimate

To simplify the problem, what if we pretended the globe had 4 sides. We could then set-up our possibilities similar to how we did the marbles:

What are the colors for the 4-sided globe?? (B == L):

| Possibility  | Observations: | B    | W    | B    | B    | B    | W    | B    | W    | B    | Count           |
| ------------ | ------------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | --------------- |
| [W, W, W, W] |               | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0^6 x 4^3 = 0   |
| [B, W, W, W] |               | 1    | 3    | 3    | 3    | 3    | 9    | 9    | 27   | 27   | 1^6 x 3^3 = 27  |
| [B, B, W, W] |               | 2    | 4    | 8    | 16   | 32   | 64   | 128  | 256  | 512  | 2^6 x 2^3 = 512 |
| [B, B, B, W] |               | 3    | 3    | 9    | 27   | 81   | 81   | 243  | 243  | 729  | 3^6 x 1^3 = 729 |
| [B, B, B, B] |               | 4    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 0    | 4^6 x 0^3 = 0   |



Ways for *p* to produce W, L
$$
W,L = (4p)^W \times (4-4p)^L
$$
This function emerges from our scientific beliefs about the sampling. This is our estimator.

### Probability

Probability: Non-negative values that sum to one

Suppose W = 20, L = 10. Then *p* = 0.5 has
$$
2^W \times 2^L = 1073741824
$$
ways to produce sample. Better to convert to probability. This is from the formula above.



| Possible Proportions (of B) | Ways to Produce the Sample | Probability of Proportion |
| --------------------------- | -------------------------- | ------------------------- |
| 0                           | 0                          | 0                         |
| 0.25                        | 27                         | 0.02                      |
| 0.5                         | 512                        | 0.40                      |
| 0.75                        | 729                        | 0.57                      |
| 1                           | 0                          | 0                         |

**The Probability of Proportion is our Posterior!**

```R
sample = c("W", "L", "W", "W", "W", "L", "W", "L", "W")
W = sum(sample == "W") # number of W observed
L = sum(sample == "L") # number of L observed
p = c(0, 0.25, 0.5, 0.75, 1) # Proportion of L
ways = sapply(p, function(q) (q*4)^W * ((1-q) * 4) ^L)
prob = ways / sum(ways)
cbind(p, ways, prob)
```

Output yields the same probability information as the table above, and we can graph the distribution of our posterior.



### Testing

> "Test Before You Est(imate)"

1. Code a generative simulation

   ```R
   sim_globe = function( p = 0.7, N=9) {
     sample(c("W", "L"), size=N, prob=c(p, 1-p) replace=T)
   }
   sim_globe() # will output samples of 10 "L" and "W" lists
   replicate(sim_globe(p=0.5, N=9), n=10) # Make 10 pulls from sample
   ```

   Good habits are:

   1. We should test the simulation on extreme settings where prob of W or L is 1. Should see what we expect
   2. For large samples, we should see the proportion of W close to p. We can observe this,

   > "If you test nothing, you miss everything!"

2. Code the Esimator

   Ways for p to produce W, L:
   $$
   W,L = (4p)^W \times (4-4p)^L
   $$
   

   ```R
   # function to compute posterior distribution
   compute_positerior = function(the_sample, poss=c(0, 0.25, 0.5, 0.75, 1.00) ){
     W = sum(the_sample == "W") # number of W observed
     L = sum(the_sample == "L") # number of L observed
     ways = sapply(poss, function(q) (q*4)^4 * ((1-q)*4)^L )
     post = ways/sum(ways)
     bars = sapply(post, function(q) make_bar(q) )
     data.frame( poss, ways, post = round(post, 3), bars)
   }
                   
   compute_posterior( sim_globe() ) # Will produce results
   ```

   1. Test the estimator when the answer is known.
   2. Explore different sampling designs.
   3. Develop intuition for sampling and estimations.

​	Doing these explorations in the sampling will build your intuition for sampling and estimation over time. It's important to mess with and explore these ideas.



### More Possibilities

Now, increase the amount of possibilities for how many sides our globe could have. We can extrapolate our thoughts to how this shape would get more defined the more sides we add (similar to how roundness emerges from adding infinitely more sides to a cube).

![image-20250414140916122](/Users/ry28926/Library/Application Support/typora-user-images/image-20250414140916122.png)

We also see our bars get shorter the more sides we add. This is because as there are more possibilities, there is less probability in each bar.



#### Infinite Possibilities

The glove is a polyhedron with infinite number of sides.

The posterior probability of any "side" p is proportional to:
$$
p^w(1-p)^L
$$
(We derived this earlier)

The only trick is normalizing to probability. After a little calculus:
$$
Posterior.Probability.of.p = \frac{(W + L + 1)!}{W!L!}p^W(1-p)^L
$$
Which is the "Beta" distribution. 

The fraction is a *normalizing constant*.

The product at the end is the *relative number of ways to observe the sample*.



### Ten Tosses of the Globe (Apply Testing)

We start with a "flat prior" and observe our distribution "updating" as we consider more data over 10 tosses. Each function is simply:
$$
p^W(1-p)^L
$$
For how many W or L are in the data.

![image-20250414141726413](/Users/ry28926/Library/Application Support/typora-user-images/image-20250414141726413.png)



##### Some Lessons from this

* **There is no minimum sample size in Bayesian Inference**. Every sample size gives an estimate, and that estimate get's updated per the next data-point and so-on. **The minimum sample size is 1!**

  * The minimum of 1 is not very informative, but it's part of the power of this. The n=1 is accurately representing the reletive confidence (or plausibility) we should assign for this much data. 

* The shape of the posterior distribution **embodies all the information** that the sample has about the generative process (the proportion of water, in this case). 

  * This is great, because when we observe more data we can just update the posterior with new information instead of going back to the full dataset.

* There are no point estimates in Bayesian Inference. **The estimate is the posterior distribution (the whole thing!)**.

  * The "mode" or "mean" could be tempting to report, but neither of those points are specifal as a point estimate. There is a lot of probability on points other than just the mean or mode!

  * >  "Always use the entire distribution!"

* **No one true interval in Bayesian Inference**

  * Intervals communicate the shape of the posterior when we can't give the entire distribution. 



### Analyze Sample, and summarize

**From Posterior to Prediction:**

What you do with your posterior is up to your research question & purpose. 



Implications of the model depend upon the **entire** posterior. 

**Must** average any inference over entire posterior. We can do this via calculus, or by *sampling over the posterior!*



```R
post_samples = rbeta(1e3, 6+1, 3+1) # Draw 1000 samples (with Beta dist arguments representing our data)

dens(post_samples, lwd=4, col=2, xlab="proportion water", adj=0.1) #these are our narrowly estimated density from what we've sampled. 
curve(dbeta(x, 6+1, 3+1), add=T, lty=2, lwd=3) #this is our beta dist
```



##### Posterior Predictive Distribution

Posterior Preditiction is a prediction for a future experiment or observation made from your existing estimate. 

We want to say:

> Given what we've learned about the globe so far, what would happen if we took more samples from it? What would we bet? How many W's would we expect to see in the next 10 tosses of the globe?



Here, we could randomly sample proportions of water from our posterior distribution. For each of the samples from the posterior distribution, we could compute the "Sampling Distribution" or "Predicted Distribution" for possible experiments given the randomly sampled proportion of water. With this new proportion, we "toss the globe" 9 more times, and we count the number of water samples from this simulated experiment. Then, we take a sample from the "Predictive Distribution", where we add it to the "Posterior Predictive Distribution". This is a flatter distribution than the previous ones because it contains samples from **all** the predictive distributions. It contains samples in proportion to how plausible they are and it contains samples from distributions that are more plausible. This is a Monte-Carlo sampling method that is the "easy way" of doing the integral calculus to get the same info about the Posterior Predictive distribution. 



![image-20250414145717047](/Users/ry28926/Library/Application Support/typora-user-images/image-20250414145717047.png)



Code to see this is:

```R
post_samples = rbeta(1e4, 6+1, 3+1)
pred_post = sapply( post_samples, function(p) sum(sim_globe(p,10)=="W"))
tab_post = table(pred_post)
for (i in 0:10) line(c(i,i),c(0,tab_post[i+1]),lwd=4,col=4)
```



##### Sampling is Fun & Easy

Sample from posterior -> Compute desired quanitity for each sample -> profit

Easier than integrals

Turns a **calculus problem** into a **data summary problem**

MCMC is good.



