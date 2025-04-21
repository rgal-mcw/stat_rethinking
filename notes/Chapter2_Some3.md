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

| **Conjecture** | Ways to Produce "B" | Prior Counts | New Counts |
| -------------- | ------------------- | ------------ | ---------- |
| [W, W, W, W]   | 0                   | 0            | 0 x 0 = 0  |
| [B, W, W, W]   | 1                   | 3            | 3 x 1 = 3  |
| [B, B, W, W]   | 2                   | 8            | 8 x 2 = 16 |
| [B, B, B, W]   | 3                   | 9            | 9 x 3 = 27 |
| B, B, B, B]    | 4                   | 0            | 0 x 4 = 0  |

*You could keep drawing data and mutiplying our prior to get new interpretation of the counts / possibilities to see the outcome. Each "New Counts" would become the prior of your next draw.*

( We make some assumptions here on the independece of the data & such)

> "This updating approach amounts to nothing more than asserting that:
>
> (1) when we have previous information suggesting there are $W_{prior}$ ways for a conjecture to produce a previous observation $D_{prior}$ and
>
> (2) we acquire new observations $D_{new}$ that the same conjecture can produce in $W_{new}$ ways, then
>
> (3) the number of ways the conjecture can account for both $D_{prior}$ as well as $D_{new}$ is just the product of $W_{prior} \times W_{new}$.
>
> For example, in the table above the conjecture [B, B, W, W] has $W_{prior} = 8$ ways to produce $D_{prior}$ = [B, W, B]. It also has $W_{new} =2$ ways to produce the new observation $D_{new} = B$. So there are $8 \times 2 = 16$ ways for the conjecture to produce both $D_{prior}$ and $D_{new}$."



We'd likely select the [B, B, B, W] configuration, but it's not overwhelmingly convincing. We could continue drawing data before claiming anything definitive.



#### Using Other Information

What if the factory said:

> "B marbles are rare, but every bag contains at least one. For everyone 1 bag that has 3 B marbles, there are 3 bags that only have one B marble."

| **Conjecture** | Prior Counts | Ways to Produce "B" | New Count   |
| -------------- | ------------ | ------------------- | ----------- |
| [W, W, W, W]   | 0            | 0                   | 0 x 0 = 0   |
| [B, W, W, W]   | 3            | 3                   | 3 x 3 = 9   |
| [B, B, W, W]   | 16           | 2                   | 16 x 2 = 32 |
| [B, B, B, W]   | 27           | 1                   | 27 x 1 = 27 |
| [B, B, B, B]   | 0            | 0                   | 0 x 0 = 0   |

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



We can get these plausibilities via:

```R
ways = c(0, 3, 8, 9, 0)
way / sum(ways) # our plausibilities as a vector
```

These plausibilities are *probabilities* - they are non-negative (zero or positive) real numbers that sum to one.



Each piece of the calculation has a direct partner in applied probability theory. These partners have stereotyped names, so it's worth learning them, as we will see them again and again.

* A conjectured proportion of blue marbles, $p$, is usually called a $\texttt{Parameter}$ value. It's just a way of indexing possible explanations of the data.
* The relative number of ways that a value $p$ can produce the data is usually called a $\texttt{Likelihood}$. It is derived by enumerating all the possible dat asequences that could have happened and then eliminating those sequences inconsistent with the data. Think Garden of Forking Data.
* The prior plausibility of any specific $p$ is usually called the $\texttt{Prior Probability}$. 
* The new, updated plausibility of any specific $p$ is usually called the $\texttt{Posterior Probability}$. 



(Back to marbel example rq)

**Plausability of [B, W, W, W] after seeing [B,W,B] ** 

$\propto$

**Ways [B,W,W,W] can produce [B,W,W] ** $\times$ **Prior Plausibility [B, W, W, W]**



Where $\propto$ means *proportional to*. We want to compare the plausbility of each possible bag composition. So it'll be helpful to define $p$ as the proportion of marbles that are blue. 

For [B, W, W, W], $p$  = $\frac{1}{4}$ = 0.25. Also, let $D_{new}$ = [B,W,B]. Now we can write

**Plausibility of $p$ after $D_{new}$**  

$\propto$

**Ways $p$ can produce $D_{new}$** $\times$ **Prior Plausibility of $p$**



This just means that for any value $p$ can take, we judge the plausibility of that value $p$ as proportional to the number of ways it can get through the garden of forking data. This expression just summarizes the calculations we did in the first table.



We can then get the probabilities b standardizing the plausibility so that the sums of the the plausibilities for all possible conjectures will be one. 



![image-20250421131921361](/Users/ry28926/Library/Application Support/typora-user-images/image-20250421131921361.png)





## Building a Model

How to use probability to do typical statistical modeling?

1. Design the Model (data story)
   1. Tells a story of how the data is generated. Helps set-up what the model looks like. 
   1. This story may be *descriptive*, specifying associations that can be used to predict outcomes, given observations.
   1. It may be *causal*, a theory of how some events produce other events.
2. Condition on the data (update)
   1. Update our previous conjectures on the different possibilities.
      1. Each possible proportion may be more or less plausible, given the evidence.
   2. A Bayesian model begins with one set of plausibilities assigned to each of these possibilities. These are the prior plausibilities. This is Bayesian Updating.
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



##### Data Story:

1. The true proportion of water covering the globe is $p$.
2. A single toss of the glove has a probability $p$ of producing a water (W) observations. It has a probability $1-p$ of producing a land (L) observation.
3. Each toss of the globe is independent of the others.

##### Bayesian Updating:

1. For the sake of example only, let's program our Bayesian machine to initially assign the same plausibility to every proportion of water, every value of $p$. 
   1. In our figure, we see that after the first "W" toss, the model updates the plausbilities to a solid line. The plausibility of $p = 0$ has now fallen to exactly 0 (impossible). This is because we know there is *some* water. 
   2. Likewise, the plausibility of $p > 0.5$ has increased. This is because there is not yet any evidence that there is land on the globe, so the initial plausibilities are modified to be consistent with this.
   3. In the remaining plots, the additional samples from the globe are introduced to the model, one at a time. Each dashed curve is just the solid curve from the prevbious plot, moving left to right and top to bottom. Ever time a "W" is seen, the peak of the plausibility curve moves to the right, towards larger values of $p$. 
   4. Notice that every updated set of plausibilities becomes the initial plausibilties for the next observation.



![image-20250414141726413](/Users/ry28926/Library/Application Support/typora-user-images/image-20250414141726413.png)

##### Evaluate:

1. The Bayesian model learns in a way that is demonstrably optimal, provided that the real, large world is accurately described by the model. Though, the model's certainty is no guarantee that the model is a good one. 
   1. As the amount of data increases, the globe tossing model will grow increasingly sure of the proportion of water. This means that the curves in the figure will become increasingly narrow and tall, restricting plausible values within a very narrow range.
   2. But models of all sorts - Bayesian or not - can be very confident about an inference, even when the model is seriously misleading. This is because the inferences are conditional on the model.
2. It is important to supervise and critique your model's work. Consider again the fact that the updating in the previous section works in any order of data arrival.
   1. We could shuffle the order of the observations, as long as six W's and three L's remain, and still end up with the same final plausibilitity curve. This is only true, however, because the model assumes that orde is irrelevant to inference. 
3. The objective is to check the model's adequacy for some purpose. This usually means asking and answering additional questions, beyond those that originally contructed the model. 



## Components of the Model

Now that we've seen how the Bayesian model behaves, it's time to open up the machine and learn how it works. Consider three different kinds of things we counted in the previous sections:

1. The number of ways each conjecture could produce an observation
2. The accumulated number of ways each conjecture could produce the entire data
3. The initial plausibility of each conjectured cause of the data.

Each of these things has a direct analog in conventional probability theory. 

In this section, we will meet these components in some detail and see how each relates to the counting we did earlier in the chapter. 



#### Variables

The first variable is our target of inference $p$, the proportion of water on the globe. This variable cannot be observed. Unobserved variables are usually called $\texttt{Parameters}$. But while $p$ itself is unobserved, we can infer it from other variables.

The other variables are the observed variables, the counts of water and land. Call the count of water $W$ and the count of land $L$. The sum of these two variables is the number of globe tosses: $N = W + L$ .



#### Definitions

Once we have the variables listed, we have to define each of them. In defining each, we build a model that relates the variables to one another. 

The goal is to count all the ways the data could arise, given the assumptions. This means, as in the globe tossing model, that for each possible value of the unobserved variables, such as $p$, we need to define the relative number of ways - the probability - that the values of each observed variable could arise. And then for each unobserved variable, we need to define the prior plausibility of each value it could take. 



##### *Observed Variables*

For the count of water $W$ and land $L$, we define how plausibile any combination of $W$ and $L$ would be, for a specific value of $p$ .This is just like the marble counting we did earlier in this chapter. Each specific value of $p$ corresponds to a specific plausibility of the data. 

So that we don't have to literally count, we can use a mathematical function that tells us the right plausibility. In conventional statistics, a distribution function assigned to an observed variable is usualled called a $\texttt{Likelihood}$. That term has a special meaning in non-Bayesian statistics, however. But when someone says "Likelihood", they will usually mean a distribution function assigned to an observed variable. 

In the case of the globe tossing model, the function we need can be derived directly from the data story. Begin by nominating all of the possible events. There are two: *water (W)* and *land (L)*. There are no other events. When we observe a sample of $W's$ and $L's$ of length $N$, we need to say how likely that exact sample is, out of the universe of potential samples of the same length. 

In this case, once we add our assumptions that (1) every toss is independent of the other tosses and (2) the probability of $W$ is the same on every toss, probability theory provides a unique answer, known as the *binomial distribution*. This is the common "coin tossing" distribution. And so the probability of observing $W$ waters and $L$ lands, with a probability $p$ of water on each toss, is:
$$
Pr(W, L | p) = \frac{(W+L)!}{W!L!}p^W(1-p)^L
$$
Which reads:

> *The counts of "water" W and "land" L are distributed binomially, with probability p of "water" on each toss*.

And the binomial distribution formula is built into R, so we can easily compute this likelihood of the data - six $W's$ in nine tosses - any any value of $p$ with:

```R
dbinom(6, size=9, prob=0.5) #=0.1640625
```

That number is the relative number of ways to get six water, holding $p$ at 0.5 and $N = W+L$ at nine. So it does the job of counting relative number of paths through the garden. Change the $0.5$ to any other value, to see how the value changes. 



##### Unobserved Variables

The distributions we assign to the observed variables typically have their own variables. In the binomial above, the is $p$, the probability of sampling water. Since $p$ is not observed, we usually call it a $\texttt{Parameter}$. Even though we cannot observe $p$, we still have to define it. 

In statistical modeling, many of the most common questions we ask about data are answered directly by parameters:

* What is the average difference between treatment groups?
* How strong is the association between treatment and outcome?
* Does the effect of the treatment depend upon a covariate?
* How much variation is there among groups?

**For every parameter you intend your Bayesian machine to consider, you must provide a distribution of prior plausibility, its $\texttt{Prior}$.** A Bayesian machine must have an initial plausibility assignment for each possible value of the parameter, and these initial assignments do useful work. Back in the previous figure, we saw the machine did it's learning one piece of data at a time. Each estimate becomes the prior for the next step. But this doesn't resolve the problem of providing a prior, because at the dawn of time, when $N=0$ , the machine still had an initial state of information for the parameter $p$ : a flat line specifying equal plausibility for every possible value. 

So where do priors come from? They are both engineering assumptions, chosen to help the machine learn, and scientific assumptions, chosen to reflect what we know about a phenomenon, The flat prior is very common, but it is hardly ever the best prior. 



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
2^{20} \times 2^{10} = 1073741824
$$
ways to produce sample. This is from the formula above. 



Better to convert to probability. It's hard to use raw counts. First, we only care about the relative values (i.e. counts 3, 8, and 9 could just as easily be 30, 80, and 90 and the meaning would be the same). Second, as the amount of data grows, the counts will very quickly grow large (from Equation 4). Explicitely counting isn't practical. 



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



### Nine Tosses of the Globe (Apply Testing)

We start with a "flat prior" and observe our distribution "updating" as we consider more data over 9 tosses. Each function is simply:
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



