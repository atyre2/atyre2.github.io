--- 
layout: post 
title:  Should I use sum-to-zero contrasts? 
published: true 
tags: [keyword1, keyword2] 
---

A sum-to-zero contrast codes a categorical variable as deviations from a grand mean. Social scientists use them extensively. Should ecologists?

Sum-to-zero contrasts are conceptually similar to centering a continuous variable by subtracting the mean from your predictor variable prior to analysis. Discussions of centering often end up conflated with *scaling*, which is dividing your predictor variable by a constant, usually the standard deviation, prior to analysis. I understand that *always scaling* covariates prior to regression analysis is controversial advice. See for example [Andrew Gelman's blogpost and comments](http://andrewgelman.com/2009/07/11/when_to_standar/), or many crossvalidated questions [such as this one](http://stats.stackexchange.com/q/29781/12258) which has links to many others. There is a good reference as well as some useful discussion in the comments of [this question](http://stats.stackexchange.com/questions/179732/motivation-to-center-continuous-predictor-in-multiple-regression-for-sake-of-mul). I want to ask *only about centering*, and in particular discuss the effects of sum to zero contrasts for categorical variables and interactions.[^allthecode]



Here is my summary of the pros and cons of centering drawn from those references above.[^CVpost]

* Centering continuous variables eliminates collinearity between 
    interaction and polynomial terms and the individual covariates 
    that make them up.
* Centering does not affect inference about the covariates.
* Centering can improve the interpretability of the coefficients in
    a regression model, particularly because the intercept
    represents the value of the response at the mean of the 
    predictor variables.
* Predicting out of sample data with a model fitted to centered 
    data must be done carefully because the center of the out of
    sample data will be different from the fitted data.
* There may be some constant value other than the sample mean
    that makes more sense based on domain knowledge.

To make the discussion concrete, let me demonstrate with an example of the interaction between a continuous covariate and a categorical one. In the following I refer to the effect of individual covariates outside the interaction as the "simple effect" of that covariate.



{% highlight r %}
    data(iris)
    m0 <- lm(Sepal.Width~Sepal.Length*Species,data=iris)
    (summary_m0 <- summary(m0))
{% endhighlight %}



{% highlight text %}
## 
## Call:
## lm(formula = Sepal.Width ~ Sepal.Length * Species, data = iris)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.72394 -0.16327 -0.00289  0.16457  0.60954 
## 
## Coefficients:
##                                Estimate Std. Error t value Pr(>|t|)
## (Intercept)                     -0.5694     0.5539  -1.028 0.305622
## Sepal.Length                     0.7985     0.1104   7.235 2.55e-11
## Speciesversicolor                1.4416     0.7130   2.022 0.045056
## Speciesvirginica                 2.0157     0.6861   2.938 0.003848
## Sepal.Length:Speciesversicolor  -0.4788     0.1337  -3.582 0.000465
## Sepal.Length:Speciesvirginica   -0.5666     0.1262  -4.490 1.45e-05
##                                   
## (Intercept)                       
## Sepal.Length                   ***
## Speciesversicolor              *  
## Speciesvirginica               ** 
## Sepal.Length:Speciesversicolor ***
## Sepal.Length:Speciesvirginica  ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.2723 on 144 degrees of freedom
## Multiple R-squared:  0.6227,	Adjusted R-squared:  0.6096 
## F-statistic: 47.53 on 5 and 144 DF,  p-value: < 2.2e-16
{% endhighlight %}

The intercept of this model isn't directly interpretable because it gives the average width at a length of zero, which is impossible. In addition, both the intercept and simple effect of length represent the change in width for only one species, setosa. Centering the continuous variable gives us



{% highlight r %}
    iris$cSepal.Length <- scale(iris$Sepal.Length,center=TRUE,scale=TRUE)
    m1 <- lm(Sepal.Width~cSepal.Length*Species,data=iris)
    (summary_m1 <- summary(m1))
{% endhighlight %}



{% highlight text %}
## 
## Call:
## lm(formula = Sepal.Width ~ cSepal.Length * Species, data = iris)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.72394 -0.16327 -0.00289  0.16457  0.60954 
## 
## Coefficients:
##                                 Estimate Std. Error t value Pr(>|t|)
## (Intercept)                       4.0966     0.1001  40.916  < 2e-16
## cSepal.Length                     0.6612     0.0914   7.235 2.55e-11
## Speciesversicolor                -1.3563     0.1075 -12.616  < 2e-16
## Speciesvirginica                 -1.2953     0.1166 -11.114  < 2e-16
## cSepal.Length:Speciesversicolor  -0.3965     0.1107  -3.582 0.000465
## cSepal.Length:Speciesvirginica   -0.4692     0.1045  -4.490 1.45e-05
##                                    
## (Intercept)                     ***
## cSepal.Length                   ***
## Speciesversicolor               ***
## Speciesvirginica                ***
## cSepal.Length:Speciesversicolor ***
## cSepal.Length:Speciesvirginica  ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.2723 on 144 degrees of freedom
## Multiple R-squared:  0.6227,	Adjusted R-squared:  0.6096 
## F-statistic: 47.53 on 5 and 144 DF,  p-value: < 2.2e-16
{% endhighlight %}

Although the coefficients change because now the model estimates the differences between the species at the mean length, the t-statistics for the continuous covariate, including the interaction terms, do not change. The t-statistics for the intercept and simple effect of species do change (see Q1 below).


{% highlight r %}
    zapsmall(summary_m1$coefficients[,3] - summary_m0$coefficients[,3])
{% endhighlight %}



{% highlight text %}
##                     (Intercept)                   cSepal.Length 
##                        41.94445                         0.00000 
##               Speciesversicolor                Speciesvirginica 
##                       -14.63795                       -14.05196 
## cSepal.Length:Speciesversicolor  cSepal.Length:Speciesvirginica 
##                         0.00000                         0.00000
{% endhighlight %}


What happens if we use sum to zero contrasts for species?



{% highlight r %}
    iris$szSpecies <- iris$Species
    contrasts(iris$szSpecies) <- contr.sum(3)
    m2 <- lm(Sepal.Width~cSepal.Length*szSpecies,data=iris)
    (summary_m2 <- summary(m2))
{% endhighlight %}



{% highlight text %}
## 
## Call:
## lm(formula = Sepal.Width ~ cSepal.Length * szSpecies, data = iris)
## 
## Residuals:
##      Min       1Q   Median       3Q      Max 
## -0.72394 -0.16327 -0.00289  0.16457  0.60954 
## 
## Coefficients:
##                          Estimate Std. Error t value Pr(>|t|)    
## (Intercept)               3.21278    0.04098  78.395  < 2e-16 ***
## cSepal.Length             0.37267    0.04057   9.185 4.11e-16 ***
## szSpecies1                0.88386    0.07086  12.473  < 2e-16 ***
## szSpecies2               -0.47240    0.04680 -10.094  < 2e-16 ***
## cSepal.Length:szSpecies1  0.28857    0.06656   4.335 2.72e-05 ***
## cSepal.Length:szSpecies2 -0.10792    0.05426  -1.989   0.0486 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.2723 on 144 degrees of freedom
## Multiple R-squared:  0.6227,	Adjusted R-squared:  0.6096 
## F-statistic: 47.53 on 5 and 144 DF,  p-value: < 2.2e-16
{% endhighlight %}

I can now directly interpret the intercept as the average width at the average length, averaged over species. Similarly the simple effect of length as the change in width averaged across species. This seems like a very useful set of coefficients to look at, particularly if my categorical covariate has many levels. 

I have seen assertions in some papers (particularly from social sciences), that using sum to zero contrasts (also called effects coding, I believe), allows the direct interpretation of lower order terms in an ANOVA table even in the presence of interactions. 


{% highlight r %}
    anova(m2) # doesn't matter which model I use
{% endhighlight %}



{% highlight text %}
## Analysis of Variance Table
## 
## Response: Sepal.Width
##                          Df  Sum Sq Mean Sq  F value    Pr(>F)    
## cSepal.Length             1  0.3913  0.3913   5.2757   0.02307 *  
## szSpecies                 2 15.7225  7.8613 105.9948 < 2.2e-16 ***
## cSepal.Length:szSpecies   2  1.5132  0.7566  10.2011  7.19e-05 ***
## Residuals               144 10.6800  0.0742                       
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
{% endhighlight %}

If so, in this case I could say "Sepal Width differs significantly between species." 

Explaining treatment contrasts to students is a pain. I'm not sure that these are any easier, but it certainly seems like there are good arguments for centering and using sum-to-zero contrasts more widely in Ecology.

[^allthecode]: All the code for this post, including that not shown, [can be found here](https::/github.com/atyre2/atyre2.github.io/blob/master/_drafts/sum-to-zero-contrasts.Rmd).

[^CVpost]: This stuff first appeared [as a question on CrossValidated](http://stats.stackexchange.com/questions/188852/centering-in-the-presence-of-interactions-with-categorical-predictors), but received no attention. 
