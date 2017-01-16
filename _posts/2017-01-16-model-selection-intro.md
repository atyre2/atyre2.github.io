--- 
layout: post 
title:  Model selection and the art of evidence I 
published: false 
tags: [statistics, model selection] 
bibliography: references.bib
---


I think of science as a reliable way of gaining knowledge about the nature of reality. Ecology in particular is knowledge about the distribution and abundance of organisms. Over the decades that ecology has been practiced as a distinct science there have been at least 2 broad paradigm shifts in how evidence for or against a particular view of reality is accumulated. The first shift occurred in the late 1960's with [testing specific hypotheses using statistics][therevolution]. The latest shift involved the use of Information Theoretic methods of evaluating multiple hypotheses with a given set of data. Not everyone is on board with this second shift. 

There are many papers on using AIC (cite Richards, arnolds), and other papers evaluating how to use hypothesis testing, but very few papers combining the two approaches. I think this reflects the partisan stance of most statisticians. People are developing information theory, or Bayesian methods, or clinging to frequentist methods. There seem to be few people looking at ecology and asking what is best for ecologists, philosophers be damned. Ecologists have some unique issues with peculiar goals not shared by many other scientists. In particular, fitting observation error models (e.g. mark-recapture, occupancy, N-mixture models) often involves model selection over two distinct processes. There is the process of interest, which is population size, occupancy or survival, and then there is the process of detection. Mixed models are another 2-stage model with variation in both random and fixed effects structures. There is very little guidance on how to proceed in these cases, which means that ecologists start making shit up.[^aside] In particular, a common strategy is to evaluate models for detection or random effect while using a constant model for the ecological process, and then use the top detection/random effects model while evaluating the set of process models. 

What's wrong with that approach, if anything? My expectation is that these 2 stage model selection approaches will badly underestimate the degree of uncertainty associated with the final selected models. Even if the entire set of process models is retained using model averaging, none of the uncertainty associated with selection of the detection model is incorporated into calculations of the unconditional variance. I also don't know how the structure of the two models interacts with the selection process. I imagine a more complex random effects model combined with a particular simple fixed effects model could outperform the combination of the global fixed effects model and a simpler random effect. I just don't know. 

[^aside]: Blogging can be so much more expressive than journal articles! 

Read and comment on the literature in /ecological statistics/readings/p values
Giam and olden 2015 variable selection uncertainty
Fieberg and johnson 2015
Hooten et al 2015 Bayesian model selection 
Doherty et al 2010 comparison of model selection strategies.
Cade 2015 muddled multimodel inference
Lukacs etal 2010 model selection bias and freedman's paradox.
Paper by fahrig and coauthors on effects of multicollinearity.

A paper by Paul Doherty and friends [-@Doherty2012] for mark recapture modelling is the only guidance for two stage models I am aware of. They described three broad strategies. The $\phi$ first strategy evaluates models for survival while using a global model for capture probability $p$, then uses the top survival model while evaluating capture rate. The $p$ first strategy reverses the first strategy. Finally, the "all models" strategy evaluates the entire set of models for both $\phi$ and $p$ simultaneously. They compared these three strategies on estimator bias and precision and measures of variable importance. They concluded that the "all models" strategy was superior in all regards. The extent to which these conclusions apply to other 2 stage models is unknown. In addition, they only used AIC model selection, and did not compare that against other methods for model selection, including doing no model selection at all! 

Finally, ecologists in general have failed to recognize that there are alternative statistical objectives, and the best tool for achieving one goal may not be the best tool for all.

[therevolution]: https://dynamicecology.wordpress.com/2016/05/23/making-modern-ecology-mercer-award-winners-during-the-1950s-and-1960s/

Leo Breiman [-@breiman2001] introduced the idea that there are two cultures in statistics - hypothesis testing and prediction. In hypothesis testing, knowledge is built by identifying the simplest hypothesis consistent with a given set of data. This culture focuses on identifying key variables driving a particular response. In contrast, the prediction culture simply aims to predict a response; which variables are important is usually of secondary importance. These two cultures use different statistical tools. Null hypothesis testing is the domain of hypothesis testing, while prediction focuses on measures of predictive performance, especially the ability to predict independent data points. 

Frank Harrell [-@Harrell2001] added a 3rd "statistical goal" to prediction and hypothesis testing: effect estimation. That is, estimate the change in a response variable for a given change in a predictor variable. In addition, there should be an estimate of the uncertainty in this effect such as a confidence interval of some sort. I think this goal is particularly important for applied ecology. If we want to choose between two management options an estimate of the effect of each option is exactly what is required. Even if the two options represent different levels of the same predictor variable, the estimated effect size is needed to understand tradeoffs against other objectives. It might appear that estimation is the same goal as hypothesis testing, but I agree with Harrell that it is unique. In particular, a hypothesis test is not concerned with accurate estimation of the effect size. Rather the focus is on determining if a given variable or set of variables are statistically significant. Thus we have 3 goals for statistical analysis: prediction, estimation, and hypothesis testing.

Data in science arise from two broad forms - manipulative experiments and observation. The former provides the strongest evidence for causation, because one or two variables are manipulated while holding others constant, or at least randomizing variation in all other variables across the experimental units. In contrast, observation of a response across a range of observational units provides much less evidence in favor of causation, because it is always possible that two observed variables are simply correlated because they both share an unmeasured causal variable. Many sciences, including much of ecology, are forced to rely on observation because the units of interest (e.g. ecosystems, species distributions, animal populations) are simply too extensive in space and/or time to manipulate. 

Combining the two sources of data with the three goals of statistics provides us with [a 2 way table](#typology). I've filled in the table with my thoughts on the most appropriate tool for each combination. I should point out that I am not certain of any of the things I've put in the table. These posts are my way of "thinking out loud". I hope that some readers may have useful insights to contribute. 
The particular focus of this series of blog posts are the top row of cells - observational data. I think it is important to think about your location in this table. I believe misplacing the goal results in the inappropriate application of statistical techniques, flawed model selection procedures, and ultimately, compromised scientific inference. So come and have a look with me.

<!-- html table generated in R 3.3.2 by xtable 1.7-4 package -->
<!-- Mon Jan 16 08:05:11 2017 -->
<table border=1>
<caption align="top"> The combination of data source and inferential goal yields a 2 x 3 table of commonly used methods. The cells marked with * are not typically observed. </caption>
  <tr> <td>   </td> <td> Prediction </td> <td> Estimation </td> <td> Hypothesis Testing </td> </tr>
   <tr> <td> Observation </td> <td> Cross Validation </td> <td> AIC </td> <td> AIC </td> </tr>
  <tr> <td> Experiment </td> <td> * </td> <td> * </td> <td> Backwards Selection </td> </tr>
   </table>



[^allthecode]: All the code for this post, including that not shown, [can be found here](https::/github.com/atyre2/atyre2.github.io/blob/master/_drafts/model-selection-intro.Rmd).

## Literature cited
