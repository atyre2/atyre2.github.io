--- 
layout: post 
title:  Model selection and the art of evidence I 
published: true 
tags: [statistics, model selection] 
---


Science is a reliable way of gaining knowledge about the nature of reality. Ecology in particular is knowledge about the distribution and abundance of organisms. Over the decades that ecology has been practiced as a distinct science there have been at least 2 broad paradigm shifts in how evidence for or against a particular view of reality is accumulated. The latest shift involved the use of Information Theoretic methods of evaluating multiple hypotheses with a given set of data. 

Breiman (2001) introduced the idea that there are two cultures in statistics - hypothesis testing and prediction. In hypothesis testing, knowledge is built by identifying the simplest hypothesis consistent with a given set of data. This culture focuses on identifying key variables driving a particular response. In contrast, the prediction culture simply aims to predict a response; which variables are important is usually of secondary importance. These two cultures use different statistical tools. Null hypothesis testing is the domain of hypothesis testing, while prediction focuses on measures of predictive performance, especially the ability to predict independent data points. 

Data in science arise from two broad forms - manipulative experiments and observation. The former provides the strongest evidence for causation, because one or two variables are manipulated while holding others constant, or at least randomizing variation in all other variables across the experimental units. In contrast, observation of a response across a range of observational units provides much less evidence in favor of causation, because it is always possible that two observed variables are simply correlated because they both share an unmeasured causal variable. Many sciences, including much of ecology, are forced to rely on observation because the units of interest (e.g. ecosystems, species distributions, animal populations) are simply too extensive in space and/or time to manipulate. 

Combining the two sources of data with the two cultures of statistics provides us with [a 2 way table](#typology). The particular focus of this paper is the top right cell - observational data with the goal of testing hypotheses. Confusion over the proper location in this table results in the inappropriate application of statistical techniques, flawed model selection procedures, and ultimately, compromised scientific inference. 
<!-- html table generated in R 3.3.0 by xtable 1.7-4 package -->
<!-- Wed May 25 09:20:47 2016 -->
<table border=1>
<caption align="top"> The combination of data source and inferential goal yields a 2 x 2 table of commonly used methods. The cell marked with * isn't typically observed. </caption>
  <tr> <td>   </td> <td> Prediction </td> <td> Hypothesis Testing </td> </tr>
   <tr> <td> Observation </td> <td> Cross Validation </td> <td> AIC </td> </tr>
  <tr> <td> Experiment </td> <td> * </td> <td> Backwards Selection </td> </tr>
   </table>

## The easy model selection problem
Imagine a situation with a single, continuous response variable and 5 continuous, independent predictor variables. The predictor variables can be scaled and centered, so can be assumed to be normally distributed with a mean of zero and a variance of one. The relationship between the predictors and the response is always linear and there are no interactions. In this circumstance I can always rank the predictor variables from greatest effect to least effect, and I will number the predictor variables from strongest to weakest. I scale the "effect size" of each predictor relative to the residual error in the model $\sigma_{error}$, for example $\beta_1 = c_1\sigma_{error}$, where $\beta_i$ is the coefficient of the $i^{th}$ predictor. If the response has also been centered and scaled, then the intercept $\beta_0$ will be zero and the residual error will be one. With these definitions, a "scenario" consists only of a vector of $c_i$'s. The baseline scenario will be , which means the true model consists of only the first four variables.

There are $m=32$ ($2^5=32$) possible models with 5 linear effect variables. In hypothesis testing mode, the goal is to accurately identify the true model out of the set of possible models. In fact, using AIC does not require that the "true" model is in the set of possible models, but this is the easy problem, after all. Measuring the quality of a model selection procedure could be done is several ways. The weight of the true model is one; the frequency with which the true model is the AIC best model is another. Both of these only work if the true model is in the set of possible models. Another metric is model diversity
$$
H_{model}=\sum_{i=1}^m -w_i log(w_i)
$$
which is just Shannon-Wiener information calculated using the weights of the models. $e^{H_{model}}$ will have a minimum value of 1 and a maximum value of $log(m)$. This measures the degree of certainty in the conclusion drawn from the model set. This metric does not tell us whether that conclusion is biased however -- I may be very certain about the wrong model. Measuring bias is tricky; for the start, I will look at a calibration curve -- a plot of the fitted values from a model or models against the observations. If all is well, this curve should be a straight line with a slope of one and an intercept of zero. Standardizing the intercept and slope of the calibration curve with the estimated standard errors will provide two metrics that should have means of zero and variances of one if the model selection procedure is producing unbiased conclusions. 

![A sample dataset from the baseline scenario with $N=2m=64$.](figure/easy1-1.png) <!-- html table generated in R 3.3.0 by xtable 1.7-4 package -->
<!-- Wed May 25 09:20:47 2016 -->
<table border=1>
<caption align="top"> Output of a linear model with all 5 predictor variables included for a single sample from the baseline scenario. </caption>
<tr> <th>  </th> <th> Estimate </th> <th> Std. Error </th> <th> t value </th> <th> Pr(&gt;|t|) </th>  </tr>
  <tr> <td align="right"> (Intercept) </td> <td align="right"> 0.1759 </td> <td align="right"> 0.1367 </td> <td align="right"> 1.29 </td> <td align="right"> 0.2033 </td> </tr>
  <tr> <td align="right"> X.1 </td> <td align="right"> 0.7572 </td> <td align="right"> 0.1339 </td> <td align="right"> 5.65 </td> <td align="right"> 0.0000 </td> </tr>
  <tr> <td align="right"> X.2 </td> <td align="right"> 0.7181 </td> <td align="right"> 0.1457 </td> <td align="right"> 4.93 </td> <td align="right"> 0.0000 </td> </tr>
  <tr> <td align="right"> X.3 </td> <td align="right"> 0.3802 </td> <td align="right"> 0.1328 </td> <td align="right"> 2.86 </td> <td align="right"> 0.0058 </td> </tr>
  <tr> <td align="right"> X.4 </td> <td align="right"> -0.1788 </td> <td align="right"> 0.1713 </td> <td align="right"> -1.04 </td> <td align="right"> 0.3011 </td> </tr>
  <tr> <td align="right"> X.5 </td> <td align="right"> 0.0483 </td> <td align="right"> 0.1154 </td> <td align="right"> 0.42 </td> <td align="right"> 0.6772 </td> </tr>
   </table>

A single sample from the baseline scenario has clear relationships between $Y$ and $X_1$ (Figure ). Fitting a linear model with all 5 variables is more revealing, but even then only the first 3 variables have clear effects ([Table 2](#lm0)). Dupont and Balmer (1998) provided formulas to calculate the [power of rejecting the hypothesis that $\beta_1 = 0$ for single linear regression](#fig:powerCurve). This power is only an upper bound for the baseline case which includes the effects of other variables as well. The addition of other variables means that the residual error is actually larger, and hence the power lower, if I fit a single variable model to the same data.     
![Power $(1-\beta)$ to reject the hypothesis that $\beta_1 = 0$ for different effect sizes and sample sizes of $m$, $2m$, and $3m$. The red dots indicate the effect sizes in the baseline scenario.](figure/powerCurve-1.png) 




All the code for this post, including that not shown, [can be found here](https::/github.com/atyre2/atyre2.github.io/_drafts/post-template.Rmd).
