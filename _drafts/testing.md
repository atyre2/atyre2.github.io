---
title: "Sex ratio in chickens"
author: "Drew Tyre"
date: "April 20, 2016"
---

I got the following email the other day

> I’m trying to find the answer to a pretty simple question, but I’m having a hard time finding a reputable source online, so I Googled "best ornithology schools" and you all popped up! I’m wondering if the sex ratio for egg-laying chickens is about equal, 1 male chick : 1 female chick born.

Obviously a fan! I tried the same search and I must say we didn't exactly pop to the top.

I searched 'sex ratio chickens' and the first link 
was [Hays (1945)][hays1945]. From *The American Naturalist* no less, so a peer reviewed journal and a credible source. In the introduction he summarizes a range of previous sources with estimates varying from 48.77 \% males to 51.38 \% males. So approximately 50/50. In his own work (which is behind a paywall so not publicly available) he reports 49.7 \% males. His methods were

> In the ten-year period from 1935 to 1944 a total of 39 pure-
> bred Rhode Island Red females mated to pure-bred Rhode Island
> Red males qualified for study. Each female had a perfect record
> in fertility and hatchability and produced ten or more chicks
> during March and April

This is 1945, so statistics are largely absent. He does suggest that the standard error of the difference between yearly sex ratios and 50 \% is 1.42. I think that's just treating each year as a single observation. But the data are given. 


| Year| # of Dams| # of Male Chicks| # of Female Chicks| Sex not determined|
|----:|---------:|----------------:|------------------:|------------------:|
| 1944|         8|               70|                 78|                  9|
| 1943|         4|               43|                 45|                  9|
| 1942|         0|               NA|                 NA|                 NA|
| 1941|         4|               51|                 47|                  3|
| 1940|         6|               92|                 85|                  5|
| 1939|         5|               50|                 48|                 10|
| 1938|         3|               29|                 28|                  3|
| 1937|         2|               22|                 22|                  4|
| 1936|         3|               21|                 34|                 14|
| 1935|         4|               54|                 51|                  4|

So treating each year as a normally distributed observation I get


```r
sexratio <- with(table1, 100 * Males / (Females + Males))
sd(sexratio - 50, na.rm = TRUE) / sqrt(9)
```

```
## [1] 1.45542
```

```r
t.test(sexratio - 50)
```

```
## 
## 	One Sample t-test
## 
## data:  sexratio - 50
## t = -0.63463, df = 8, p-value = 0.5434
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  -4.279855  2.432553
## sample estimates:
##  mean of x 
## -0.9236509
```

So I get a slightly different standard error, but either way it isn't significantly different from 50 \%. However this is ignoring a huge amount of information in this data.
For example, one thing that's cool is the variation between years.


```r
library(lme4)
year.model <- glmer(cbind(Males,Females)~1 + (1|Year), data = table1, family=binomial)
summary(year.model)
```

```
## Generalized linear mixed model fit by maximum likelihood (Laplace
##   Approximation) [glmerMod]
##  Family: binomial  ( logit )
## Formula: cbind(Males, Females) ~ 1 + (1 | Year)
##    Data: table1
## 
##      AIC      BIC   logLik deviance df.resid 
##     52.5     52.9    -24.2     48.5        7 
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -1.7018 -0.1485  0.1845  0.3634  0.6179 
## 
## Random effects:
##  Groups Name        Variance Std.Dev.
##  Year   (Intercept) 0        0       
## Number of obs: 9, groups:  Year, 9
## 
## Fixed effects:
##             Estimate Std. Error z value Pr(>|z|)
## (Intercept) -0.01379    0.06781  -0.203    0.839
```

So same conclusion as before. The intercept is not significantly different from 0, which is what we expect for 50/50 sex ratio. In addition, there's no evidence of significant variation between years. The estimated random effect variance is zero. 

Hays also has a table of data for 11 hens with complete records of sex of chick. The sex ratio there extends from 22 \% up to 65 \%! So repeating the same thing




```r
ind.model <- glmer(cbind(Males,Females)~1 + (1|Hen), data = table2, family=binomial)
summary(ind.model)
```

```
## Generalized linear mixed model fit by maximum likelihood (Laplace
##   Approximation) [glmerMod]
##  Family: binomial  ( logit )
## Formula: cbind(Males, Females) ~ 1 + (1 | Hen)
##    Data: table2
## 
##      AIC      BIC   logLik deviance df.resid 
##     71.7     72.5    -33.9     67.7        9 
## 
## Scaled residuals: 
##      Min       1Q   Median       3Q      Max 
## -0.70263 -0.17421 -0.02554  0.04426  0.94412 
## 
## Random effects:
##  Groups Name        Variance Std.Dev.
##  Hen    (Intercept) 0.7791   0.8827  
## Number of obs: 11, groups:  Hen, 11
## 
## Fixed effects:
##             Estimate Std. Error z value Pr(>|z|)
## (Intercept)   0.2053     0.2978   0.689    0.491
```

Again, the intercept is not significantly different from zero, so across the entire population the average sex ratio is not different from 50/50. However here we do see a non-zero variance between hens. Individual hens may have sex ratios that deviate from 50/50. It's a bit hard to interpret that standard deviation because it is on a log-odds scale. 
[hays1945]: http://www.jstor.org/stable/2458081 "The primary sex ratio in domestic chickens"
