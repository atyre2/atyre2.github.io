I'm missing something so fundamental here -- why does augment work with
one model but not another?

    data(iris)
    library(broom)

    iris$cSepal.Length <- scale(iris$Sepal.Length, center = TRUE, scale = FALSE)
    nd <- expand.grid(Sepal.Length = seq(4, 8, 0.1), Species = factor(levels(iris$Species)))
    nd$cSepal.Length <- nd$Sepal.Length - mean(iris$Sepal.Length)

    m0 <- lm(Sepal.Width ~ Sepal.Length * Species, data = iris)
    pred.0 <- augment(m0, newdata = nd)
    m1 <- lm(Sepal.Width ~ cSepal.Length * Species, data = iris)
    pred.1 <- augment(m1, newdata = nd)

    ## Error in data.frame(..., check.names = FALSE): arguments imply differing number of rows: 123, 150

    sessionInfo()

    ## R version 3.3.1 (2016-06-21)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 10586)
    ## 
    ## locale:
    ## [1] LC_COLLATE=English_United States.1252 
    ## [2] LC_CTYPE=English_United States.1252   
    ## [3] LC_MONETARY=English_United States.1252
    ## [4] LC_NUMERIC=C                          
    ## [5] LC_TIME=English_United States.1252    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] broom_0.4.1         RevoUtilsMath_8.0.3
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.6      knitr_1.11       magrittr_1.5     mnormt_1.5-4    
    ##  [5] lattice_0.20-33  R6_2.1.2         stringr_1.0.0    plyr_1.8.4      
    ##  [9] dplyr_0.5.0      tools_3.3.1      parallel_3.3.1   grid_3.3.1      
    ## [13] nlme_3.1-128     psych_1.6.6      DBI_0.4-1        htmltools_0.2.6 
    ## [17] yaml_2.1.13      assertthat_0.1   digest_0.6.8     tibble_1.1      
    ## [21] reshape2_1.4.1   formatR_1.4      tidyr_0.5.1      evaluate_0.7.2  
    ## [25] rmarkdown_0.9.5  stringi_1.1.1    RevoUtils_10.0.1
